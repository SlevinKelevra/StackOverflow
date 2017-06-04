FactoryGirl.define do
  factory :answer do
    body 'My text'
    question

    factory :invalid_answer do
      body nil
    end
  end

end
