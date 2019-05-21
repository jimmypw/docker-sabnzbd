build:
	docker build -t jimmypw/sabnzbd:latest .

push: build
	docker push jimmypw/sabnzbd:latest

run:
	docker run -it -p 8080:8080 \
                -v /data/sabnzbd/config:/opt/sabnzbd/config \
                rasp
daemon:
	docker run -d -p 8080:8080 \
                -v /data/sabnzbd/config:/opt/sabnzbd/config \
                rasp

debug:
	docker run -it -p 8080:8080 \
                -v /data/sabnzbd/config:/opt/sabnzbd/config \
                --entrypoint=/bin/bash \
                rasp
