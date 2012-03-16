require 'tempfile'
require 'loquendo/version'

class Loquendo

  VALID_VOICES = [:fernanda, :ludoviko]

  attr_accessor :command_dir, :command, :voice, :sound_dir, :sound_file

  class CommandNotFound < Exception; end
  class InvalidVoice < Exception; end

  def initialize(opts = {})
    @command_dir = opts[:command_dir] || '/opt/Loquendo/LTTS7/bin'
    @command     = opts[:command]     || 'SaveFile-alaw'
    @sound_dir   = opts[:sound_dir]   || Dir::tmpdir
    @sound_file  = opts[:sound_file]  || 'ltts'
    @voice       = opts[:voice]       || :fernanda
    session      = opts[:session]     || '/opt/Loquendo/LTTS7/bin/default.session'
  end

  def self.convert(string, opts = {})
    ltts = Loquendo.new(opts)
    ltts.convert(string)
  end

  def self.convert_to_file(string, opts = {})
    ltts = Loquendo.new(opts)
    ltts.convert_to_file(string)
  end

  def session
    ENV['LTTS7_DEFAULTSESSION']
  end

  def session=(default_session)
    ENV['LTTS7_DEFAULTSESSION'] = default_session
  end

  def convert(string)
    check_for_command
    validate_voice
    _convert(string)
  end

  def convert_to_file(string)
    check_for_command
    validate_voice
    _convert_to_file(string)
  end

  def command_path
    command_dir + '/' + command
  end

  def sound_path
    sound_dir + '/' + sound_file
  end

  private

  def check_for_command
    if !File.exists?(command_path) || !File.executable?(command_path)
      raise CommandNotFound, "Command #{command_path} not found or not executable"
    end
  end

  def validate_voice
    if !is_valid_voice?
      raise InvalidVoice, "Voice '#{voice.to_s}' is not a valid voice"
    end
  end

  def is_valid_voice?
    Loquendo::VALID_VOICES.include?(voice)
  end

  def _convert_to_file(string)
    system("#{command_path} #{voice.to_s} \"#{string}\" \"#{sound_path}\"")
  end

  def _convert(string)
    result    = nil
    temp_file = Tempfile.new(sound_file, sound_dir)

    if system("#{command_path} #{voice.to_s} \"#{string}\" \"#{temp_file.path}\"")
      result = File.read(temp_file.path)
    end

    temp_file.unlink
    return result
  end

end
