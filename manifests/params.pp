#-----------------------------------------------------------------------------
#   Copyright (c) 2012 Bryce Johnson
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#-----------------------------------------------------------------------------
class confluence::params {
  # resource types do not allow hiera to be expressed directly
  # so continuing to use params.pp as a variable holder
  # they are also required for the var lookup for the templates
  $version      = hiera('confluence_version')
  $product      = hiera('confluence_name')
  $format       = hiera('confluence_package_format')
  $installdir   = hiera('confluence_install_dir')
  $webappdir    = "${installdir}/atlassian-${product}-${version}"
  $homedir      = hiera('confluence_home_dir')

  # License crap
  $license_hash    = hiera('confluence_license_hash')
  $license_message = hiera('confluence_license_message') 
  $setup_server_id = hiera('confluence_setup_server_id')

  # Database Settings
  $db           = hiera('confluence_db')
  $dbuser       = hiera('confluence_dbuser')
  $dbpassword   = hiera('confluence_dbpassword')
  $dbserver     = hiera('confluence_dbserver')
  $dbname       = hiera('confluence_dbname')
  $dbport       = hiera('confluence_dbport')
  $dbdriver     = hiera('confluence_dbdriver')
  $dbtype       = hiera('confluence_dbtype')
  $dbdialect    = hiera('confluence_dbdialect')
  $dburl        = "jdbc:${db}://${dbserver}:${dbport}/${dbname}"

  # JVM Settings
  $javahome     = hiera('confluence_javahome')
  $jvm_xmx      = hiera('confluence_jvm_xmx')
  $jvm_optional = hiera('confluence_jvm_optional')

  # With my experience, this URL shouldn't ever change and can be
  # used for all Atlassian products, their versions, and file format.
  # It's also cdn cached. :)
  # TODO: maybe toss this into atlassian.yaml for hiera
  $downloadURL = "http://www.atlassian.com/software/${product}/downloads/binary/atlassian-${product}-${version}.${format}"

  $tmpdir  = '/tmp'

  case $::osfamily {
    'Darwin' : {
      # HTFU macboy - go download and install wget
      $cmdwget = '/usr/local/bin/wget'
      $confluence_init_path = '/etc/rc.d/init.d/confluence'
    }
    'Redhat': {
      $cmdwget = '/usr/bin/wget'
      $confluence_init_path = '/etc/rc.d/init.d/confluence'
    }
    'Debian': {
      $cmdwget = '/usr/bin/wget'
      $confluence_init_path = '/etc/init.d/confluence'
    }
    default : {
      $cmdwget = '/usr/bin/wget'
      $confluence_init_path = '/etc/rc.d/init.d/confluence'
    }
  }
}
