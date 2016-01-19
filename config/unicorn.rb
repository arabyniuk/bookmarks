working_directory File.expand_path("../..", __FILE__)

worker_processes 2

working_directory "/var/www/apps/bookmarks/current" # available in 0.94.0+

listen "/var/www/apps/bookmarks/socket/.unicorn.sock", :backlog => 64
listen 8080, :tcp_nopush => true

timeout 30

pid "/var/www/apps/bookmarks/run/unicorn.pid"


stderr_path "/var/www/apps/bookmarks/log/unicorn.stderr.log"
stdout_path "/var/www/apps/bookmarks/log/unicorn.stdout.log"

