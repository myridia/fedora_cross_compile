docker rm --force `docker ps -qa`
#docker rmi --force `docker images -aq`
docker volume prune -f
docker rmi --force myridia/fedora_cross_compile
