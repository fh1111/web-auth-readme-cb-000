class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create


  def create
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
      req.params['client_id'] = 'GBMY10DPP5TWMWQLHUBQ3YHOWB1RVSZP3I2JZETH0DIKVWVV'
      req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
      req.params['client_secret'] = 'XD1QKIZ3RBH20CE5GSUIOJUBQHCFDYSRGCZ4X5PC5QL1XSPU'
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://142.93.113.210:45020/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end

end
