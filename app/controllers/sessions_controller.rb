require 'json'
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

    def upload_file
    end

    def bulk_add_recipes
        file = File.open(params[:recipes_file])
        file_content = file.readlines.map(&:chomp)
        file_content.each do |recipe|
            recipe_params = recipe.split("|")
            name = recipe_params[0]
            orient = recipe_params[1]
            categories = recipe_params[2].split(",")
            shape = recipe_params[3]
            instructions = recipe_params[5]
            portions = recipe_params[6].to_i > 0 ? recipe_params[6].to_i : 1
            excecution_time = recipe_params[7].to_i
            difficulty = (recipe_params[8].to_i > 0 and recipe_params[8].to_i <= 5) ? recipe_params[8].to_i : 1
            photo = recipe_params[8] == " " ? nil : recipe_params[8]
            materials = recipe_params[4].split(',')
            materials_array = []
            materials.each do |material|
                material_inside = material.split(" ")
                material_inside_hash = {}
                if material_inside.size >= 3
                    if  material_inside.all? {|l| l.to_i == 0}
                        material_inside_hash['Ποσότητα'] = 1
                        material_inside_hash['Όνομα'] = material_inside.join(" ")
                    else
                        material_inside_hash['Ποσότητα'] = material_inside[0].to_i
                        material_inside_hash['Μονάδα'] = material_inside[1]
                        material_inside.delete(material_inside[0])
                        material_inside.delete(material_inside[0])
                        material_inside_hash['Όνομα'] = material_inside.join(" ")
                    end
                elsif material_inside.size == 2
                    if material_inside.all? {|l| l.to_i == 0}
                        material_inside_hash['Ποσότητα'] = 1
                        material_inside_hash['Όνομα'] = material_inside.join(" ")
                    else
                        material_inside_hash['Ποσότητα'] = material_inside[0].to_i
                        material_inside.delete(material_inside[0])
                        material_inside_hash['Όνομα'] = material_inside.join(" ")
                    end
                elsif material_inside.size == 1
                    material_inside_hash['Ποσότητα'] = 1
                    material_inside_hash['Όνομα'] = material_inside[0]
                else
                    material_inside_hash['Ποσότητα'] = 0
                    material_inside_hash['Όνομα'] = material_inside[0]
                end
                materials_array << material_inside_hash
            end
            materials_json = materials_array.to_json
            materials_per_portion_array = []
            materials_array.each do |material|
                material['Ποσότητα'] = material['Ποσότητα'] / portions.to_f
                materials_per_portion_array << material
            end
            materials_per_portion_json = materials_per_portion_array.to_json
            admin =  session[:admin].nil? or session[:admin] == false ? false : true
            new_recipe = Recipe.create(name: name,orient: orient,difficulty: difficulty,excecution_time: excecution_time,instructions: instructions,portions: portions,for_review: false,from_admin: session[:admin],shape: shape,materials: materials_json,materials_per_portion: materials_per_portion_json,categories: categories)
        end
        redirect_to  recipes_path
    end
end