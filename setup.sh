#!/bin/bash

require_version='3.7.3'
puppet_version=$(rpm -q --queryformat '%{VERSION}' puppet)
[ "$puppet_version" = "$require_version" ] || {
    yum -y update
    rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
    rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
    yum install -y "puppet-${require_version}"
}
cp -a /vagrant/lib/* /var/lib/puppet/lib
