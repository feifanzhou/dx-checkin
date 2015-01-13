# == Schema Information
#
# Table name: kids
#
#  id         :integer          not null, primary key
#  net_id     :string
#  fname      :string
#  lname      :string
#  address    :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image      :text
#

class Kid < ActiveRecord::Base
end
