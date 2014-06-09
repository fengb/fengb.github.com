require "middleman-core"
require "middleman-core/load_paths"
require "middleman-core/preview_server"

Middleman.setup_load_paths

module Middleman::PreviewServer
  def self.preview_in_rack
    @options = { latency: 0.25 }
    @app = new_app
    start_file_watcher
  end
end

Middleman::PreviewServer.preview_in_rack
run Middleman::PreviewServer.app.class.to_rack_app
