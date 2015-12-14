class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    render layout: "contact_pages/contact_layout"
  end

  def create
    @contact = Contact.new contact_params

    if @contact.save
      # Tried doing this as an :after_create in the model, but root_url wasn't available
      @contact.showing_tracking_url__c = root_url + "contacts/#{@contact.id}/showing_trackings/new"
      @contact.save

      redirect_to contacts_path
    else
      redirect_to new_contact_path
    end
  end

  def index
    @contacts = Contact.all
    render layout: "guest_pages/guest_layout"
  end


  private

  def contact_params
    params.require(:contact).permit(:firstname, :lastname, :email, :name)
  end
end
