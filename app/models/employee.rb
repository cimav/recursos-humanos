class Employee  < ActiveRecord::Base

  establish_connection :"cimav_production"
  self.table_name = "#{self.connection.current_database}.employees"

  self.abstract_class = true

  belongs_to :user, class_name: 'User', foreign_key: 'people_id'

  has_many :holidays

  def fullname
    user.fullname
  end

end