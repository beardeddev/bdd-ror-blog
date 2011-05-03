module CaptchaHelper
  def captcha_tag
    captcha_image = image_tag captcha_path
    html = "<div class='left'>"
    html << text_field_tag("comment[captcha_text]", params[:captcha_text], :class => 'required')
    html << "введите код </div>"
    html << "<div class='left'>#{captcha_image}"
    html << "</div>"
    if(flash[:error])
      html << "<div class='fieldWithErrors right s235'>#{flash[:error]}</div>"
    end
    html
  end
end
