# Dockerscripts
In the "docker-runs" folder you'll find various bash files with the "docker run ...." command in them, these are basic install scripts

The other folders are product specific (for example Elasticsearch) and will include all scripts needed to run the docker.

[TOC]

## Installing docker
** This install guide will show you how to install docker on a Ubuntu machine running with systemd. (Arch users have everything available in the repo)**

Before installing anything we have to update our package database. We can do so by running the following command:

```
sudo apt-get update
```

#### Installing docker from the Ubuntu repositories
The following command will install docker from the Ubuntu repositories (might not be the latest):
```
sudo apt-get install -y docker-engine
```

#### Installing docker from the official repositories
To install docker from the official docker repositories we have to do some extra work.

First we have to add the GPG key for the docker repo, do so by executing the following command
````
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
````
Next we have to add the Docker repo to the sources list, do so by executing the following command
```
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
```
To refresh the package database we have to issue the update command again. Do so with the following command
```
sudo apt-get update
```
Now we can install docker with the following command:
```
sudo apt-get install -y docker-engine
```

#### Installing docker compose
Some of our docker containers might use docker compose to simplify docker initialization, in order to install docker compose we first need "python pip", to install it we use:
```
sudo apt-get -y install python-pip
```
Now we can use the newly installed python-pip to install docker-compose:
```
sudo pip install docker-compose 
```
#### Automating docker
Docker should already start automatically, we can check whether it does by running the following command after a fresh reboot:
```
sudo systemctl status docker.service
```
If docker hasn't started automatically we can enable the autostart functionality and start docker with the following command:
```
sudo systemctl enable docker.service && sudo systemctl start docker.service
```

### Auto loading containers
In this chapter we'll take a look at automatically starting containers on boot / reboot.

#### Creating a systemd init script
To automatically load containers we have to create a startup script. Ubuntu 16.04 uses the Systemd init system so we'll make a startup script for that.

Start by creating a script that has to be run by the init script. In our case we'll recreate the legacy "rc.local" file in the "/usr/local/sbin" directory. To create this file touch it:
```
sudo touch /usr/local/sbin/rc.local
```
Now it's time to fill the thing, we can do this with our favourite text editor. I'll be using nano in the example. 
To open up the file in nano use the following command:
```
sudo nano /usr/local/sbin/rc.local
```
Paste in the following code (ctrl + shift + v):
```
#!/bin/bash
#
# /usr/local/sbin/rc.local: Local multi-user startup script.
```
Save and exit the document (ctrl + o followed by ctrl + x) and make sure it's executable by running a chmod +x on it:
```
sudo chmod +x /usr/local/sbin/rc.local
```
After setting up the startup script we can set up the Systemd service, to do this we create a file with the following command:
```
sudo touch /etc/systemd/system/rc-local.service
```
Now we'll open it with nano (replace touch with nano in the previous example) and paste in the following contents:

```
[Unit]
Description=/etc/rc.local Compatibility
ConditionFileIsExecutable=/usr/local/sbin/rc.local
 
[Service]
Type=oneshot
ExecStart=/usr/local/sbin/rc.local
TimeoutSec=0
RemainAfterExit=yes
SysVStartPriority=99
 
[Install]
WantedBy=multi-user.target
```
Save and exit the file (ctrl + O then ctrl + x) and after that enable the startup service:
```
sudo systemctl enable rc-local.service
```
After completing all of the aforementioned steps we have a script (/usr/local/sbin/rc.local) which will run (as root) at boot. Any command we put into that file will run at startup.

#### Adding docker services to the init script.
Before you add a docker to the startup script, make **sure** that [you named the instance with the `-name` flag](https://blog.docker.com/2013/10/docker-0-6-5-links-container-naming-advanced-port-redirects-host-integration/).

With the init script in place we can easily add docker services to the startup script. In this example I'll automate both regular dockers and dockers that make use of docker compose.
use the following command to edit our (previously created) startup script:

```
sudo nano /usr/local/sbin/rc.local
```

We'll start by adding two arrays, one for the docker image names and one for the docker-compose paths. In the example below I will have 1 path in the dockercomposedirs array and 1 docker container name in the containers array:
```
containers=(
    "docker-ui"
)
 
dockercomposedirs=(
  "/root/elk-docker"
)
```
**Note! ** array items in bash aren't separated with a ","

Next we'll add in a loop which will start all the named docker instances:

```
for name in "${containers}"
do
docker start $name
done
```

Directly below this we can add the docker compose loop:

```
for path in "${dockercomposedirs}"
do
cd "$path"
docker-compose up -d
done
```

#### adding new docker instances
To add a new docker simply add another item to the array, in the example below I'm starting a docker service called "docker-test-2" and a docker-compuse app called "docker-compose-test-2" located in the /opt/dontdothis/ folder:
```
containers=(
    "docker-ui"
    "docker-test-2"
)
 
dockercomposedirs=(
    "/root/elk-docker"
    "/opt/dontdothis/docker-compose-test-2"
)
```