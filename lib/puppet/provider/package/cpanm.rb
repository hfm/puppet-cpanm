require 'puppet/provider/package'

Puppet::Type.type(:package).provide(:cpanm, :parent => Puppet::Provider::Package) do
  desc "Package provider for cpanminus"

  commands :cpanm => '/usr/bin/cpanm'

  def install(useversion = true)
    command = [command(:cpanm)]
    command << resource[:name]

    output = execute(command)
    self.fail "Could not install: #{output.chomp}" if output.include?("failed")
  end

  def uninstall
    cpanm '--uninstall', resource[:name]
  end
end
