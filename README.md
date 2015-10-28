# Redmine Append Users Display Format plugin

This is the Redmine(Project manage system) plug-in which the users display format is appended.

It's possible to users custom field of department is used for the user's indication.

The last 4 of the users display format choices are for Japanese.

## Version

0.0.1

## Environment

Redmine 3.1.1

## Installation

### Download

* Change you current directory to your Redmine root directory
```
  cd {REDMINE_ROOT}
```
* Copy the plugin from GitHub using the following command
```
  git clone https://github.com/hironoda/redmine_append_users_display_format.git plugins/redmine_append_users_display_format
```

### Install

* Run the following command to upgrade your database
```
bundle exec rake redmine:plugins:migrate NAME=redmine_append_users_display_format RAILS_ENV=production
```
* Restart Redmine
* Configure the plugin, set users custom fields name of department
* Make a users custom field with the name established by the configuration of plug-in

## License

The MIT License

Copyright (c) 2015 NODA Hiroyuki
