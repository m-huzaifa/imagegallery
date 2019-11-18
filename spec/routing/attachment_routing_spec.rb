# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for attachments', type: :routing do
  it 'routes GET /attachments to the attachments#index' do
    expect(get('/attachments')).to route_to('attachments#index')
  end
  it 'routes post /attachments to attachments#create' do
    expect(post('/attachments')).to route_to('attachments#create')
  end
  it 'routes GET /attachments/new to attachments#new' do
    expect(get('/attachments/new')).to route_to('attachments#new')
  end
  it 'routes GET /attachments/12/edit to attachments#edit' do
    expect(get('/attachments/12/edit')).to route_to('attachments#edit', id: '12')
  end
  it 'routes GET /attachments/12 to attachments#show' do
    expect(get('/attachments/12')).to route_to('attachments#show', id: '12')
  end
  it 'routes put /attachments/12 to attachments#update' do
    expect(put('/attachments/12')).to route_to('attachments#update', id: '12')
  end
  it 'routes patch /attachments/12 to attachments#update' do
    expect(patch('/attachments/12')).to route_to(controller: 'attachments', action: 'update', id: '12')
  end
  it 'routes patch /attachments/12 to attachments#destroy' do
    expect(delete('/attachments/12')).to route_to(controller: 'attachments', action: 'destroy', id: '12')
  end
  it 'routes post /attachments/12/like to attachments#like' do
    expect(post('/attachments/12/like')).to route_to('attachments#like', id: '12')
  end
  it 'routes post /attachments/12/dislike to attachments#dislike' do
    expect(post('/attachments/12/dislike')).to route_to('attachments#dislike', id: '12')
  end
  it 'routes GET /all_attachments to the attachments#sll_attachments' do
    expect(get('/all_attachments')).to route_to('attachments#all_attachments')
  end
  it 'routes GET /12/attachments to the attachments#show_gallery' do
    expect(get('/12/show_gallery')).to route_to('attachments#show_gallery', id: '12')
  end
end
