class ActivityLogsController < ApplicationController
	skip_before_action :verify_authenticity_token, :only => [:consultar_info, :index]
	def index
		parametros = {}
		@bebes = []
		@asistentes = []
		header = {"Content-Type" => "application/json" , "Accept" => "application/json",  "User" => ENV.fetch("User"), "Auth-Token" => ENV.fetch("Auth_Token")}
		url_base = "https://api-guarderia.herokuapp.com/api/babies"
		response = HTTParty.get("#{url_base}", :query => parametros, :headers =>header)
		res = JSON.parse response.body
		if response.code == 200
			@bebes = res
		end
		header = {"Content-Type" => "application/json" , "Accept" => "application/json",  "User" => ENV.fetch("User"), "Auth-Token" => ENV.fetch("Auth_Token")}
		url_base = "https://api-guarderia.herokuapp.com/api/assistants"
		response = HTTParty.get("#{url_base}", :query => parametros, :headers =>header)
		res = JSON.parse response.body
		if response.code == 200
			@asistentes = res
		end
	end

	def other_page
		redirect_to activity_logs_url
	end

	def consultar_info
		puts "vamos con consultar info"
		salida = []
		parametros = {"baby_id" => params["baby_id"] , "assistant_id" => params["assistant_id"], "status" => params["status"], "page"=> params["page"]}
		header = {"Content-Type" => "application/json" , "Accept" => "application/json",  "User" => ENV.fetch("User"), "Auth-Token" => ENV.fetch("Auth_Token")}
		url_base = "https://api-guarderia.herokuapp.com/api/all_activity_logs"
		response = HTTParty.get("#{url_base}", :query => parametros, :headers =>header)
		res = JSON.parse response.body
		if response.code == 200
			logs = []
			Time.zone = "Monterrey"
			res.each do |x|
				x["start_time"] = x["start_time"].in_time_zone.strftime("%d-%B-%Y %I:%M %p ")
			end
			salida = [200, res]
		else
			salida = [400, res]
		end

		respond_to do |format|
	  		format.json { render json: salida}
		end
	end
end
