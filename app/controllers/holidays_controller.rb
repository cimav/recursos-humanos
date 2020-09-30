class HolidaysController < ApplicationController

  before_action :auth_required

  @role_ids = []

  def index
    # sin holidays
    @employees = Employee.select(:id, :people_id, :number).where('id > 396') #.pluck(:id, :people_id, :number)
  end

  def set_employee
    emp_id = params['employee_id'] rescue 0
    @employee = Employee.find(emp_id)

    respond_to do |format|
      format.js { render 'set_employee', locals: {employee: @employee} }
    end
  end

  def schedule
    emp_id = params['employee_id'] rescue 0
    @employee = Employee.find(emp_id)

    render layout: false
  end

  def reschedule_day

    term = nil
    employee = nil
    holy_ids = params[:holiday][:hollies][0].split(',')
    next_day = params[:holiday][:initial_day].to_date rescue Date.today
    holy_ids.each do |h_id|
      holy = Holiday.find(h_id)
      holy.day = next_day

      holy.save!

      next_day = skip_weekends(next_day, 1)

      if term.nil?
        term = holy.term
      end
      if employee.nil?
        employee = holy.employee
      end

    end

    respond_to do |format|
      format.js { render 'reschedule_day', locals: {term: term, employee: employee} }
    end

  end

  def skip_weekends(date, inc = 1)
    date += inc
    date += inc while date.wday == 0 || date.wday == 6
    date
  end

end
