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
class confluence::config{

  require confluence::params

  exec { 'mkdirp-homedir':
    cwd     => "${confluence::params::tmpdir}",
    command => "/bin/mkdir -p ${confluence::params::homedir}",
    creates => "${confluence::params::homedir}"
  }

  file { "${confluence::params::webappdir}/bin/setenv.sh":
    content => template('confluence/setenv.sh.erb'),
    mode    => '0755',
    require => Class['confluence::install'],
  }

  file { "${confluence::params::webappdir}/confluence/WEB-INF/classes/confluence-init.properties":
    content => template('confluence/confluence-init.properties.erb'),
    mode    => '0755',
    require => Class['confluence::install'],
  }

  if $confluence::params::manage_config {
    file { "${confluence::params::homedir}/confluence.cfg.xml":
      content => template('confluence/${confluence::params::db}.confluence.cfg.erb'),
      mode    => '0600',
      require => [Class['confluence::install'],Exec['mkdirp-homedir']],
    }
  }
}
