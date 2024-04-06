RSpec::Matchers.define :have_content_type do |expected|
  # matcher には match メソッドが必要
  match do |actual|
    begin
      actual.content_type.include? content_type(expected)
    rescue ArgumentError
      false
    end
  end

  # 失敗メッセージ(failure message)
  failure_message do |actual|
    "Expected \"#{content_type(actual.content_type)} " +
    "(#{actual.content_type})\" to be Content Type" +
    "\"#{content_type(expected)}\" (#{expected})"
  end

  # 否定の失敗メッセージ(negated failure message)
  failure_message_when_negated do |actual|
    "Expected \"#{content_type(actual.content_type)}" +
    "(#{actual.content_type})\" to not be Content Type" +
    "\"#{content_type(expected)}\" (#{expected}})"
  end

  def content_type(type)
    types = {
      html: 'text/html',
      json: 'application/json'
    }
    types[type.to_sym] || 'unknow content type'
  end
end

RSpec::Matchers.alias_matcher :be_content_type, :have_content_type
