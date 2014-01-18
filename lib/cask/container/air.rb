class Cask::Container::Air < Cask::Container::Base
  def self.me?(criteria)
    %w[.air].include?(criteria.path.extname)
  end

  def extract
    executable = '/Applications/Utilities/Adobe AIR Application Installer.app/Contents/MacOS/Adobe AIR Application Installer'
    args = ['-silent', '-location', @cask.destination_path, Pathname.new(@path).realpath]

    if !Pathname(executable).exist?
      raise CaskError.new <<-ERRMSG.undent
      Error installing application: Adobe AIR runtime not present, try installing it via

          brew cask install adobe-air

      ERRMSG
    end

    @command.run!(executable, :args => args)
  end
end
