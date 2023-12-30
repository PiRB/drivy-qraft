# frozen_string_literal: true
require 'date'
require 'json'
require 'virtus'
require './models/action'
require './models/car'
require './models/commission'
require './models/rent'
require './services/actions/create'
require './services/commissions/create'
require './services/response_generator/create'

ResponseGenerator::Create.new.call