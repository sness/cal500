# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cal500_session',
  :secret      => 'dde5875be664cb9c7dec9e6efcab1654b57300a08f4ad0d00ebb73f1ac5d7a2695ac575a3daa8be329c0b5f11b4d1032d685ea96ea6d5b9f56716d132c83874b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
