require 'puma/plugin'

Puma::Plugin.create do
  def config(dsl)
    dsl.plugin :add_plugin_restart_hook
  end

  # call #stop on all FSEvent instances
  # this should close pipes and make fsevent_watch'es die
  def restart(_launcher)
    return unless defined? FSEvent
    ObjectSpace.each_object(FSEvent, &:stop)
  end
end
