cls
docker rm -f API-Gateway
docker rmi -f sadaindonesia/api-gateway:devel
docker build --pull --rm -f ".\Dockerfile" -t sadaindonesia/api-gateway:devel "."
docker run -d -it --name API-Gateway -p 80:80 -p 443:443 -p 8080:8080 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v "%cd%"/sources/config/traefik:/opt/traefik/conf:ro --privileged sadaindonesia/api-gateway:devel
pause