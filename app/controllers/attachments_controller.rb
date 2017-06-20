class AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find(params[:id])
    if current_user.author?(@attachment.attachable)
      @attachment.destroy
      flash[:notice] = 'Your attachment successfully deleted.'
    else
      flash[:notice] = 'You cannot delete this attachment.'
    end
  end
end