# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

job_type :runner, "cd :path && rbenv shell 2.1.4 && bundle exec rails runner -e :environment ':task' :output"

set :output, "/home/deploy/wanderinglabs-availability/shared/log/find_availability.log"

every 15.minutes do
  runner "AvailabilityRequest.find_availability"
end
