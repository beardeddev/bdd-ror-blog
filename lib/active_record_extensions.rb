module ActiveRecord
  class Base
    def self.search(params = {})
      self.paginate(:page => params[:page] || 1, :conditions => self.build_filter(params), :order => params[:order] || "created_at DESC")      
    end
    
    def self.build_filter(params = {})
      filter = { :clause => '', :conditions => []}
      if params && !params.empty?
        if params[:q] && !params[:q].empty?
          self.columns.each do |col|
            unless filter[:clause] == ''
                filter[:clause] << ' OR '              
              end
              case col.type.to_sym
              when :string
                filter[:clause] << "#{col.name} LIKE ?"
                filter[:conditions] << "#{params[:q]}%"
              when :datetime
                filter[:clause] << "DATE(#{col.name}) = DATE(?)"
                filter[:conditions] << params[:q]
              else
                filter[:clause] << "#{col.name} = ?"
                filter[:conditions] << params[:q]
              end
          end
        else
          self.columns.each do |col|
            param_name = col.name.to_sym
            if(params[param_name] && !params[param_name].empty?)
              unless filter[:clause] == ''
                filter[:clause] << ' AND '              
              end
              case col.type.to_sym
              when :string
                filter[:clause] << "#{col.name} LIKE ?"
                filter[:conditions] << "#{params[param_name]}%"
              when :datetime
                filter[:clause] << "DATE(#{col.name}) = DATE(?)"
                filter[:conditions] << params[param_name]
              else
                filter[:clause] << "#{col.name} = ?"
                filter[:conditions] << params[param_name]
              end            
            end
          end
        end
      end      
      unless(filter[:clause].empty? && filter[:conditions].empty?)
        filter[:clause].to_a + filter[:conditions]
      end
    end
    
  end  
end