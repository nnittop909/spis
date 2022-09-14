
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

port ENV.fetch("PORT") { 3000 }

environment "development" 

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart


# which puma "/home/deploy/.rbenv/shims/puma"

# environment ENV['RAILS_ENV'] || 'production'

# bind  'unix:///home/deploy/spis/shared/tmp/sockets/puma.sock'
# pidfile '/home/deploy/spis/shared/tmp/pids/puma.pid'
# state_path '/home/deploy/spis/shared/tmp/sockets/puma.state'
# directory '/home/deploy/spis/current'

# workers 2
# threads 1,2

# stdout_redirect '/home/deploy/spis/shared/log/puma.stdout.log', '/home/deploy/spis/shared/log/puma.stderr.log'
# activate_control_app 'unix:///home/deploy/spis/shared/tmp/sockets/pumactl.sock'

# prune_bundler

# ------------------------------------------------------------

# puma.service

# [Unit]
# Description=Puma HTTP Server
# After=network.target

# [Service]
# Type=simple
# User=deploy
# WorkingDirectory=/home/deploy/spis/current
# ExecStart=/home/deploy/.rbenv/shims/puma -e production -C /home/deploy/spis/shared/config/puma.rb
# ExecStop=/home/deploy/.rbenv/shims/puma exec bundle exec pumactl -S /home/deploy/spis/shared/tmp/pids/puma.state stop
# Restart=always

# [Install]
# WantedBy=multi-user.target