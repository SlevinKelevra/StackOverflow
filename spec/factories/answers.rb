FactoryGirl.define do
  factory :answer do
    question
    body "MyText"

    factory :invalid_answer do
      body nil
    end
  end

end
