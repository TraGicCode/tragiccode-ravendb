# RavenDB

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with ravendb](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ravendb](#beginning-with-ravendb)
1. [Usage - Configuration options and additional functionality](#usage)
    * [Install ravendb only](#install_ravendb_only)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The ravendb module installs and manages the ravendb server and service on Windows systems.

Ravendb is a NoSQL database.

## Setup

### Setup Requirements

The ravendb module requires the following:

* Puppet Agent 4.7.1 or later.
* Access to the internet.
* Windows Server 2012/2012R2/2016.

### Beginning with ravendb

To get started with the ravendb module simply include the following in your manifest:

```puppet
class { 'ravendb':
    package_ensure => 'present',
}
```

This example downloads, installs, and configured the currently pinned version of the ravendb (3.5.4) and ensures the ravendb service is running and in the desired state.  After running this you should be able to access the ravendb management studio via http://localhost:8080.

A more advanced configuration including all attributes available:

```puppet
class { 'ravendb':
      package_ensure                         => 'present',
      include_management_tools               => true,
      management_tools_install_directory     => 'C:\\RavenDB Tools',
      ravendb_service_name                   => 'RavenDB',
      ravendb_port                           => 8080,
      ravendb_target_environment             => 'development',
      ravendb_database_directory             => 'C:\\RavenDB\\Databases',
      ravendb_filesystems_database_directory => 'C:\\RavenDB\\FileSystems',
      service_ensure                         => 'running',
      service_enable                         => true,
      service_restart_on_config_change       => true,
      config                                 => {
        'Raven/Esent/DbExtensionSize' => 128,
        'Raven/Esent/MaxCursors'      => 4096,
        'Raven/Esent/MaxVerPages'     => 6144,
      },
    }
```

The above is just an example of the flexibility you have with this module.  You will generally never need to specify every or even so many parameters as shown.

## Usage

### Install ravendb only

Sometimes you might want to install ravendb but not manage the service with puppet.

```puppet
class { 'ravendb':
      package_ensure => 'present',
      service_manage => false,
    }
```

### Install ravendb + ravendb management tools (Smuggler/Backup)

Sometimes you might want to install ravendb and the management tools along with it if you plan on taking backups on the same server.

```puppet
class { 'ravendb':
      package_ensure                     => 'present',
      include_management_tools           => true,
      management_tools_install_directory => 'C:\\RavenDB Tools',
}
```

### Install ravendb with certain configuration settings configured

If you find yourself needing to customize ravendb's configuration don't worry because this is covered.

```puppet
class { 'ravendb':
      package_ensure                         => 'present',
      config                                 => {
        'Raven/Esent/DbExtensionSize' => 128,
        'Raven/Esent/MaxCursors'      => 4096,
        'Raven/Esent/MaxVerPages'     => 6144,
      },
    }
```

A full list of documented configuration possiblities that exist can be found at https://ravendb.net/docs/article-page/3.5/csharp/server/configuration/configuration-options.

### Prevent restarting RavenDB Service on configuration file changes

Generally in production you don't want your database to restart in an uncontrolled manner. For Example, If you are not allowed to restart the database during production hours because it would cause downtime.  If that is the case then in your production  environment you will want to use hiera to set service_restart_on_config_change to false.  You can then push out your code changes to production and at some point in the future during a green window trigger a restart of the service using any method you prefer. ( Puppet Tasks/MCollective/WinRM )

```puppet
class { 'ravendb':
      package_ensure                         => 'present',
      service_restart_on_config_change       => false,
      config                                 => {
        'Raven/Esent/DbExtensionSize' => 128,
        'Raven/Esent/MaxCursors'      => 4096,
        'Raven/Esent/MaxVerPages'     => 6144,
      },
    }
```

## Reference

### Classes

Parameters are optional unless otherwise noted.

#### `ravendb`

Installs and manages the ravendb server, service, and management tools.

#### `package_ensure`

Specifies whether the ravendb package resource should be present. Valid options: 'present', 'absent', and 'installed'.

Default: 'present'.

#### `include_management_tools`

Specified if management tools should be installed.  This includes things like Raven.Smuggler.exe, Raven.Backup.exe, and more.

Default: false.

#### `management_tools_download_url`

The full url in which to download the management tools archive (.zip).

Default: 'https://daily-builds.s3.amazonaws.com/RavenDB-3.5.4.Tools.zip'.

#### `management_tools_download_absolute_path`

Specifies the absolute path on the target system in which to download the ravendb management tools .zip archive to.

Default: 'C:\RavenDB-3.5.4.Tools.zip'.

#### `management_tools_install_directory`

Specifies the absolute path on the target system to extract the management tools to.

Default: 'C:\RavenDB Tools'.

#### `ravendb_service_name`

The name of the RavenDB service.

Default: 'RavenDB'.

#### `ravendb_port`

The port in which the ravendb service will listen on.

Default: 8080.

#### `ravendb_install_log_absolute_path`

The absolute path in which to log the installation process to.

Default: 'C:\RavenDB.install.log'.

#### `ravendb_uninstall_log_absolute_path`

The absolute path in which to log the uninstallation process to.

Default: 'C:\RavenDB.uninstall.log'.

#### `ravendb_target_environment`

The environment in which you are targeting. Valid options: 'development' and 'production'.

Default: 'development'.

#### `ravendb_database_directory`

The path in which to store database folders into.

Default: 'C:\RavenDB\Databases'.

#### `ravendb_database_directory`

The path in which to store filesystem database folders into.

Default: 'C:\RavenDB\FileSystems'.

#### `service_ensure`

Whether or not the stackify services should be running or stopped. Valid options: 'running' and 'stopped'.

Default: 'running'.

#### `service_enable`

Whether or not the ravendb service should be enabled to start at boot or disabled. Valid options: true, false, manual

Default: 'true'.

#### `service_restart_on_config_change`

Whether ot not to restart the ravendb service when the ravendb configuration file is updated/changed by puppet. (Raven.Server.exe.config)

Default: true.

#### `config`

Which configuration key values pairs should exist in the ravendb configuration file. (Raven.Server.exe.config)

Default: '{}'.

## Development

## Contributing

1. Fork it ( https://github.com/tragiccode/tragiccode-ravendb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request