class ContactController < ApplicationController
  def show
    @contact = Contact.first
  end
end
