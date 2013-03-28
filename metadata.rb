name             "newrelic"
maintainer       "Kirill Kouznetsov"
maintainer_email "agon.smith@gmail.com"
license          "Apache 2.0"
description      "Installs and configures Newrelic system monitor daemon"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

supports 'debian'
supports 'ubuntu'

depends 'apt'