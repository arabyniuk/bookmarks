class LinkFolderPath
  def output(context)
    #WeeklyNotifier.received(current_user).deliver
    current_user = context.controller.current_user
    if !context.subdomain.empty? || !context.path.empty?
      unless context.subdomain.empty? || context.subdomain =~ /www|tweet/
        category = Category.where(name: context.subdomain,
                                  user_id: current_user.id)
                           .first
        if category.nil?
           category = Category.new({name: context.subdomain,
                                    user_id: current_user.id})
           category.save
        end
      end
      unless context.path.empty?
        begin
          title = Mechanize.new.get(context.path).title
        rescue Exception => e
          flash[:notice] = e.message
        end
        path = context.path.gsub(/^(h.*?\/+)/, "")
        link = Link.new({url: context.path,
                         title: title,
                         user_id: current_user.id })
        link.category_id = category.id unless context.subdomain.empty? || context.subdomain =~ /www|tweet/
        link.save
      end
      redirect_to context.controller.root_url(subdomain: false)
    end
  end
end
