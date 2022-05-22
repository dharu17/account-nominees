# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
Account.create(username: 'Raji', first_name: 'Raji', last_name: 'Priyanka', email: 'raji@gmail.com', password: 'Test@123')
Account.create(username: 'Shakeer', first_name: 'M', last_name: 'Shakeer', email: 'shakeer@gmail.com', password: 'Test@123')
Account.create(username: 'Dharani', first_name: 'Dharu', last_name: 'Abhi', email: 'dharu@gmail.com', password: 'Test@123')

Nominee.create(nominee_id: Account.first.id, account_id: Account.last.id, weightage: 20)
