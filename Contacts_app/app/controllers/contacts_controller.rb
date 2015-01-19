class ContactsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @contacts = user.contacts
    @contact_shares = user.shared_contacts
    render json: @contacts + @contact_shares
  end

  def show
    @contact = Contact.find(params[:id])
    render json: @contact
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy!
    render json: @contact
  end

  private

  def contact_params
    params.require(:contact).permit([:name, :email, :user_id])
  end
end
