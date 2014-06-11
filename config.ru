require "middleman-core/preview_server"

module Middleman::PreviewServer
  def self.to_rack_app(opts = {})
    @options = opts
    @options[:latency] ||= 0.25

    require "middleman-core/load_paths"
    Middleman.setup_load_paths

    @app = new_app
    start_file_watcher
    @app.class.to_rack_app
  end
end

run Middleman::PreviewServer.to_rack_app
