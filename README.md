# motd

#### Table of Contents

1. [Overview](#overview)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A one-maybe-two sentence summary of what the module does/what problem it solves.
This is your 30 second elevator pitch for your module. Consider including
OS/Puppet version it works with.

This module manages the `/etc/motd` on Unix-like systems. Unlike other motd modules,
this one created a bulleted list of services offered by that system.

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


To include a service on the bulleted service list in the motd, call the defined
resource like this:

## `motd::register`

```puppet
motd::register { 'DNS': }
```

## Limitations

This module should be compatible with any system that supports an motd. The formatting is pretty basic.
Getting it to use Puppet's `sprintf` function is on the roadmap.

## Development

Feel free to send pull requests to make this module more flexible.

## Release Notes/Contributors/Etc

### `0.1.0`

Initial release
