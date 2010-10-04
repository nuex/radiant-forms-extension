module Forms
  module Models
    module Extension
      def self.included(base)
        base.class_eval do 
          def initialize(form, page)
            @form   = form
            @page   = page
            
            @data   = Forms::Config.deep_symbolize_keys(@page.data)
            
            # Sets the config to be the current environment config: checkout:
            @config = @form[:extensions][self.class.to_s.underscore.gsub('form_', '').to_sym]
          end
          
          def current_user
            return @current_user if @current_user.present? 
            @current_user = UserActionObserver.current_user
          end
          
        end
      end
    end
  end
end