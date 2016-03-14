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
  $char = '*',
  $width = 80,
) {

# Example dimensions
# **************************  Box 26 chars wide
# *   18 printable chars   *  Total width 28 chars
# **************************

  $boxwidth = $width-2
  $printwidth = $boxwidth-8

  # Calculate a blank line, i.e. two chars with no text
  $blank = inline_template("  <%= @char %><% for x in (3..boxwidth) %> <% end%><%= @char %>\n")

  # Calculate a top or bottom edge row of chars
  $edge = inline_template("  <% for x in (1..boxwidth) %><%= @char %><% end %>")

  # Location of motd file
  concat { $path:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  # Top edge of box
  concat::fragment { 'motd_top':
    target  => $path,
    content => "${edge}\n${blank}",
    order   => 02,
  }

  # Contact info
  if (is_string($contact_email)) {
    $email_sprint = sprintf("%-${printwidth}s", "Queries about this system to: ${contact_email}")
    concat::fragment { 'motd_email':
      target  => $path,
      content => "  ${char}   ${email_sprint}   ${char}\n${blank}",
      order   => 04,
    }
  }

  # Hostname
  if ($display_hostname) {
    $upfqdn = upcase($::fqdn)
    $fqdn_sprint = sprintf("%-${printwidth}s", $upfqdn)
    concat::fragment { 'motd_fqdn':
      target  => $path,
      content => "  ${char}   ${fqdn_sprint}   ${char}\n${blank}",
      order   => 03,
    }
  }

  # Puppet "do not edit" warning
  if ($display_puppet_warning) {
    $puppet_warning_sprint = sprintf("%-${printwidth}s", 'This system is managed by Puppet. Check before editing!')
    concat::fragment { 'motd_puppet':
      target  => $path,
      content => "  ${char}   ${puppet_warning_sprint}   ${char}\n${blank}",
      order   => 04,
    }
  }

  # Puppet environment
  if ($display_puppet_env) {
    $puppet_env_sprint = sprintf("%-${printwidth}s", "Puppet environment: ${environment}")
    concat::fragment { 'motd_puppet_env':
      target  => $path,
      content => "  ${char}   ${puppet_env_sprint}   ${char}\n${blank}",
      order   => 04,
    }
  }

  # Quote of the day
  if ($display_qotd) {
    validate_string($qotd_text)
    validate_string($qotd_author)
    $qotd_text_sprint = sprintf("%-${printwidth}s", "\"${qotd_text}\"")
    $qotd_author_sprint = sprintf("%-${printwidth}s", "       ${qotd_author}")
    concat::fragment { 'motd_qotd':
      target  => $path,
      content => "  ${char}   ${qotd_text_sprint}   ${char}\n  ${char}   ${qotd_author_sprint}   ${char}\n",
      order   => 04,
    }
  }

  # List of services
  $services_sprint = sprintf("%-${printwidth}s", 'This server provides the following services:')
  concat::fragment { 'motd_services':
    target  => $path,
    content => "${blank}  ${char}   ${services_sprint}   ${char}\n",
    order   => 05,
  }

  # Bottom edge of box
  concat::fragment { 'motd_footer':
    target  => $path,
    content => "${blank}${edge}\n",
    order   => '20',
  }
}
