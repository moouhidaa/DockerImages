The stack of container runs a self-hosted Wordpress website. It includes a web server server(nginx) a PHP engine and database (MARIADB).
A cashe layer(Redis),a database admin panel(Adminer),an FTp server for file uploads,and a back up service.

Start and Stop the project
--------------------------
Make:
Thise builds all Docker images and starts all containers First run may take a few minutes
Make down:
Stops and removes conatainers ,Your database and files are preserver inDocker volumes
Make fclean:
Stops and  delete all data (volumes data network images) using  this for clean reset
Make re:
Fclean followed by make 

Access the Website and Administration
-------------------------------------
Before accessing the website we should set it  on /etc/hosts that the  browser checks before forwarded  the  request to DNS server.
cause we  know that the site doesn't have a domain name yet.
And  be  in mind that site uses a self-signed TLS certificate The browser will show an warning security we should accept the risk

Wordpress admin panel :
login in with the wordpress admin credentials using that URl :
 - https://moouhida.42.fr/wp-admin
Use this browse and manage the MariaDB database directly from the browser
 - http://moouhida.42.fr:8080

Locate andManage Credentials
----------------------------
Credentials are split between two files:
    -> .env : located at the root of the project conatain the domain name database name usernames. and non-sensitive settings.
    -> secrets: conataint  files with sensitive password made to be hidden for security reason thes files never committed to git.
All  containers should show status up. if any container shows exited or restart something went wrong.
check conatainers ar up : docker status (docker ps).
if something wrong we can check the logs by docker logs
