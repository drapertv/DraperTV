# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :challenge, :class => 'Challenges' do
    playlist_id 1
    description "MyText"
    title "MyString"
    view_count 1
    url "MyString"
    vthumbnail "MyString"
  end
end
