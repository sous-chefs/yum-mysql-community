# yum-mysql-community Cookbook CHANGELOG

This file is used to list changes made in each version of the yum-mysql-community cookbook.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

- Remove CircleCI

## 5.3.3 - *2023-03-01*

- Update workflows to 2.0.1
- Remove mdl and replace with markdownlint-cli2

## 5.3.2 - *2022-12-25*

- CI Fixes

## 5.3.1 - *2022-01-27*

- Add Alma Linux and Rocky Linux to testing
- Remove CentOS 8 (prefer Stream)

## 5.3.0 - *2022-01-20*

- Update gpgkey urls in attribute files: mysql57, mysql-connectors
- Update gpgkey urls in repo resource

## 5.2.0 - *2022-01-08*

- Switch to using yum_repository resource instead of template

## 5.1.0 - *2021-10-05*

- Use `dnf_module` resource from `yum` cookbook instead of manually shelling out

## 5.0.2 - *2021-08-31*

- Standardise files with files in sous-chefs/repo-management

## 5.0.1 - *2021-06-01*

- Standardise files with files in sous-chefs/repo-management

## 5.0.0 - *2021-05-13*

- Chef 17 updates: enable `unified_mode` on all resources
- Bump required Chef Infra Client to >= 15.3

## 4.2.1 (2020-11-05)

- Insure dnf module is only disabled where required

## 4.2.0 (2020-10-28)

### Changed

- Sous Chefs Adoption
- Update Changelog to Sous Chefs
- Update to use Sous Chefs GH workflow
- Update README to sous-chefs
- Update metadata.rb to Sous Chefs
- Update test-kitchen to Sous Chefs
- Cleanup attributes and fix Fedora
- Improve integration testing

### Fixed

- Yamllint fixes
- MDL fixes
- Add provides to resource

### Added

- Fedora testing

### Removed

- Remove Amazon Linux 1 testing
- Remove EL 6 testing

## 4.1.1 (2020-04-10)

- Allow the resource to run on versions of chef-client that don't have the "description" metadata - [@pierresouchay](https://github.com/pierresouchay)

## 4.1.0 (2020-03-02)

- fix: error of gpgkey reference in older version. - [@bigplants](https://github.com/bigplants)
- Typo fix in README.md file - [@olegburca](https://github.com/olegburca)
- Resolve Cookstyle 5.8 warnings - [@tas50](https://github.com/tas50)
- Simplify platform check logic - [@tas50](https://github.com/tas50)
- Remove unnecessary foodcritic comments - [@tas50](https://github.com/tas50)
- Cookstyle fixes - [@tas50](https://github.com/tas50)
- Add testing with Github Actions - [@tas50](https://github.com/tas50)
- Add a new yum_mysql_community_repo resource - [@Stromweld](https://github.com/Stromweld)

## 4.0.1 (2018-02-26)

- Switched to MySQL managed GPG key to avoid failures accessing the previous GitHub hosted key

## 4.0.0 (2018-02-23)

- Add support for Amazon Linux 2.0
- Require Chef 13 now that we assume Amazon Linux has it's own platform family

## 3.0.1 (2018-02-19)

- Fixed GPG key download URL

## 3.0.0 (2018-02-16)

- Require Chef 12.14+ and remove compat_resource dep

## 2.1.0 (2017-03-26)

- Fix URLs for amazon so that 2017 resolves to '6' rather than 'latest'

## 2.0.3 (2016-12-22)

- Depend on the latest compat_resource cookbook
- Cookstyle fixes

## 2.0.2 (2016-11-26)

- Remove yum-epel from the readme
- Switch to inspec for testing
- Fix mysql55 in travis

## 2.0.1 (2016-11-07)

- yum_repository mirrorlist value updated in Readme

## 2.0.0 (2016-11-05)

- Replace yum dependency with compat_resource
- Replace 'epel' with 'mysql-community' in the readme

## 1.0.0 (2016-09-06)

- Testing updates
- Remove support for Chef 11

## v0.3.0 (2016-07-22)

- Support Oracle Linux
- Correctly state the required yum cookbook version in the readme
- Add chef_version metadata to metadata.rb

## v0.2.0 (2016-03-29)

- Add support for the 2016 Amazon Linux releases
- Update test dependency gems and remove Guard
- Test in Travis CI using kitchen-dokken

## v0.1.21 (2015-12-01)

- Fixing if/unless logic in recipes

## v0.1.20 (2015-11-30)

- Fixed attributes with a false value not being passed

## v0.1.19 (2015-10-28)

- Fixing Chef 13 nil property deprecation warnings

## v0.1.18 (2015-09-21)

- Added Travis CI config for lint and unit testing
- Added Chef standard Rubocop file and resolved all warnings
- Added Chef standard chefignore and .gitignore files
- Add supported platforms to the metadata
- Added source_url and issues_url to the metadata
- Added long_description to the metadata
- Updated and expanded development dependencies in the Gemfile
- Added contributing, testing, and maintainers docs
- Added platform requirements to the readme
- Added Travis and cookbook version badges to the readme
- Update Chefspec to 4.X format

## v0.1.17 (2015-04-06)

- Updating pubkey link from someara to chef-client github orgs

## v0.1.16 (2015-03-25)

- Adding support Amazon Linux 2015.03 to all channels

## v0.1.15 (2015-03-25)

- Added support for amazon linux 2015.03

## v0.1.14 (2015-03-12)

- The content of 0.1.13 is questionable: didn't have changelog entry, may have had merged attribute change, but let's be clear and say at least this version 0.1.14 is the right thing.

## v0.1.13 (2015-03-12)

- 3 corrected typo in public key attribute

## v0.1.12 (2015-01-20)

- Minor style updates

## v0.1.11 (2014-07-21)

- Adding RHEL-7 support

## v0.1.10 (2014-07-21)

- Adding mysql-5.7 and centos 7 support

## v0.1.8 (2014-06-18)

- Updating to support real RHEL

## v0.1.6 (2014-06-16)

Fixing typo in mysql55-community attributes

## v0.1.4 (2014-06-13)

- updating url to keys in cookbook attributes

## v0.1.2 (2014-06-11)

- Move files/mysql_pubkey.asc to files/default/mysql_pubkey.asc

## v0.1.0 (2014-04-30)

Initial release
