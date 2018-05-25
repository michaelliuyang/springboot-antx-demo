FROM docker-registry.com:5000/sage-env:latest

ADD core /data/service/core
ADD lib /data/service/lib

ENV SERVICE springboot-antx-demo

COPY docker-entrypoint.sh /data/service/
RUN chmod +x /data/service/docker-entrypoint.sh

ENTRYPOINT ["/data/service/docker-entrypoint.sh"]