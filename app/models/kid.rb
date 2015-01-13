# == Schema Information
#
# Table name: kids
#
#  id          :integer          not null, primary key
#  net_id      :string
#  fname       :string
#  lname       :string
#  address     :string
#  phone       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :text
#  is_accepted :boolean
#

class Kid < ActiveRecord::Base
  def name
    "#{ fname } #{ lname }"
  end
end
