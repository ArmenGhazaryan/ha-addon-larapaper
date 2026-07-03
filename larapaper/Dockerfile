ARG BUILD_FROM
FROM ${BUILD_FROM}

USER root

RUN apk add --no-cache jq

COPY run.sh /ha-run.sh
RUN chmod +x /ha-run.sh

ENTRYPOINT ["/ha-run.sh"]
