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
#  nickname    :string
#

class Kid < ActiveRecord::Base
  def name
    nickname.blank? ? "#{ fname } #{ lname }" : "#{ fname } '#{ nickname }' #{ lname }"
  end

  def email
    "#{ net_id }@cornell.edu"
  end
end
