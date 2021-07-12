# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# stops Rails from creating a field_error class for displaying validation error messages
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance| 
    html_tag.html_safe
end