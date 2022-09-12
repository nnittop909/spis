
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


# which puma "/home/spsec/.rbenv/shims/puma"

# environment "production"

# app_dir = "/home/deploy/spis"
# shared_tmp_dir = "#{app_dir}/shared/tmp"
# shared_log_dir = "#{app_dir}/shared/log"

# bind  "unix://#{shared_tmp_dir}/sockets/puma.sock"
# pidfile "#{shared_tmp_dir}/pids/puma.pid"
# state_path "#{shared_tmp_dir}/sockets/puma.state"
# directory "#{app_dir}/current"

# workers 2
# threads 1,2

# stdout_redirect "#{shared_log_dir}/puma.stdout.log", "#{shared_log_dir}/puma.stderr.log"
# activate_control_app 'unix://#{shared_tmp_dir}/sockets/pumactl.sock'

# prune_bundler

# ------------------------------------------------------------

# puma.service

# [Unit]
# Description=Puma HTTP Server
# After=network.target

# [Service]
# Type=simple
# User=spsec
# WorkingDirectory=/home/deploy/spis/current
# Environment=RAILS_ENV=production

# ExecStart=/home/spsec/.rbenv/shims/puma -e production -C /home/deploy/spis/shared/config/puma.rb
# Restart=always
# KillMode=process

# [Install]
# WantedBy=multi-user.target