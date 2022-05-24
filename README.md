# Slack Notification Action

This project has been set up so that it can be used to issue notifications for builds to a slack webhook.

To add slack notifications to your builds just supply the following in your build:

```
  - name: Dispatch Slack Notification
    if: always()
    uses: robevansuk/slack-notification-action@0.0.1
    with:
      slack_webhook: 'https://hooks.slack.com/services/DUMMY_FORMAT/DUMMY/DUMMY'
      job_status: ${{ job.status }}
```