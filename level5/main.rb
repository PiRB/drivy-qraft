# frozen_string_literal: true
require 'date'
require 'json'
require 'virtus'
require './models/action'
require './models/car'
require './models/commission'
require './models/option'
require './models/rent'
require './services/actions/create'
require './services/commissions/create'
require './services/rents/pricing'
require './services/response_generator/create'
require '../lib/read_data'

ResponseGenerator::Create.new.call