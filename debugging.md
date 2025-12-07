# attach to front end

docker container ps

docker container exec -it  expense-tracker-base-frontend-1 sh

To stop / make unhealthy
install tools
apk add psmisc

killall -s STOP nginx


Permission issues in WSL

Add user to the docker group:

verify there is a docker group
getent group docker
docker:x:989:dbmarch

# FIX PERMISSIONS in WSL
sudo usermod -aG docker $USER