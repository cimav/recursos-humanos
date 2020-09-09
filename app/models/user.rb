class User < ActiveRecord::Base

  establish_connection :"cimav_production"
  self.table_name = "#{self.connection.current_database}.people"

  self.abstract_class = true

  has_one :employee, foreign_key: 'people_id'

  def fullname
    first_name + ' ' + paternal_name + ' ' + maternal_name
  end

  def account
    email_cimav.split('@')[0] rescue 'Email Invalido'
  end

  def shortname
    account.titleize.gsub('.', ' ') rescue 'Sin Nombre Corto'
  end

  def display_url
    "https://cimav.edu.mx/foto/#{account}/256"
  end

end
