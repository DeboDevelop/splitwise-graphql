module CmAdmin
    class ApplicationController < ActionController::Base
        include Authentication
        before_action :authenticate_user!
        layout 'cm_admin'
    end
end
  