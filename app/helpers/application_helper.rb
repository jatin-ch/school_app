module ApplicationHelper
  def ensure_breadcrumbs
  	_items = [ { :title => 'Home', :url => '/' } ]
  	if params[:controller].eql?('schools')
  	  _items << { :title => 'schools', :url => schools_path }
  	  if params[:id]
  	  	_items << { :title => params[:id], :url => school_path(params[:id]) }
        if params[:action].eql?('edit')
          _items << { :title =>  params[:action] }
        end
      elsif params[:action].eql?('new')
        _items << { :title =>  params[:action] }
  	  end
  	elsif params[:school_id]
  	  _items << { :title => 'schools', :url => schools_path }
  	  _items << { :title => params[:school_id], :url => school_path(params[:school_id]) }
  	  
  	  if params[:controller].eql?('courses')
  	  	_items << { :title => 'courses', :url => school_courses_path(params[:school_id]) }
  	  	if params[:id]
  	  	  _items << { :title => params[:id], :url => school_course_path(params[:school_id], params[:id]) }
          if params[:action].eql?('edit')
            _items << { :title =>  params[:action] }
          end
        elsif params[:action].eql?('new')
          _items << { :title =>  params[:action] }
  	  	end
  	  elsif params[:course_id]
  	  	_items << { :title => 'courses', :url => school_courses_path(params[:school_id]) }
  	  	_items << { :title => params[:course_id], :url => school_course_path(params[:school_id], params[:course_id]) }

  	  	if params[:controller].eql?('batches')
  	  	  _items << { :title => 'batches', :url => school_course_batches_path(params[:school_id], params[:course_id]) }
  	  	  if params[:id]
  	  	  	_items << { :title => params[:id], :url => school_course_batch_path(params[:school_id], params[:course_id], params[:id]) }
            if params[:action].eql?('edit')
              _items << { :title =>  params[:action] }
            end
          elsif params[:action].eql?('new')
            _items << { :title =>  params[:action] }
  	  	  end
  	    elsif params[:batch_id]
  	      _items << { :title => 'batches', :url => school_course_batches_path(params[:school_id], params[:course_id]) }
  	  	  _items << { :title => params[:batch_id], :url => school_course_batch_path(params[:school_id], params[:course_id], params[:batch_id]) }

  	  	  if params[:controller].eql?('enrollments')
  	  	    _items << { :title => 'enrollments', :url => school_course_batch_enrollments_path(params[:school_id], params[:course_id], params[:batch_id]) }
  	        if params[:id]
  	  	     _items << { :title => params[:id], :url => school_course_batch_enrollment_path(params[:school_id], params[:course_id], params[:batch_id], params[:id]) }
              if params[:action].eql?('edit')
                _items << { :title =>  params[:action] }
              end
            elsif params[:action].eql?('new')
              _items << { :title =>  params[:action] }
  	        end
  	      end
  	    end
  	  end
  	end

    if params[:controller].eql?('users')
      _items << { :title => 'users', :url => users_path } if can? :read, User
      if params[:id]
        _items << { :title => params[:id], :url => user_path(params[:id]) }
        if params[:action].eql?('edit')
          _items << { :title =>  params[:action] }
        end
      elsif params[:action].eql?('new')
        _items << { :title =>  params[:action] }
      elsif params[:action].eql?('enrollments')
        _items << { :title =>  params[:action] }
      elsif params[:action].eql?('show_enrollments')
        _items << { :title =>  'enrollments', url: enrollments_users_path }
        _items << { :title =>  params[:enrollment_id], url: enrollment_users_path(params[:enrollment_id]) }
      elsif params[:action].eql?('new_enrollment')
        _items << { :title =>  'enrollments', url: enrollments_users_path }
        _items << { :title =>  'new', url: enrollments_new_users_path }
      end
    end
  	_items
  end

  def render_breadcrumbs
    render :partial => 'partials/breadcrumbs', locals: { nav: ensure_breadcrumbs }
  end
end
