# Description

Installs Newrelic system monitor daemon.

# Attributes

* `node['newrelic']['package_name']` Name of package that will be insalled. Default: `newrelic-sysmond`
* `node['newrelic']['apt']['repo']` Newrelic repo url.
* `node['newrelic']['apt']['keyfile']` Key file url.
* `node['newrelic']['apt']['distribution']` Apt disctribution option.
* `node['newrelic']['apt']['components']` Apt components option.

Next attributes are only for 'recipe[newrelic::install]'. You do not need then if you want to use LWRPs.

* `node['newrelic']['license_key']` Newrelic license key to access api.
* `node['newrelic']['enabled']` Allows "recipe[newrelic::install]" to install and configure newrelic. Default: `false`

# Recipes

## default 

Empty recipe for you. Just to be sure LWRPs are accessible.

## install

If you do not want to use LWRP than set attributes and use this recipe.

# LWRP

## newrelic_sysmond

**Actions:** Default: `[:install, :configure]`

* `:install` Installs Newrelic system monitor daemon package.
* `:configure` Configure daemon, enable and run its service.
* `:disable` Disable new newrelic system monitoring service.
* `:uninstall` Uninstall package.

**Attributes:**

* `key` - *Name attribute;* License key for your Newrelic account. Default: `nil`

# Example

```ruby
newrelic_sysmond 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
```

# License and Authors

* Kirill Kouznetsov <agon.smith@gmail.com>

Copyright 2013, Kirill Kouznetsov

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.