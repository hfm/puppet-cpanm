# == Class: cpanm::install
#
# Full description of class cpanm here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'cpanm':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
class cpanm::package (
  $ensure = $cpanm::ensure,
  $user   = $cpanm::user,
  $target = $cpanm::target,
) {

  if $target {
    if !defined(File[$target]) {
      file { $target:
        ensure => directory,
        before => Exec['standalone'],
      }
    }

    exec { 'standalone':
      path    => '/bin:/usr/bin',
      cwd     => $target,
      command => 'curl -LO http://xrl.us/cpanm; chmod +x cpanm',
      creates => "${target}/cpanm",
    }
  }
  else {
    if $user == 'root' {
      exec { 'install cpanm':
        command => 'curl -L http://cpanmin.us | perl - --sudo App::cpanminus',
        user    => $user,
        creates => '/usr/local/bin/cpanm',
      }
    }
    else {
      exec { 'install cpanm':
        command => 'curl -L http://cpanmin.us | perl - App::cpanminus',
        user    => $user,
      }
    }
  }

}
