SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.items = Menu.active.all
  end
end