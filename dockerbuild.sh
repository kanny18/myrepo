docker images
#remove old docker images
docker rmi -f $(docker images spring3hibernate --format "{{.ID}}")
docker build -t spring3hibernate .
docker images | grep spring3hibernate
