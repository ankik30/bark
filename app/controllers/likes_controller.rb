class LikesController < ApplicationController
    before_action :find_dog
    before_action :find_like, only: [:destroy]

    def create
        if already_liked?
            flash[:notice] = "You have already like this."
        else   
        @dog.likes.create(user_id: current_user.id)
        redirect_to dog_path(@dog)
      end
    end

    def destroy
        if !(already_liked?)
          flash[:notice] = "Cannot unlike"
        else
          @like.destroy
        end
        redirect_to dog_path(@dog)
    end

    def find_like
        binding.pry
        @like = @dog.likes.find(params[:id])
     end

    private
    
    def find_dog
        binding.pry
        @dog = Dog.find(params[:dog_id])
    end

    def already_liked?
        binding.pry
        Like.where(user_id: current_user.id, dog_id:
        params[:dog_id]).exists?
      end
end
