# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_storylines_session',
  :secret      => '379cbd5f1af98e67c47b8109de95ba1fdebb6c55d17c58edd5f1487b99f254330e54b3c4415f4dd66a00e759ff01eefbddb80c2e750d803cd4139015c4084880'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
