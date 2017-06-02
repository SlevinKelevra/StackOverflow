FactoryGirl.define do
  factory :answer do
    body "MyText"
  end

  factory :invalid_answer, class: Answer do
    title nil
    body nil
  end
end
