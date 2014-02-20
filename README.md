# Foyer

Authentication layer for Rails apps that identify users via a single
sign on server that is configured as an OmniAuth provider

## Installation

`gem 'foyer'`

## Setup and Configuration

In your ApplicationController:

```ruby
class ApplicationController < ActionController::Base
  include Foyer::Controller::Helpers

  set_user_finder do |user_id|
    # Code for retrieving a user from your database here
    # e.g.:
    #
    #  User.find_by_id(user_id)
  end
end
```

You can also configure the user finder in an initializer:
```ruby
# config/initializers/foyer.rb
Foyer.user_finder = lambda { |user_id| ... }
```

Besiders `.user\_finder` there are some additional configuration
settings:

```ruby
Foyer.identity_provider # The slug name of the omniauth provider your app uses
Foyer.session_key # The key where Foyer will store user data in the session
```

Currently, the session is the only store available.

## Usage

### In Controllers

Once the setup is complete, you will have the following methods available in
controllers that include `Foyer::Controller::Helpers`:
```
authenticate\_user! - Before filter that redirects unauthenticated users 
                      to omniauth

sign_in(user) - Pass a user object to this method to sign that user in.
                User object must respond to #id

current_user - The authenticated user or nil if no user is authenticated

user_signed_in? - Predicate method to test if a user is authenticated

user_session - Access the current user's session data

sign_out - Signs out the authenticated user by clearing the session
```

### In Views

`current\_user` and `user\_signed\_in?` are available as helper methods
in views.

### Routes

This gem sets up a routing helper `authenticate` which allows you to set a
constraint on routes so that only logged in users can access them.
Example:

```ruby
Rails.application.routes.draw do
  authenticate do
    get :some_page, to: 'authenticated_users#some_page'
  end
  get :some_page, to: 'unauthenticated_users#some_page'
end
```

`authenticate` also accepts a `guard` as an optional argument. The
`guard` should be a lambda that accepts 1 argument, the authenticated
user.  Example:

```ruby
Rails.application.routes.draw do
  authenticate lambda { |u| u.admin? } do
    namespace :admin do
      ...
    end
  end
end
```

### Omniauth Callbacks Controller

For convience, there is a `Foyer::OmniauthCallbacksController` that
includes the `Controller::Helpers` plus some additional useful helpers.
You can inherit from it in your application.

Example:
```ruby
class FoyerIdentityProviderController < ProviderAuthenticateable::OmniauthCallbacksController
  def callback
    user = User.find_or_initialize_by(uid: auth_hash.uid.to_s) do |u|
      u.email = auth_hash.info.email
    end

    user.token = auth_hash.credentials.token
    user.refresh_token = auth_hash.credentials.refresh_token

    if user.new_record?
      redirect_to origin || welcome_path
    else
      redirect_to after_sign_in_path
    end

    user.save
    sign_in user
  end
end
```


## Contributing

1. Fork it ( http://github.com/GaggleAMP/foyer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
