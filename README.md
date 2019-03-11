# Redmine Append Users Display Format plugin

This is the Redmine (Project manage system) plug-in which the users display format is appended.

It can use users custom field of affiliation for users display. It also corresponds to the display of names for Japan.

## Version

0.0.3

## Environment

* Redmine 3.4
* Ruby 2.0 or higher

## Installation

### Download

* Change you current directory to your Redmine root directory.

```
cd {REDMINE_ROOT}
```

* Copy the plugin from GitHub using the following command.

```
git clone https://github.com/hironoda/redmine_append_users_display_format.git plugins/redmine_append_users_display_format
```

### Install

* Run the following command to upgrade your database.

```
bundle exec rake redmine:plugins:migrate NAME=redmine_append_users_display_format RAILS_ENV=production
```
* Restart Redmine.

### Configuration

If you want to display the user's affiliation, make the following settings.

1. Create a user custom field to set user affiliation.
1. In the setting of the plugin, set the name of the custom field created in the previous item.

## Description

### Format for Japan

The last some of the users display format of the plugin setting is for Japanese, and the name is displayed as follows.

1. If there is not users with the same last name, only the last name is displayed. (e.g. Noda)
1. If there is users with the same last name, but the first letter of the first name is not the same, the last name and the first letter of the first is displayed. (e.g. Noda(H))
1. In other cases, the first and last names are displayed. (e.g. Noda Hiroyuki)

## Changelog

### 0.0.3

* Processing improvement

### 0.0.2

* Add test
* Bug Fixes

### 0.0.1

* First release

## License

The MIT License

Copyright (c) 2019 NODA Hiroyuki
