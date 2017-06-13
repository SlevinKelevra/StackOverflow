FactoryGirl.define do
  sequence :body do |n|
    "My text#{n}"
  end

  factory :answer do
    body
    question
    user

    factory :invalid_answer do
      body nil
      user
    end
  end

end
