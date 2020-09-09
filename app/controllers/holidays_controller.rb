class HolidaysController < ApplicationController

  before_action :auth_required

  def index
    # sin holidays
    @employees = Employee.select(:id, :people_id, :number).where('id > 396') #.pluck(:id, :people_id, :number)
  end

  def set_employee
    emp_id = params['employee_id'] rescue 0
    employee = Employee.find(emp_id)

    respond_to do |format|
      format.js { render 'set_employee', locals: {employee: employee} }
    end
  end

  def schedule
    emp_id = params['employee_id'] rescue 0
    @employee = Employee.find(emp_id)

    render layout: false
  end

  def reschedule_day

    id = params[:holiday][:id] rescue 0
    new_day = params[:holiday][:day] rescue Date.today

    holy = Holiday.find(id)
    holy.day = new_day

    holy.save!

    term = Term.find(holy.term_id)

    respond_to do |format|
      format.js { render 'reschedule_day', locals: {term: term, employee: holy.employee} }
    end

  end

end
