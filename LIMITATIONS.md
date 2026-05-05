# Limitations

Research checked on 2026-05-05.

## Package Availability

### DNF/YUM

Oracle documents the MySQL Yum repository as the supported RPM repository for EL and Fedora platforms. The current Yum guide says the repository supports EL6, EL7, EL8, EL9, and EL10-based platforms plus Fedora 41 and 42, but also notes that MySQL 5.7 is not supported and that not every MySQL series supports every distribution.

The cookbook only declares current, non-EOL Yum-family platforms that map to the documented repository families:

* AlmaLinux 8, 9, and 10
* CentOS Stream 9 and 10
* Fedora 42
* Oracle Linux 8 and 9
* Red Hat Enterprise Linux 8, 9, and 10
* Rocky Linux 8, 9, and 10

MySQL release-series support in this cookbook:

* MySQL 8.4 LTS: supported on EL8, EL9, EL10, and Fedora 42.
* MySQL 8.0: supported on EL8 and EL9. EL10 and Fedora 42 are not listed for MySQL 8.0 in Oracle's current platform table.
* MySQL Innovation: supported by the MySQL Yum repository. The repository path is `mysql-innovation-community`.
* MySQL 5.5, 5.6, and 5.7: not supported by this cookbook. The upstream repository directories are stale and Oracle's current Yum guide explicitly excludes MySQL 5.7.

### Repository URL Patterns

* MySQL 8.0 server: `https://repo.mysql.com/yum/mysql-8.0-community/el/<major>/$basearch/`
* MySQL 8.4 server: `https://repo.mysql.com/yum/mysql-8.4-community/el/<major>/$basearch/`
* MySQL Innovation server: `https://repo.mysql.com/yum/mysql-innovation-community/el/<major>/$basearch/`
* Connectors: `https://repo.mysql.com/yum/mysql-connectors-community/el/<major>/$basearch/`
* MySQL 8.0 tools: `https://repo.mysql.com/yum/mysql-tools-community/el/<major>/$basearch/`
* MySQL 8.4 tools: `https://repo.mysql.com/yum/mysql-tools-8.4-community/el/<major>/$basearch/`
* MySQL Innovation tools: `https://repo.mysql.com/yum/mysql-tools-innovation-community/el/<major>/$basearch/`

Fedora uses `fc/$releasever` rather than `el/<major>`.

## Architecture Limitations

Oracle's current supported platform table lists x86_64 and arm64 for EL8, EL9, and EL10 for MySQL 8.4 and Innovation. Fedora support is documented by repository family, but this cookbook's Dokken testing is x86_64.

## Source/Compiled Installation

This cookbook only manages Yum repository files. It does not build MySQL from source and does not install source-build dependencies.

## Known Issues

* Amazon Linux is not listed in Oracle's MySQL Yum repository support statement. The old cookbook mapped Amazon Linux to EL repositories, but this migration does not declare Amazon Linux support.
* CentOS Linux 7, CentOS Stream 8, and Scientific Linux 7 are EOL and are not supported.
* MySQL 5.5, 5.6, and 5.7 repository APIs were removed because they are no longer supportable on current non-EOL platforms.

## Sources

* [MySQL Yum Repository Guide](https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/index.html)
* [MySQL Supported Platforms](https://www.mysql.com/support/supportedplatforms/)
* [MySQL Yum repository index](https://repo.mysql.com/yum/)
* [CentOS Stream lifecycle](https://endoflife.date/centos-stream)
* [CentOS lifecycle](https://endoflife.software/operating-systems/linux/centos)
* [Amazon Linux lifecycle](https://endoflife.date/amazon-linux)
* [Scientific Linux EOL notice](https://scientificlinux.org/category/uncategorized/scientific-linux-end-of-life/)
