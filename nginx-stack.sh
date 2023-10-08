#!/bin/bash

read -p "Enter your master ip : " master_ip


echo "check connectivity for master "
  ping -c 4 -W 2 $master_ip

    if [ $? -eq 0 ]; then
      echo "Ping successful."
    else
      echo "Ping failed. There was an error."
    fi

    read -p "Enter your worker ip : " worker_ip

      for u in "${worker_ip[@]}"
      do
        ping -c 4 -W 2 $u
        if [ $? -eq 0 ]; then
          echo "Ping $u successful."
        else
          echo "Ping $u failed. There was an error."
        fi
      done
  docker swarm init

   join_token=$(docker swarm join-token -q worker)
   read -p "Worker Join Command: docker swarm join --token $join_token <manager-ip>:2377 ;then press enter :"

    apt install sshpass -y
    for a in  "${worker_ip[@]}";
    do
      read -p "username"
      read -s -p "passwd"; then
      sshpass -p "$passwd" ssh "$username@$a"

      docker swarm join --token $master_ip:2377
          if [ $? -eq 0 ]; then
          echo "Successfully connected to $a and joined to cluster."
      else
          echo "Failed to connect to $a and joined to cluster."
      fi
    done


    node_list=$(docker node ls)

      if [[ $node_list == *"Leader"*  ]] and [[ $node_list == *"Ready"* ]]; then
      echo "Nodes are available:"
      echo "$node_list"
    else
      echo "No nodes found. Exiting..."
      exit 1
    fi



    cd nginx-ubuntu-docker

    docker build -t nginx-ubuntu .

    docker stack deploy -c docker-compose.yml nginx-stack

    service_list=(docker service ls)

          if [[ $service_list == *"2/2"* ]]; then
          echo "service are available:"
          echo "$service_list"
      else
          echo "No service found. Exiting..."
          exit 1
      fi

    docker service ps nginx-stack

          if [[ nginx-stack == *"Running"* ]]; then
          echo "Service 'nginx-stack' has running tasks:"
          echo "nginx-stack"
      else
          echo "No running tasks found for service 'nginx-stack'. Exiting..."
          exit 1
      fi
