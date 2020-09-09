class Term < ApplicationRecord
  # has_many :holidays

  @holidays_by_status

  def holidays_count(status)
    @holidays_by_status = Holiday.where(term_id: self.id, status: status).order(:day)
    @holidays_by_status.size
  end

  def holidays_by_status
    @holidays_by_status
  end

end
