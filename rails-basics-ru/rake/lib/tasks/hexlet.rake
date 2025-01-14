# frozen_string_literal: true

require 'csv'

namespace :hexlet do
  desc 'Creates users from scv file'
  task :import_users, [:file] => :environment do |_, args|
    path = args[:file]

    abort 'File path is required!' unless path
    abort 'Cant find data file!' unless File.exist?(path)

    users = CSV.read(path, headers: true)

    users.each do |user|
      user['birthday'] = Date.strptime(user['birthday'], '%m/%d/%Y')
      User.create!(user)
    end
  end
end
