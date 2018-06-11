module DeviseHelper
  
#    def devise_error_messages!
#      return "" unless devise_error_messages?
#  
#      messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
#      sentence = I18n.t("errors.messages.not_saved",
#                        :count => resource.errors.count,
#                        :resource => resource.class.model_name.human.downcase)
#  
#      html = <<-HTML
#      <div class="col-md-12 alert alert-dismissible alert-danger">
#        <h5>
#        #{sentence}
#        <br>
#        #{messages}
#        </h5>
#      </div>
#      HTML
  
#      html.html_safe
#    end
def devise_error_messages!
  if resource.errors.full_messages.any?
      flash.now[:error] = resource.errors.full_messages.join("  &  ")
  end
  return ''
end
  
    def devise_error_messages?
      !resource.errors.empty?
    end
  
end