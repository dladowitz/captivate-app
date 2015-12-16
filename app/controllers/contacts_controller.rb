class ContactsController < ApplicationController
  def new
    @contact = Contact.new
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
  end

  def show
    @contact = Contact.find params[:id]
  end

  def create_password
    @contact = Contact.find_by_sfid params[:contact_id]
  end

  def update
    @contact = Contact.find params[:id]
    @contact.update contact_params

    if @contact.save
      flash[:success] = "Awesome. You're account is all setup."
      redirect_to contact_path(@contact)
    else
      flash[:danger] = "Hmmm, something has gone wrong."
      render :create_password
    end
  end



  private

  def contact_params
    params.require(:contact).permit(:firstname, :lastname, :email, :name, :password, :password_confirmation)
  end
end
