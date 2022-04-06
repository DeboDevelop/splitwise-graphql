module Authentication
    extend ActiveSupport::Concern
  
    included do
      before_action :check_current_user
    end
  
    private
    def check_current_user
      if current_user
        # byebug
        Current.user = current_user
      end
    end
end