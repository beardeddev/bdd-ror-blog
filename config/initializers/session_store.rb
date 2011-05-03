# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_simpleblog_session',
  :secret      => '36f04d6787dcf896d1b2401d878db222fa6b993c371898fd6719e8d1346bb6516095c37f6b6864725d00829612be99f768f5ca87443f5be8f6e7e3f028739851'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
