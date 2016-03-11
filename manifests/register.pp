# used by other modules to register themselves in the motd
define motd::register($content='', $order=10) {
  include ::motd

  if $content == '' {
    $body = $name
  } else {
    $body = $content
  }

  $body_sprint = sprintf("%-${motd::printwidth}s", "  - ${body}")
  concat::fragment{"motd_fragment_${name}":
    target  => '/etc/motd',
    content => "  ${motd::char}   ${body_sprint}   ${motd::char}\n",
  }
}
