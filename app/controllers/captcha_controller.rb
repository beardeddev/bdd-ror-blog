class CaptchaController < ApplicationController
  require 'RMagick'
  include Magick

  def show
    chars = ('a'..'z').to_a + ('A'..'Z').to_a
    text = (0...6).collect { chars[Kernel.rand(chars.length)] }.join.downcase

    session[:captcha_text] = text

    capcha_image = Image.new(85, 30)
    capcha_image.format = 'PNG'
    captcha_text = Magick::Draw.new
    captcha_text.annotate(capcha_image, 0, 0, 0, 2, text) do
      self.font = 'Helvetica'
      self.pointsize = 22
      self.font_weight = Magick::BoldWeight
      self.gravity = Magick::CenterGravity
    end
    capcha_image = capcha_image.wave(2.5, 70)

    send_data capcha_image.to_blob, :type => 'image/jpeg', :disposition => 'inline', :layout => false

  end
end
