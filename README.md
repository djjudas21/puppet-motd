# motd

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Overview

This module manages the `/etc/motd` on Unix-like systems. Unlike other motd modules,
this one created a bulleted list of services offered by that system by specifying a
resource anywhere that needs it.

Sample output:

```
  **************************************************************************
  *
  *   DEMO.BRIS.AC.UK
  *
  *   Queries about this system to: demo-help@bristol.ac.uk
  *   This system is managed by Puppet. Check before editing!
  *
  *   "640K ought to be enough for anyone."
  *           Bill Gates
  *
  *   This server provides the following services:
  *     - DNS
  *     - DHCP
  *     - TFTP
  *
  **************************************************************************
```

## Usage

## `motd`

To include the basic motd message on your system, call the base class like this:

```puppet
class motd {
  path                   => '/etc/motd',
  display_hostname       => true,
  display_puppet_warning => true,
  display_qotd           => false,
  contact_email          => undef,
  qotd_text              => undef,
  qotd_author            => undef,
}
```

### `path`

Path to the motd file. Default: `/etc/motd`

### `display_hostname`

Whether to display the server's hostname on the motd message. Default: `true`

### `display_puppet_warning`

Whether to display a generic warning that this server is managed by Puppet. Default: `true`

### `display_qotd`

Whether to display a fun quote. Default: `false`

### `contact_email`

Contact email address for this system. If defined, it will be displayed on the motd. Default: `undef`

### `qotd_text`

If `display_qotd` is set to `true`, provide the text for your quotation here. Default: `undef`. Example: `640K ought to be enough for anybody`

### `qotd_author`

If `display_qotd` is set to `true`, give the author for your quotation here. Default: `undef`. Example: `Bill Gates`


## `motd::register`

To include a service on the bulleted service list in the motd, call the defined
resource like this from within the relevant class.

```puppet
class { 'dns':
  ...
  ...
  motd::register { 'DNS': }
}

```

## Limitations

This module should be compatible with any system that supports an motd. The formatting is pretty basic.
Getting it to use Puppet's `sprintf` function is on the roadmap.

## Development

Feel free to send pull requests to make this module more flexible.

## Release Notes/Contributors/Etc

### `0.1.0`

Initial release

### `0.1.1`

Packaging release, simply to take account of concat 2.x being deleted from the Forge
