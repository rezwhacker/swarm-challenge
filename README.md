# swarm-challenge-ansible


I do Setup Docker Swarm with Bash
Steps:

1. give master ip 
2. give worker ip
3. check ping them
4. build docker swarm init
5. ssh to worker
6. join them
7. check node's
8. build stack from docker-compose
9. check service

SSH to the Swarm Manager:

```
$ sudo -i
$ bash nginx-stack.sh
```
give master and worker ip 

and script check connction

if its well you see
```
# Ping successful.
```

after that if script run success ssh to worker's and put join token then

and scripts run docker node ls and if you see somthing like this they have success joined to cluster
and check node are active:
```
# docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
2ewbkjhlcrxs9fdmadoy3gku1 *   master-1   Ready     Active         Leader           24.0.5
k5kueysxc6gkwaj4x3ghzl72k     node-1     Ready     Active                          24.0.5
u54wz6it5lygd7z3jmu6hbx49     node-2     Ready     Active                          24.0.5
```

Create a Nginx Demo Service then  check service are available:

```
$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
hjbwkirae7jj        backend               replicated          2/2                 nginx:latestc        *:80->80/tcp

 echo "service are available:"
 echo "nginx-stack"
```
 then  check service ps available:

```
$ docker service ps nginx
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS                      
dfphqv17pjda        backend.1             nginx:latest        node-1      Running             Running 34 seconds ago                       
dgdm43limraf        backend.2             nginx:latest        node-2      Running             Running 34 seconds ago                       
 echo "Service 'nginx-stack' has running tasks:"
 echo "nginx-stack"
```

Test please test  Application

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

Best Regard
