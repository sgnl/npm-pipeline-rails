require 'rails/generators/base'

module NpmPipeline
  module Generators
    class WebpackGenerator < Rails::Generators::Base
      desc 'Adds Webpack configuration via npm-pipeline-rails'
      source_root File.expand_path('../webpack', __FILE__)

      def copy_files
        [
          'package.json',
          'yarn.lock',
          'webpack.config.js',
          'app/webpack/css/app.js',
          'app/webpack/css/components/example.scss',
          'app/webpack/js/app.js',
          'app/webpack/js/behaviors/example.js'
        ].each { |f| template f, f }
      end

      def update_assets
        append_to_file Dir['app/assets/stylesheets/application.*{css,scss,sass}'].first,
          "/*\n *= require webpack/app\n */\n"

        append_to_file Dir['app/assets/javascripts/application.js*'].first,
          "//= require webpack/app\n"
      end

      def update_gitignore
        append_to_file '.gitignore',
          "\n/node_modules" +
          "\n/vendor/assets/stylesheets/webpack" +
          "\n/vendor/assets/javascripts/webpack\n"
      end
    end
  end
end
