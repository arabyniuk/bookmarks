module PathFormatter
  extend ActiveSupport::Concern

  def folder_path
    request.original_fullpath.gsub(/^\//, "")
  end

  def folder_path_without_prefix
    folder_path.gsub(/^(h.*?\/+)/, "")
  end

  def folder_path_title
    Mechanize.new.get(folder_path).title
  end

  def fit_folder_path_subdomain?
    subdomain.empty? || subdomain =~ /www|tweet/
  end

  def subdomain
    request.subdomain
  end

  def decode_path
    URI.decode(folder_path)
  end

  def decode_path_text
    decode_path.gsub(/\&[d]=[0-9]*/, "")
  end

  def decode_path_delay_time
    decode_path.to_s.scan(/\d+$/).first.to_i
  end

  def decode_path_delay_to_min
    decode_path_delay_time.minutes.from_now
  end

  def tweet_delay_minutes
    Time.now + decode_path_delay_time.minutes
  end

  def is_there_path_text?
    !decode_path_text.blank? && decode_path_delay_time.zero?
  end

  def is_there_path_text_with_time?
    !decode_path_text.nil? && !decode_path_delay_time.zero?
  end
end
