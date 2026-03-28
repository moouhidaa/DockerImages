COMPOSE_FILE   =  srcs/docker-compose.yml

DATA_PATH =  /home/moouhida/data


all :
	@mkdir  -p $(DATA_PATH)/mysql
	@mkdir  -p $(DATA_PATH)/wordpress
	@docker-compose  -f $(COMPOSE_FILE) up --build  -d
 # -f  use  thespecif folder 
 #up  start all  teh containers 
 # --builds  =  rebuild images from dockerfiles
 #-d  = backgroud  (detached mode)
down :
	@docker-compose -f  $(COMPOSE_FILE) down

clean :
	@docker-compose  -f  $(COMPOSE_FILE) down  --rmi  all

fclean : clean
	@rm  -rf  $(DATA_PATH)
	@docker  system  prume  -af

re : fclean all

#show all the running containers
status  :
	@docker-compose -f  $(COMPOSE_FILE) ps

#logs for debugging errrors

logs:
	$docker-compose -f  $(COMPOSE_FILE) logs

.PHONY :  all  doen  clean  fclean  re  status  logs