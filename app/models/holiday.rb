class Holiday < ApplicationRecord
  belongs_to :term
  belongs_to :employee

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

end
