module AcceptanceMacros
  def list_questions(questions)
    visit questions_path
    questions.each do |q|
      expect(page).to have_content q.title
    end
  end
end