FactoryGirl.define do
  factory :answer do
    body 'My text'
    question
    user

    factory :invalid_answer do
      body nil
      user
    end
  end

end
