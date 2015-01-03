class AvailabilityNotifier < ActionMailer::Base
  default from: "info@wanderinglabs.com"

  def notify(availability_request_id)
    @availability_request = AvailabilityRequest.find availability_request_id
    @ar = @availability_request

    @availabilities_new = @ar.availabilities.is_available.to_notify.order(:date_start)
    @availabilities_past = @ar.availabilities.is_available.where('notified_at is not null').order(:date_start)

    mail(to: @availability_request.user.email, subject: "Site(s) are available at #{@ar.location.name}")
  end

end
