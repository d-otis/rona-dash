require_relative './config/environment'

require 'sinatra'

API.new.start

use ContinentsController
use CountriesController

run ApplicationController
