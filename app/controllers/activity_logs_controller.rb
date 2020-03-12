class ActivityLogsController < ApplicationController
	skip_before_action :verify_authenticity_token, :only => [:consultar_info, :index]
	def index
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
			salida = [200, res]
		else
			salida = [400, res]
		end

		respond_to do |format|
	  		format.json { render json: salida}
		end
	end
end
