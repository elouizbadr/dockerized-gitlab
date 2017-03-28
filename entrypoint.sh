#!/bin/bash
set -e

cat > /etc/supervisor/supervisord.conf<<EOF
[supervisord]
nodaemon=true

[program:startup]
priority=1
command=./start-gitlab.sh
startsecs=0

EOF

cat > ./start-gitlab.sh<<EOF
#!/bin/bash
set -e
# To workaround "ruby_block" hanging problem!
/opt/gitlab/embedded/bin/runsvdir-start &

# Now reconfiguring GitLab instance
gitlab-ctl reconfigure
EOF

chmod +x ./start-gitlab.sh

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
