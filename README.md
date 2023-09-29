# swarm-challenge-ansible


I Think is better to Setup Docker Swarm with Ansible
because its more fast and advanced for help me to faster than normal way to onboard in sre position


SSH Config:

```
$ cat ~/.ssh/config 

Host master-1
  Hostname master-1
  User ubuntu
  IdentityFile /tmp/key.pem
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null

Host node-1
  Hostname node-1
  User ubuntu
  IdentityFile /tmp/key.pem
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null

Host node-2
  Hostname node-2
  User ubuntu
  IdentityFile /tmp/key.pem
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
```

Install Ansible:

```
$ apt install python-setuptools -y
$ easy_install pip
$ pip install ansible
```


## Deploy Docker Swarm

```
$ ansible-playbook -i inventory.ini -u ubuntu deploy-swarm.yml 
PLAY RECAP 

master-1           : ok=18   changed=4    unreachable=0    failed=0   
node-1             : ok=15   changed=1    unreachable=0    failed=0   
node-2             : ok=15   changed=1    unreachable=0    failed=0   
```

SSH to the Swarm Manager and List the Nodes:

```
$ docker node ls
ID                            HOSTNAME    STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
0ead0jshzkpyrw7livudrzq9o *   master-1    Ready               Active              Leader              18.03.1-ce
iwyp6t3wcjdww0r797kwwkvvy     node-1      Ready               Active                                  18.03.1-ce
ytcc86ixi0kuuw5mq5xxqamt1     node-2      Ready               Active                                  18.03.1-ce
```

Create a Nginx Demo Service:

```
$ docker network create --driver overlay appnet
$ docker service create --name backend --publish 80:80 --network appnet --replicas 2 nginx
$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
k3vwvhmiqbfk        nginx               replicated          6/6                 nginx:latest        *:80->80/tcp

$ docker service ps nginx
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS                      
g2f0ytwb2jjg        nginx.2             nginx:latest        node-1      Running             Running 34 seconds ago                       
clcmew8bcvom        nginx.3             nginx:latest        node-2      Running             Running 34 seconds ago                       
```

Test the Application:

```
$ curl -i http://192.168.1.10
HTTP/1.1 200 OK
Server: nginx/1.15.0
Date: Thu, 14 Jun 2018 10:01:34 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: mon, 25 Sep 2023 12:00:18 GMT
Connection: keep-alive
ETag: "5b167b52-264"
Accept-Ranges: bytes
```

Idont have Time for more than build but 

all of my host's are in Bamdad DC and then i should make a second cluster in another DC and with one router with ip public tunnel two DC network and 
its good for high availability

we have domain for status monitoring  end user and ngnix and in CDN with round robin we handle request in 3 node public ip

and after that in 4 node in local network swarm handle load balance 
i believe its better to have reverse proxy or HA,nginx for handle request to backend web server
and i know its not good my service expose to internet with 3 ip, but in iran its normal to filter random ip or have packet lost without reason

