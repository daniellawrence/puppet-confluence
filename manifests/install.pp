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
class confluence::install {

  require confluence::params

  case $::osfamily {
    'Darwin' : { # assuming you did download wget - ill maybe fix this and check for it
      exec { 'wget-confluence-package':
        cwd     => "${confluence::params::tmpdir}",
        command => "${confluence::params::cmdwget} --no-check-certificate ${confluence::params::downloadURL}",
        creates => "${confluence::params::tmpdir}/atlassian-${confluence::params::product}-${confluence::params::version}.${confluence::params::format}",
      }
    }
    default : {
      exec { 'wget-confluence-package':
        cwd     => "${confluence::params::tmpdir}",
        command => "${confluence::params::cmdwget} --no-check-certificate ${confluence::params::downloadURL}",
        creates => "${confluence::params::tmpdir}/atlassian-${confluence::params::product}-${confluence::params::version}.${confluence::params::format}",
      }
    }
  }

  exec { 'mkdirp-installdir':
    cwd     => "${confluence::params::tmpdir}",
    command => "/bin/mkdir -p ${confluence::params::installdir}",
    creates => "${confluence::params::installdir}",
  }
  exec { 'unzip-confluence-package':
    cwd     => "${confluence::params::installdir}",
    command => "/usr/bin/unzip -o -d ${confluence::params::installdir} ${confluence::params::tmpdir}/atlassian-${confluence::params::product}-${confluence::params::version}.${confluence::params::format}",
    creates => "${confluence::params::webappdir}",
    require => [Exec['wget-confluence-package'],Exec['mkdirp-installdir']],
  }

  file { '/etc/rc.d/init.d/confluence':
    content => template('confluence/etc/rc.d/init.d/confluence.erb'),
    mode    => '0755',
  }
}
