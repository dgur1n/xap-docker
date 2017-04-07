# To test 
# docker run -i -t --entrypoint=/bin/bash <image id-last-line-from-the-build>
FROM java:8

ENV XAP_VERSION 12.1.0
ENV XAP_BUILD_NUMBER 17000
ENV XAP_MILESTONE ga
ENV XAP_HOME_DIR /tmp/xap

RUN mkdir -p ${XAP_HOME_DIR}

# Download XAP
ADD https://gigaspaces-repository-eu.s3.amazonaws.com/com/gigaspaces/xap/12.1.0/12.1.0/gigaspaces-xap-enterprise-12.1.0-${XAP_MILESTONE}-b${XAP_BUILD_NUMBER}.zip /tmp/gigaspaces-xap-enterprise-${XAP_VERSION}-${XAP_MILESTONE}-b${XAP_BUILD_NUMBER}.zip

RUN unzip /tmp/gigaspaces-xap-enterprise-${XAP_VERSION}-${XAP_MILESTONE}-b${XAP_BUILD_NUMBER}.zip -d ${XAP_HOME_DIR} \
    && rm -f /tmp/gigaspaces-xap-enterprise-*.zip

ENV XAP_HOME ${XAP_HOME_DIR}/gigaspaces-xap-enterprise-${XAP_VERSION}-${XAP_MILESTONE}-b${XAP_BUILD_NUMBER}
ENV XAP_NIC_ADDRESS "#eth0:ip#"
ENV XAP_MANAGER_SERVERS "172.17.0.4,172.17.0.5,172.17.0.6"
ENV EXT_JAVA_OPTIONS "-Dcom.gs.multicast.enabled=false -Dcom.gs.multicast.discoveryPort=4174 -Dcom.gs.transport_protocol.lrmi.bind-port=10000-10100 -Dcom.gigaspaces.start.httpPort=9104 -Dcom.gigaspaces.system.registryPort=7102"
ENV XAP_GSM_OPTIONS "-Xms128m -Xmx128m"
ENV XAP_GSC_OPTIONS "-Xms128m -Xmx128m"
ENV XAP_LOOKUP_GROUPS xap
ENV VERBOSE true

# GS webui
ENV XAP_WEBUI_OPTIONS "${EXT_JAVA_OPTIONS}"
ENV WEBUI_PORT 8099

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR ${XAP_HOME}

EXPOSE 10000-10100 9104 7102 4174 8099 8080 8090 2888 3888

CMD ["./bin/gs-agent.sh"]