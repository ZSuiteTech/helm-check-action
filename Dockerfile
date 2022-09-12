FROM alpine/helm:3.5.3

LABEL version="0.2.1"
LABEL repository="https://github.com/ZSuiteTech/helm-check-action"
LABEL maintainer="Igor Gabaydulin, Miah Petersen"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]
