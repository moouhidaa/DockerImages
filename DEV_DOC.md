.The developer shoudl  never enter arunning conatiner to make things work

Set up everything from the scratch actually means starting with a clean slate before running you full docker compose stack
1 -> prerequisites
    - sudo apt update 
    - sudo apt install -y docker.io docker-compose-plugin make git
    - sudo usermod -aG docker $USER
    - newgrp docker
2 -> clone the repo
    - git clone https://github.com/moouhida/Dockerimages.git
3 -> configuration file
    your .env file holds non-sensitive variables (the developer create it manually or provide an exapmle)
4 -> secrets
    your credentials is never in the repo (it's in .gitignore) that file gets mounted into container at /run/secrets/credentials and  entrypoint parse it  with awk && cut
5 -> host file
    since the  moouhida.42.fr not a real DNS enrty on the local machine the developer
    must add it manually :
    - echo  "127.0.0.1 moouhida.42.fr" | sudo tee -a /etc/hosts

6 -> launch everything using Makefile
    - make
7 -> verify The containers status and logs
    - docker compose ps
    - docker compose logs -f

.The second section is how does the Makefile and docker compose.
    - using makefile just an easy way to run docker and docker-compose commands nothing else
    - docker compose is the docker client that we used to launch our conatainers at once usign the Docker-compose.yml file that  have  the options of the conatiners 
    secrets file area ,bind volume location ,network name , env files

.The relevant commands used
    - docker compose up --build -d ti build an  image or images at once
    - docker down stop and remove the container + networks
    - docker compose down -v : same as docker down + delete named volumes
    - docker compose down --rmi all -v : same as above + remove images
    - docker compose ps : the status of all services
    - docker compose logs -f : follow logs you can specify the container you want to follow its logs by adding the name <name> of that container
    - docker exec -it <conatiner name>  bash : bash into a running container
    - docker stats : live CPU/RAM usage per conatainer
    - docker volume prune : delete all unused volumes
    - docker network ls : list networks
.where the project data stored and how its persists
    - The  conatainers  are ephemeral cause  of crashed or die everything inside gone
    the volumes are the solution.
    they map a Directory inside the container to a location on the host machine outside  the conatiner and docker control forexmaple inour project we set the volumes  on ~/moouhida/data/
    - The survive of those volumes depend on  docker compose we set on CLI 
        -> docker compose down : containers removed - DATA SURVIVE volumes not touched
        -> docker compose -v : DATA gone 
so  when  maraidb write a row to the database it's actually writing to volume on the host 