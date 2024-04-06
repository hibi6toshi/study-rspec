RSpec::Matchers.define :have_content_type do |expected|
  # matcher には match メソッドが必要
  match do |actual|
    content_types = {
      html: 'text/html',
      json: 'application/json'
    }
    actual.content_type.include? content_types[expected.to_sym]
  end
end
