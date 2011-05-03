# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def archive_link_to(archive)
    year = archive.created_at.strftime("%Y")
    month =  archive.created_at.strftime("%m")
    link_to "#{Russian.localize(archive.created_at, :format => '%B')}&nbsp;#{year}&nbsp;(#{archive.count})",  archive_url(:month => month, :year => year)
  end

  def flash_tag
    flash.each do |key, val|
      case key
        when :notice
          return "<div class='form-message correct'>#{val}</div>"
        when :success
          return "<div class='form-message correct'>#{val}</div>"
        when :error
          return "<div class='form-message error'>#{val}</div>"
        when :warning
          return "<div class='form-message warning'>#{val}</div>"
      end
    end
  end

end
