class SecretsController < ApplicationController
  before_action :require_login
  def index
    @secrets = Secret.all
    
  end
end
