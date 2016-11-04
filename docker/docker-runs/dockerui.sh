#/bin/bash
docker run -d -p 9000:9000 -name docker-ui --privileged -v /var/run/docker.sock:/var/run/docker.sock uifd/ui-for-docker
