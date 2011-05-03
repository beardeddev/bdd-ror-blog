# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.
    #
    # primary.item :key_1, 'name', url, options

    # Add an item which has a sub navigation (same params, but with block)
    # primary.item :key_2, 'name', url, options do |sub_nav|
      # Add an item to the sub navigation (same params again)
    #  sub_nav.item :key_2_1, 'name', url, options
    # end
    unless @current_user
      primary.item :alogin, 'Вход', login_url
    else
      primary.item :alogin, 'Выход', logout_url
    end
    if @current_user && @current_user.admin?
      primary.item :admin, 'Адмистрирование', admin_posts_path do |admin|
        admin.item :admin_posts, 'Посты', admin_posts_path do |admin_posts|
          if @post
            unless @post.new_record?
              admin_posts.item :admin_post_edit, 'Редактировать', edit_admin_post_path(@post)
            else
              admin_posts.item :admin_post_new, 'Добавить', new_admin_post_path
            end
          end
        end
        admin.item :admin_pages, 'Страницы', admin_pages_path do |admin_pages|
          if @page
            unless @page.new_record?
              admin_pages.item :admin_page_edit, 'Редактировать', edit_admin_page_path(@page)
            else
              admin_pages.item :admin_page_new, 'Добавить', new_admin_page_path
            end
          end
        end
         admin.item :admin_categories, 'Категории', admin_categories_path do |admin_categories|
          if @category
            unless @category.new_record?
              admin_categories.item :admin_category_edit, 'Редактировать', edit_admin_category_path(@category)
            else
              admin_categories.item :admin_category_new, 'Добавить', new_admin_category_path
            end
          end
        end
        admin.item :admin_tags, 'Теги', admin_tags_path do |admin_tags|
          if @tag
            unless @tag.new_record?
              admin_tags.item :admin_tags_edit, 'Редактировать', edit_admin_tag_path(@tag)
            else
              admin_tags.item :admin_tags_new, 'Добавить', new_admin_tag_path
            end
          end
        end
        admin.item :admin_users, 'Пользователи', admin_users_path do |admin_users|
          if @user
            unless @user.new_record?
              admin_users.item :admin_users_edit, 'Редактировать', edit_admin_user_path(@user)
            else
              admin_users.item :admin_users_new, 'Добавить', new_admin_user_path
            end
          end
        end
        admin.item :admin_roles, 'Роли', admin_roles_path do |admin_roles|
          if @role
            unless @role.new_record?
              admin_roles.item :admin_roles_edit, 'Редактировать', edit_admin_role_path(@role)
            else
              admin_roles.item :admin_roles_new, 'Добавить', new_admin_role_path
            end
          end
        end
        admin.item :admin_comments, 'Комментарии', admin_comments_path do |admin_comments|
          if @comment
            unless @comment.new_record?
              admin_comments.item :admin_comments_edit, 'Редактировать', edit_admin_comment_path(@comment)
            else
              admin_comments.item :admin_comments_new, 'Добавить', new_admin_comment_path
            end
          end
        end
        admin.item :admin_menu, 'Ссылки меню', admin_menu_index_path do |admin_menu|
          if @link
            unless @link.new_record?
              admin_menu.item :admin_menu_edit, 'Редактировать', edit_admin_menu_path(@link)
            else
              admin_menu.item :admin_menu_new, 'Добавить', new_admin_menu_path
            end
          end
        end
      end
    end

    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    # primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    # primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    # primary.dom_class = 'menu-class'

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

  end

end