# Zato load-balancer image

FROM shizacat/zato_base
MAINTAINER ShizaCat <...@zato.io>

RUN mkdir -p /opt/zato/code/conf
# RUN mkdir -p /opt/zato/code/conf/load-balancer

# Copy certificates
# COPY zato.load_balancer.cert.pem /opt/zato/cert/
# COPY zato.load_balancer.key.pem /opt/zato/cert/
# COPY zato.load_balancer.key.pub.pem /opt/zato/cert/
# COPY ca_cert.pem /opt/zato/cert/

COPY config/zato.config /opt/zato/code/zato_pattern.config
COPY scripts/start.sh /bin/start.sh

EXPOSE 11223 20151
WORKDIR /opt/zato

ENTRYPOINT ["/bin/start.sh"]