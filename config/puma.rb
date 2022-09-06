environment "production"

bind  "unix:/home/production/spis/shared/tmp/sockets/puma.sock"
pidfile "/home/production/spis/shared/tmp/pids/puma.pid"
state_path "/home/production/spis/shared/tmp/sockets/puma.state"
directory "/home/production/spis/current"

workers 2
threads 1,2

daemonize true

stdout_redirect "/home/production/spis/shared/log/puma.stdout.log", "/home/rails-demo/app/shared/log/puma.stderr.log"
activate_control_app 'unix:/home/production/spis/shared/tmp/sockets/pumactl.sock'

prune_bundler