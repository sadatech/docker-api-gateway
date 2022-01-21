cls
docker rm -f API-Gateway
docker rmi -f sadaindonesia/api-gateway:0242ac120003
docker build --pull --rm -f ".\Dockerfile" -t sadaindonesia/api-gateway:0242ac120003 "."
docker run -d -it --name API-Gateway -p 80:80 -p 443:443 -v /sys/fs/cgroup:/sys/fs/cgroup:ro --privileged sadaindonesia/api-gateway:0242ac120003
pause