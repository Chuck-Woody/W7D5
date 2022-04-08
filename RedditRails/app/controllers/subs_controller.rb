class SubsController < ApplicationController

    # before_action :require_logged_in, only: [:edit, :create]
    def index 
        @subs = Sub.all 
        render :index
    end

    def show 
        @sub = Sub.find_by(id: params[:id])
        render :show
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.mod_id = current_user.id
        if @sub.save
            redirect_to sub_url(@sub.id)
        else
            flash.now[:errors] = @sub.error.full_messages
            redirect_to new_sub_url
        end
    end

    def edit
        if current_user.id == self.mod_id
            render :edit
        end
    end

    private

    def sub_params
        params.require(:sub).permit(:title, :description, :mod_id)
    end
end
