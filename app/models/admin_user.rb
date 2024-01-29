# frozen_string_literal: true

# == Schema Information
#
# Table name: admin_users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#  status     :integer          default("inactive")
#  role       :integer          default("admin")
#
# Indexes
#
#  index_admin_users_on_user_id  (user_id)
#
class AdminUser < ApplicationRecord
  belongs_to :user

  enum status: { inactive: 0, active: 1 }
  enum role: { admin: 0, super_admin: 1 }
end
