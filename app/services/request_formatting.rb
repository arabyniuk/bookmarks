class RequestFormatting
  attr_reader :request, :controller

  def initialize(folder_path_type, request, controller)
    @folder_path_type = folder_path_type
    @request = request
    @controller = controller
  end

  def output
    @folder_path_type.output(self)
  end

  def path
    path = request.original_fullpath.gsub(/^\//, "")
    path
  end

  def subdomain
    request.subdomain
  end
end
