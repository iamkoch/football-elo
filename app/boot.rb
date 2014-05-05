$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
require 'rubygems'
require 'sinatra'
require 'yajl'
require 'coffee-script'
require 'sinatra/base'
require 'haml'
require 'sass/plugin/rack'
use Sass::Plugin::Rack

require 'app'
require 'models/team'
require 'lib/reader'
require 'csv'