require 'rails_helper'

RSpec.describe "searches/index", type: :view do
  before(:each) do
    assign(:searches, [
      Search.create!(
        :user => nil,
        :user_search => "User Search"
      ),
      Search.create!(
        :user => nil,
        :user_search => "User Search"
      )
    ])
  end

  it "renders a list of searches" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "User Search".to_s, :count => 2
  end
end
