
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

port ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart


# environment "production"

# bind  "unix:/home/production/spis/shared/tmp/sockets/puma.sock"
# pidfile "/home/production/spis/shared/tmp/pids/puma.pid"
# state_path "/home/production/spis/shared/tmp/sockets/puma.state"
# directory "/home/production/spis/current"

# workers 2
# threads 1,2

# daemonize true

# stdout_redirect "/home/production/spis/shared/log/puma.stdout.log", "/home/rails-demo/app/shared/log/puma.stderr.log"
# activate_control_app 'unix:/home/production/spis/shared/tmp/sockets/pumactl.sock'

# prune_bundler