class PicsController < ApplicationController
    before_filter :find_pic, except: [:index, :new, :create]

    def index
        @pics = Pic.all.order('created_at DESC')
    end

    def new
        @pic = current_user.pics.build
    end

    def create
        @pic = current_user.pics.build(pic_params)

        if @pic.save
            redirect_to @pic, notice: "¡Si! ¡fue posteada!"
        else
            render 'new'
        end
    end

    def update
        if @pic.update(pic_params)
            redirect_to @pic, notice: "¡Felicitaciones! la foto fue actualizada"
        else
            render 'edit'
        end
    end

    def destroy
        @pic.destroy
        redirect_to root_path, notice: "La foto ha sido eliminada"
    end

    private
        def pic_params
            params.require(:pic).permit(:title, :description)
        end

        def find_pic
            @pic = Pic.find(params[:id])
        end
end
