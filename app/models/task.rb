class Task < ApplicationRecord
  belongs_to :project
  
  validates :status, inclusion: { in: ['not-started', 'in-progress', 'completed']}

  STATUS_OPTIONS = [
    ['Not started', 'not-started'],
    ['In progress', 'in-progress'],
    ['Completed', 'completed']
  ]

  def badge_color
    case status
    when 'not-started'
      'secondary'
    when 'in-progress'
      'info'
    when 'completed'
      'success'
    end
  end

  def complete?
    status == "completed"
  end 

  def in_progress?
    status == "in-progress"
  end

  def not_started?
    status == "not-started"
  end
  
end
