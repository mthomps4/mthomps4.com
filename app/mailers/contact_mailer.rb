class ContactMailer < ApplicationMailer
  def contact_email
    @from = params[:from]
    @body = params[:body]
    mail(from: @from, subject: "Welcome to My Awesome Site", body: @body) do |format|
      format.html { render "contact_email" }
      format.text { render "contact_email" }
    end
  end
end
