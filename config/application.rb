require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module DraperTV
    class Application < Rails::Application
        # Settings in config/environments/* take precedence over those specified here.
        # Application configuration should go into files in config/initializers
        # -- all .rb files in that directory are automatically loaded.

        # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
        # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
        # config.time_zone = 'Central Time (US & Canada)'
        config.assets.enabled = true
        config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts','components')
        config.assets.paths << "#{Rails.root}/app/assets/fonts"
        config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

        # config.serve_static_assets = true
        config.serve_static_files = true
        # We don't want the default of everything that isn't js or css, because it pulls too many things in
        config.assets.precompile.shift
        config.action_dispatch.default_headers = {
            'X-Frame-Options' => 'ALLOWALL'
        }
        # Explicitly register the extensions we are interested in compiling
        config.assets.precompile.push(Proc.new do |path|
                                        File.extname(path).in? [
                                            '.html', '.erb', '.haml',                 # Templates
                                            '.png',  '.gif', '.jpg', '.jpeg', '.svg', # Images
                                            '.eot',  '.otf', '.svc', '.woff', '.ttf', # Fonts
                                        ]
        end)

        social_keys = File.join(Rails.root, 'config', 'social_keys.yml')
        CONFIG = HashWithIndifferentAccess.new(YAML::load(IO.read(social_keys)))[Rails.env]
        CONFIG.each do |k,v|
            ENV[k.upcase] ||= v
        end

        # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
        # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
        # config.i18n.default_locale = :de

    end
end
