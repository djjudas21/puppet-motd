# Install our standard MOTD on a box
class motd (
  $path = '/etc/motd',
  $display_hostname = true,
  $display_puppet_warning = true,
  $display_puppet_env = false,
  $display_qotd = false,
  $contact_email = undef,
  $qotd_text = undef,
  $qotd_author = undef,
) {

  concat { $path:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment { 'motd_top':
    target  => $path,
    content => "  **************************************************************************\n  *\n",
    order   => 02,
  }

  if (is_string($contact_email)) {
    concat::fragment { 'motd_email':
      target  => $path,
      content => "  *   Queries about this system to: ${contact_email}\n",
      order   => 04,
    }
  }

  if ($display_hostname) {
  $upfqdn = upcase($::fqdn)
    concat::fragment { 'motd_fqdn':
      target  => $path,
      content => "  *   ${upfqdn}\n  *\n",
      order   => 03,
    }
  }

  if ($display_puppet_warning) {
    concat::fragment { 'motd_puppet':
      target  => $path,
      content => "  *   This system is managed by Puppet. Check before editing!\n",
      order   => 04,
    }
  }

  if ($display_puppet_env) {
    concat::fragment { 'motd_puppet_env':
      target  => $path,
      content => "  *   Puppet environment: ${environment}\n",
      order   => 04,
    }
  }

  if ($display_qotd) {
    validate_string($qotd_text)
    validate_string($qotd_author)
    concat::fragment { 'motd_qotd':
      target  => $path,
      content => "  *\n  *   \"${qotd_text}\"\n  *           ${qotd_author}\n",
      order   => 04,
    }
  }

  concat::fragment { 'motd_services':
    target  => $path,
    content => "  *\n  *   This server provides the following services:\n",
    order   => 05,
  }

  concat::fragment { 'motd_footer':
    target  => $path,
    content => "  *\n  **************************************************************************\n",
    order   => '20',
  }
}
