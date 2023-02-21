class SessionsController < ApplicationController
    def new
    end

    def create 
        if GlobalSetting.find_by(name: "admin_username").nil?
            if params[:session][:username] == "admin" and params[:session][:password] == "password"
                session[:admin] = true
                flash[:notice] = "Επιτυχής σύνδεση!"
                redirect_to recipes_path
            else
                flash.now[:alert] = "Λάθος συνθηματικά, προσπάθησε ξανά!"
                render 'new'
            end
        else
            if params[:session][:username] == GlobalSetting.find_by(name: "admin_username").value.first and params[:session][:password] == GlobalSetting.find_by(name: "admin_password").value.first
                session[:admin] = true
                flash[:notice] = "Επιτυχής σύνδεση!"
                redirect_to recipes_path
            else
                flash.now[:alert] = "Λάθος συνθηματικά, προσπάθησε ξανά!"
                render 'new'    
            end  
        end
    end

    def destroy 
        session[:admin] = false
        flash[:notice] = "Επιτυχής αποσύνδεση"
        redirect_to root_path
    end
end