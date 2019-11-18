# frozen_string_literal: true

require 'rails_helper'

describe 'visitors/index.html.erb', type: :view do
  before do
    user = create(:user)
    #  sign_in user
  end
  let!(:valid_params) { attributes_for(:user) }

  it 'show user view' do
    user = create(:user)
    # attachment = create(:attachment, user: user)
    assign(:users, [
             create(:user)
           ])
  end
end
