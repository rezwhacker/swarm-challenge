# swarm-challenge-ansible


I do Setup Docker Swarm with Bash






SSH to the Swarm Manager and List the Nodes:

```
$ cd swarm-challenge
$ bash nginx-stack.sh
```

and then give master and worker ip to check connectivity and do installing.
after that if script run success give you a worker jion token and please ssh to worker and use join them,

and scripts run docker node ls and if you see somthing like this they have success joined to cluster
```
# docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
2ewbkjhlcrxs9fdmadoy3gku1 *   master-1   Ready     Active         Leader           24.0.5
k5kueysxc6gkwaj4x3ghzl72k     node-1     Ready     Active                          24.0.5
u54wz6it5lygd7z3jmu6hbx49     node-2     Ready     Active                          24.0.5
```
then press enter:


Create a Nginx Demo Service:
```
$ mkdir nginx-ubuntu-docker
$ cd nginx-ubuntu-docker

$ docker build -t nginx-ubuntu .

```
```
$ docker stack deploy -c docker-compose.yml nginx-stack
$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
hjbwkirae7jj        backend               replicated          2/2                 nginx:latestc        *:80->80/tcp

$ docker service ps nginx
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS                      
dfphqv17pjda        backend.1             nginx:latest        node-1      Running             Running 34 seconds ago                       
dgdm43limraf        backend.2             nginx:latest        node-2      Running             Running 34 seconds ago                       
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

