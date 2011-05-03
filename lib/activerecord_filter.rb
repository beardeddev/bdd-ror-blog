class ActiverecordFilter
  
  attr_accessor :columns
  attr_accessor :object_name
  
  def initialize(model, params, cols=[])
    @object_name = model.class_name.downcase
    if cols.blank?
      @columns = model.columns      
      @columns.each do |col|
        build_filter(col, params)
      end
    else
      @columns = Array.new
      cols.each do |col|
        @columns.push(model.columns[col.to_sym])
        build_filter(model.columns[col.to_sym], params)
      end
    end  
  end
  
  private
  def build_filter(col, params)
    param_name = col.name.to_sym
    if(params[param_name] && !params[param_name].empty?)
      self.instance_eval("def #{param_name} \n '#{params[param_name]}'\n end")
    else
      self.instance_eval("def #{param_name} \n nil \n end")
    end
  end
end