# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_jdbmigrate_session',
  :secret      => 'a754d68e9bcd357ec5ca02f0818384f2a382f602dac6a0971e9f56faf27fe6ee0536e126e8dbcf0248c2dc817cce3d9775945aa5e979ff5c2e836128ff162b7f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
