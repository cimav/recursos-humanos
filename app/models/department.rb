class Department < ActiveRecord::Base

  establish_connection :"cimav_production"
  self.table_name = "#{self.connection.current_database}.departments"

  self.abstract_class = true

  def code
    '00000'
  end

end
