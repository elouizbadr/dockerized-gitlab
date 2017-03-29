#!/bin/bash
set -e

# Edit supervisord config file 
cat > /etc/supervisor/supervisord.conf<<EOF
[supervisord]
nodaemon=true

[program:gitlab]
priority=1
command=./start-gitlab.sh
startsecs=0

EOF


# Create a script to start GitLab instance
cat > ./start-gitlab.sh<<EOF
#!/bin/bash
set -e
# To workaround "ruby_block" hanging problem!
/opt/gitlab/embedded/bin/runsvdir-start &

# Now reconfiguring GitLab instance
gitlab-ctl reconfigure
EOF

chmod +x ./start-gitlab.sh


# Launch supervisord
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
