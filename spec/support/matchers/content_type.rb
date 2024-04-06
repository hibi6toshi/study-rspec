RSpec::Matchers.define :have_content_type do |expected|
  # matcher には match メソッドが必要
  match do |actual|
    begin
      actual.content_type.include? content_types[expected]
    rescue ArgumentError
      false
    end
  end

  def content_types(type)
    types = {
      html: 'text/html',
      json: 'application/json'
    }
    types[type.to_sym] || 'unknow content type'
  end
end
