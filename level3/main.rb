# frozen_string_literal: true
require 'json'
require 'date'
require 'virtus'
require './models/car'
require './models/commission'
require './models/rent'
require './services/commissions/create'
require './services/response_generator'

ResponseGenerator.new.call