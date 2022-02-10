cls
docker rm -f Traefik-SADATA
docker rmi -f sadaindonesia/sadata-traefik:devel
docker build --pull --rm -f ".\Dockerfile" -t sadaindonesia/sadata-traefik:devel "."
docker run -d -it --name Traefik-SADATA -p 80:80 -p 443:443 -p 8080:8080 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v "%cd%"/sources/config/traefik:/opt/traefik/conf:ro --privileged sadaindonesia/sadata-traefik:devel
pause