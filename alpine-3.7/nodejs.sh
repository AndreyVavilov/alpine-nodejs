#!/bin/sh -ex

apk add --no-cache nodejs

# Cleanup
rm -rf /usr/share/man /tmp/* /var/cache/apk/* \
    /root/.npm /root/.node-gyp /root/.gnupg /usr/lib/node_modules/npm/man \
    /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts

# Check
which node

# History cleanup
cat /dev/null > ~/.ash_history
history -c
