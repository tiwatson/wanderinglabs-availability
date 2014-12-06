class AvailabilityNotifier < ActionMailer::Base
  default from: "info@wanderinglabs.com"

  def notify(availability_request_id)
    @availability_request = AvailabilityRequest.find availability_request_id
    @ar = @availability_request
    mail(to: @availability_request.user.email, subject: "Site(s) are available at #{@ar.location.name}")
  end

end
