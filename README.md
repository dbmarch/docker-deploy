
docker container run -d -p 8080:80 --name myApache httpd

docker container exec -it <container id> bash

docker cp <file>  containername:<path>



To launch react:
 docker container run -d -p 8888:80 --name my-nginx nginx
 docker cp my-nginx:/usr/share/nginx/html/index.html ..

from the dist folder:
 docker container cp . my-nginx:/usr/share/nginx/html

# docker-deploy
Docker examples and readmes from  'Fast-Track Docker'

