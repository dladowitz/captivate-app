class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    render layout: "guest_pages/guest_layout"
  end

  def create
    @contact = Contact.new contact_params

    if @contact.save
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
