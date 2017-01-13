#!/bin/bash

MESSAGE=$1

curl -X POST --data-urlencode "payload={\"channel\": \"#infrastructure\", \"username\": \"Log\", \"text\": \"${MESSAGE}\", \"icon_emoji\": \":newspaper:\"}" https://hooks.slack.com/services/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
