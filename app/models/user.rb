# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  second_name            :string
#  role                   :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # :invitable, :database_authenticatable, :registerable, :validatable, :invitable, :api,
  #   :recoverable, :rememberable, :confirmable

  devise :invitable, :database_authenticatable, :registerable, :validatable, :invitable, :api,
         :recoverable, :rememberable, :confirmable
end
