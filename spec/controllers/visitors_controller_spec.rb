# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VisitorsController, type: :controller do
  context 'GET #index' do
    it 'render index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
