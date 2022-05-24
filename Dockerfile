# This Dockerfile creates an image used to run the Slack-Notifier

# cd to dir containing the Dockerfile
# docker build -f Dockerfile -t robevansuk/slack-notificaiton-action:0.0.1 .
# docker push robevansuk/slack-notification-action:0.0.1
# update tagged version in gradle.properties file to be consistent.

FROM alpine:latest

RUN apk add curl gettext \
     && apk update \
     && rm -rf /var/cache/apk/*

WORKDIR /
COPY files/slack_notification.json /slack_notification.json
COPY files/entrypoint.sh /entrypoint.sh

CMD chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh "${1}" "${2}"