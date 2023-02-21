class GlobalSettingsController < ApplicationController
    before_action :require_admin

    def update 
        setting = GlobalSetting.find(params[:global_setting][:id])
        setting.update_column(:value,params[:global_setting][:value].split(","))
        respond_to do |format|
            format.html { redirect_to global_settings_index_path, notice: "Setting was successfully updated." }
        end
    end

    def index 
        @global_settings = GlobalSetting.all
    end

    private

    def require_admin
        if current_user.nil? or current_user == false
            respond_to do |format|
                format.html { redirect_to recipes_path, notice: "Πρέπει να είσαι διαχειριστής για να μπεις σε αυτό το μενού" }
            end
        end
    end
end