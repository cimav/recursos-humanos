class Holiday < ApplicationRecord
  belongs_to :term
  belongs_to :employee

  attr_accessor :hollies
  attr_accessor :initial_day

  SCHEDULED = 1
  TAKEN = 2
  RESCHEDULED = 3

  @@STATUS = {
      SCHEDULED => 'Programados',
      TAKEN => 'Tomados',
      RESCHEDULED => 'Re-programados'
  }.freeze

  def status_text
    @@STATUS[status.to_i]
  end

  def check_range
    (term.start..term.end).cover?(day)
  end

  def situation
    if Holiday.where(employee_id: employee_id, day: day).limit(3).pluck(:term_id, :employee_id, :day).size > 1
      # duplicada
      'is-danger'
    elsif !(term.start - 6.months..term.end + 6.months).cover?(day)
      # fuera del año
      'is-danger is-light'
    elsif !(term.start..term.end).cover?(day)
      # fuera del periodo de vacaciones ordinarias
      'is-info is-light'
    elsif [0, 6].include?(day.wday)
      # es fin de semana todo faltan días festivos
      'is-warning is-light'
    else
      # dentro del periodo ordinario y correcto
      'is-success is-light'
    end
  end

end
