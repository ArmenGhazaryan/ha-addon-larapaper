ARG BUILD_FROM
FROM ${BUILD_FROM}

USER root

RUN apk add --no-cache jq

COPY run.sh /ha-run.sh
RUN sed -i 's/\r$//' /ha-run.sh && chmod +x /ha-run.sh

ENTRYPOINT ["/bin/sh", "/ha-run.sh"]
