require 'rails_helper'

RSpec.describe "meetings/show", type: :view do
  before(:each) do
    @meeting = assign(:meeting, Meeting.create!(
      :address => "Address",
      :subject => "MyText",
      :confirm => false,
      :useridtext => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
  end
end
