RSpec::Matchers.define :be_abstract do
  match do |actual|
    actual.new
    false
  rescue NotImplementedError => _e
    true
  end
end
