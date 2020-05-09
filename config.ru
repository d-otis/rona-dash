require_relative './config/environment'

require 'sinatra'

API.new.start

use ContinentsController
use CountriesController
use StatesController

run ApplicationController
