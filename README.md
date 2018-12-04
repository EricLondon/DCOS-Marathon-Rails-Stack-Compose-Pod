# DCOS, Marathon, Rails, Stack, Compose, Pod

```

####################################################################################################

Install dcos-e2e

# check docker version
$ docker --version
Docker version 18.09.0, build 4d60db4

# install via brew
# NOTE: application recently renamed to minidcos docker, these docs may be slightly outdated
$ brew install --HEAD https://raw.githubusercontent.com/dcos/dcos-e2e/master/dcose2e.rb

# run doctor to check setup
$ dcos-docker doctor
# example:
Warning: Cannot connect to a Docker container by its IP address. This is needed for features such as connecting to the web UI and using the DC/OS CLI. To use the "wait" command without resolving this issue, use the "--skip-http-checks" flag on the "wait" command. We recommend using "dcos-docker setup-mac-network" to resolve this issue.

# run mac network setup
# NOTE: I used Tunnelblick
$ dcos-docker setup-mac-network

1. Install an OpenVPN client such as Tunnelblick (https://tunnelblick.net/downloads.html) or Shimo (https://www.shimovpn.com).
2. Run "open /Users/eric/Documents/docker-for-mac.ovpn".
3. If your OpenVPN client is Shimo, edit the new "docker-for-mac" profile's Advanced settings to deselect "Send all traffic over VPN".
4. In your OpenVPN client, connect to the new "docker-for-mac" profile.
5. Run "dcos-docker doctor" to confirm that everything is working.

# download dcos installer (new file: /tmp/dcos_generate_config.sh)
$ dcos-docker download-artifact

# create dcos cluster
# note: the newline before default (ie: copy/paste both lines into terminal)
dcos-docker create /tmp/dcos_generate_config.sh --agents 4
default

# wait for cluster
$ dcos-docker wait --cluster-id default

# run web interface
$ dcos-docker web

# authenticate and follow steps
$ dcos auth login

####################################################################################################

# Deploy Rails stack to Pod

# build and push docker images to dockerhub
$ ./build-images.sh ericlondon

# add pod to marathon
$ dcos marathon pod add rails-stack-pod.json

# show dcos tasks
$ dcos task
NAME      HOST        USER  STATE  ID                                                                  MESOS ID                                 REGION  ZONE
api       172.17.0.6  root    R    rails-stack.instance-f5e0dad5-f723-11e8-b627-70b3d5800001.api       90071a37-1d01-44a0-abb8-a8b749aca8d7-S2   ---    ---
nginx     172.17.0.6  root    R    rails-stack.instance-f5e0dad5-f723-11e8-b627-70b3d5800001.nginx     90071a37-1d01-44a0-abb8-a8b749aca8d7-S2   ---    ---
postgres  172.17.0.6  root    R    rails-stack.instance-f5e0dad5-f723-11e8-b627-70b3d5800001.postgres  90071a37-1d01-44a0-abb8-a8b749aca8d7-S2   ---    ---

# request endpoint
$ service_ip=$(dcos task | egrep -i "nginx.*rails-stack" | awk '{print $2}')
$ curl http://$service_ip/api/people 2>/dev/null | jq '.[0]'
{
  "id": 1,
  "first_name": "Lindsay",
  "last_name": "Price",
  "created_at": "2018-12-03T17:51:20.550Z",
  "updated_at": "2018-12-03T17:51:20.550Z"
}
```
