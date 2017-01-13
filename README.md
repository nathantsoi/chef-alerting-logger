# Setup

## Slack

create a new webhook integration at [yourname].slack.com/apps/new and copy the webhook URL

set this to the attribute:

```
node['alerting_logger']['slack']['url'] = 'https://hooks.slack.com/services/LGKHD@GSDL/0SDG9HASAKD/asdg0ashd0ashdg2q8hadsglkas'
```

## Required attributes

specify these, there are no defaults set:

```
node['alerting_logger']['aws']['bucket'] = 'my-logging-stuff'
node['alerting_logger']['aws']['region'] = 'us-west-2'
node['alerting_logger']['aws']['key_id'] = 'as0g9ahsdg'
node['alerting_logger']['aws']['access_key'] = 'sdi0ha0weighaosdkghaosidgha0sd9ghs0a9dg'
```

## Default attributes

`node['alerting_logger']['grep']`: is the default grep string, set to 'ERROR'. this will grep the files in `path`, if there is a match, alerts slack. case insensitive


## Logrotate config

the `node['alerting_logger']['rotations']` attribute defines an array of logrotate configurations consisting of:

- `name`: (string) name of the logrotate entry
- `path`: (string) glob or absolute path to files to rotate
- `alert`:
  - `empty`: [true|false]. if true, notifies slack when the log file(s) is/are empty on a rotation

