# In the git workflow environment variables get PREPENDED with INPUT_
# When running in git workflow, therefore, you only set
# SLACK_CHANNEL, SLACK_STATUS_EMOJI and DISPLAY_IMAGE_URL
# When running locally, you can do a test run with
#
# docker run -e INPUT_SLACK_CHANNEL="https://hooks.slack.com/services/DUMMY_URL/DUMMY/DUMMY" \
#            -e INPUT_JOB_STATUS="success" \
#            ghcr.io/rokevansuk/slack-notification-action:0.0.1
#
# since the variables set on your local machine will need to replicate how git workflow environment variables would be loaded in.

set -x

echo "SLACK_WEBHOOK: ${INPUT_SLACK_WEBHOOK}"
echo "JOB_STATUS: ${INPUT_JOB_STATUS}"

# curl request for the slack webhook webhook: curl POST, headers, data (slack json obj), slack webhook
if [[ "${INPUT_JOB_STATUS}" == 'success' ]]; then
  export INPUT_SLACK_STATUS_EMOJI=':white_check_mark::white_check_mark::white_check_mark:'
  export INPUT_DISPLAY_IMAGE_URL='https://www.gifcen.com/wp-content/uploads/2022/02/congratulations-gif-8.gif'

elif [[ "${INPUT_JOB_STATUS}" == 'failure' ]]; then
  export INPUT_SLACK_STATUS_EMOJI=':rotating_light::rotating_light::rotating_light:'
  export INPUT_DISPLAY_IMAGE_URL='https://c.tenor.com/-kZOB16tELEAAAAC/this-is-fine-fire.gif'

fi # else cancelled

curl -X POST -H 'Content-type: application/json' --data "$(envsubst < /slack_notification.json)" "${INPUT_SLACK_WEBHOOK}"