class RequestFormatting
  attr_reader :request

  def initialize(folder_path_type, request)
    @folder_path_type = folder_path_type
    @request = request
    @user = current_user
  end

  def output
    @folder_path_type.output(self)
  end

  def path
    path = request.original_fullpath.gsub(/^\//, "")
    path
  end

  def subdomain
    subdomain = request.subdomain
  end
end
