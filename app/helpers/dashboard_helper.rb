module DashboardHelper
  
  def add_link_to(path)
    link_to 'Добавить', path, :class => 'add', :title => 'Добавить'
  end
  
  def destroy_selected_link_to
    link_to 'Удалить выбранные', 'javascript:document.forms["table"].submit()', :class => 'delete', :title => 'Удалить выбранные',
      :confirm => 'Удалить выбранные???'
  end

  def edit_link_to(path)
    link_to "Редактировать", path, :class => 'edit', :title => 'Редактировать'
  end
  
  def destroy_link_to(entity)
    link_to 'Удалить', [:admin, entity], :class => 'delete', :method => 'delete', :title => 'Удалить', :confirm => 'Вы уверенны что хотите удалить запись?'
  end
  
  def back_link_to(path)
    link_to 'Назад', path, :title => 'Назад', :class => 'back'
  end
  
  def edit_image_link_to(path)
    img = image_tag 'page_edit.png', :alt => 'Редактировать', :title => 'Редактировать'
    link_to img, path, :title => 'Редактировать'
  end
  
  def destroy_image_link_to(entity)
    img = image_tag 'page_delete.png', :alt => 'Удалить', :title => 'Удалить'
    link_to img, [:admin, entity], :method => 'delete', :title => 'Удалить',
    :confirm => 'Вы уверенны что хотите удалить запись?'
  end
  
  def status_image_tag(status)
    case status
      when 1
      image_tag 'bullet_green.png', :alt => 'Активно', :title => 'Активно'
      when 2
      image_tag 'bullet_delete.png', :alt => 'Удалено', :title => 'Удалено'
      when 3
      image_tag 'bullet_orange.png', :alt => 'Модерируется', :title => 'Модерируется'
    end 
  end
  
  def form_for_filter(filter)
    form_tag request.url, :method => :get do
      "<ul>" +
      fields_for_fiter(filter).to_s +
      "</ul>"
    end
  end
  
  private
  def fields_for_fiter(filter)
    if filter
      fields = ''
      filter.columns.each do |col|
        fields += "<li>"
        fields += label_tag col.name.to_sym, I18n.translate("activerecord.attributes.#{filter.object_name}.#{col.name}")        
        fields += text_field_tag col.name.to_sym, filter.send(:eval, "#{col.name}") 
        fields += "</li>"
      end
      fields += "<li>"
      fields += submit_tag 'Поиск'
      fields += submit_tag 'Сбросить', :onclick => "window.location.href ='#{request.path}'; return false;"
      fields += "</li>"
    end
  end
end