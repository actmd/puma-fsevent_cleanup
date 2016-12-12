require 'puma/plugin'

Puma::Plugin.create do
  def config(dsl)
    Puma::Launcher.class_eval do
      def fire_plugins_restart
        @config.plugins.fire_restarts self
      end
    end

    Puma::PluginLoader.class_eval do
      def fire_restarts(launcher)
        @instances.each do |i|
          i.restart(launcher) if i.respond_to? :restart
        end
      end
    end

    dsl.on_restart(&:fire_plugins_restart)
  end
end
