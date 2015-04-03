Fabricator(:user) do
  username           { Faker::Internet.user_name }
  email              { Faker::Internet.email }
  student_number     { Faker::Number.number(6).to_s }
  password           { Faker::Internet.password }
end
