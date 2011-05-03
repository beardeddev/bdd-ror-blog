class ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::AssetTagHelper
  
  alias :non_i18n_label :label
  alias :non_i18n_label_tag :label_tag
  
  def status_select_field(method, options={})
    choices = options_from_collection_for_select(Status.all, "id", "title", @object.instance_variable_get("@#{method}"))
    select_tag "#{@object_name}[#{method}]", choices, options
  end
  
  def label(name)
    non_i18n_label name, I18n.translate("activerecord.attributes.#{@object_name}.#{name}")
  end

  def captcha(method, path)
    input = text_field method
    img = image_tag path
    "<span class='left'>#{input}<br/>введите код</span><span class='left'>#{img}</span>"
  end
    
  
end