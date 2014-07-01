if defined?(ChefSpec)

  def install_newrelic_sysmond(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sysmond, :install, resource_name)
  end

  def uninstall_newrelic_sysmond(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sysmond, :uninstall, resource_name)
  end

  def configure_newrelic_sysmond(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sysmond, :configure, resource_name)
  end

  def disable_newrelic_sysmond(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:sysmond, :disable, resource_name)
  end

end
