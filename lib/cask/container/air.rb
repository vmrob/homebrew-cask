class Cask::Container::Air < Cask::Container::Base
  def self.me?(criteria)
    %w[.air].include?(criteria.path.extname)
  end

  def extract
  	executable = '/Applications/Utilities/Adobe AIR Application Installer.app/Contents/MacOS/Adobe AIR Application Installer'
    args = ['-silent', '-location', @cask.destination_path, @path]
  	
    if !Pathname(executable).exist?
    	raise CaskError.new(<<-ERRMSG)
Error installing application: Adobe Air runtime not present, try installing via `brew cask install adobe-air`
    ERRMSG
    end

  	begin
  	  @command.run!(executable, :args => args)
  	rescue
	  raise CaskError.new(<<-ERRMSG)
Error installing application.
  command was:
  #{executable} #{args.map { |arg| arg }.join(' ')}
  ERRMSG
    end
  end
end
