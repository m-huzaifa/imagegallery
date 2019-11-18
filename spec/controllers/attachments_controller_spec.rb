# frozen_string_literal: true

require 'rails_helper'

describe AttachmentsController, type: :controller do
  let!(:attachment) { create(:attachment) }
  let(:valid_attributes) { attributes_for :attachment }
  let(:invalid_attributes) { { title: '' } }

  context 'with admin user signed in' do
    before do
      admin = create(:user, :admin_user)
      sign_in admin
    end

    describe 'GET #show' do
      it 'assign the requested attachment' do
        get :show, params: { id: attachment.id }
        expect(assigns[:attachment]).to eq(attachment)
      end
      it 'render #show view' do
        get :show, params: { id: create(:attachment) }
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #all_attachments' do
      it 'render all_attachments view' do
        get :all_attachments
        expect(response).to render_template(:all_attachments)
      end
      it 'populates an array of attachments' do
        attachment = create(:attachment)
        get :all_attachments
        expect(assigns[:attachments]).to include(attachment)
      end
    end

    describe 'GET #show_gallery' do
      it 'render show_gallery view' do
        get :show_gallery, params: { id: attachment.id }
        expect(response).to render_template(:show_gallery)
      end
    end

    describe 'GET #edit' do
      it 'assignd the required attachment' do
        get :edit, params: { id: attachment.id }
        expect(assigns(:attachment)).to eq(attachment)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        subject { post :create, params: { attachment: valid_attributes } }

        it 'creates a new attachment' do
          expect { subject }.to change { Attachment.count }.by(1)
        end
        it 'redirects to the new attachment' do
          expect(subject).to redirect_to Attachment.last
        end
        it 'assigns a newly created attachment' do
          subject
          expect(assigns(:attachment)).to be_a(Attachment)
          expect(assigns(:attachment)).to be_persisted
        end
      end

      context 'with invalid params' do
        subject { post :create, params: { attachment: invalid_attributes } }

        it 'do not create a new attachment' do
          expect { subject }.not_to change(Attachment, :count)
        end
        it 're-renders the new method' do
          expect(subject).to render_template :new
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        subject { put :update, params: { id: attachment.id, attachment: valid_attributes } }

        it 'located the requested @attachment' do
          subject
          expect(assigns(:attachment)).to eq(attachment)
        end
        it "changes @attachment's attributes" do
          subject
          attachment.reload
          expect(attachment.title).to eq(valid_attributes[:title])
        end
        it 'redirects to the updated attachment' do
          expect(subject).to redirect_to(@attachment)
        end
      end
      context 'with invalid params' do
        subject { put :update, params: { id: attachment.id, attachment: invalid_attributes } }
        it 're-renders the edit method' do
          expect(subject).to render_template :edit
        end
        it "does not change attachment's attributes" do
          subject
          attachment.reload
          expect(attachment.title).not_to eq(invalid_attributes[:title])
        end
      end
    end

    describe 'DELETE #Destroy' do
      it 'deleted the attachment' do
        attachment = create(:attachment, user: subject.current_user)
        expect { delete :destroy, params: { id: attachment.id } }.to change(Attachment, :count).by(-1)
      end
    end

    describe 'Attachment Reaction' do
      let!(:user) { create(:user) }

      context 'POST #like' do
        it 'create new like for attachment' do
          reaction = Reaction.create(user: user, attachment: attachment, status: 1)
          expect(reaction.status).to eq('like')
        end
        it 'update disliked attachment to like' do
          reaction = Reaction.create(user: user, attachment: attachment, status: 0)
          reaction.update(user: user, attachment: attachment, status: 1)
          reaction.reload
          expect(reaction.status).to eq('like')
        end
      end

      context 'POST #dislike' do
        it 'creates dislike for  attachment' do
          reaction = reaction = Reaction.create(user: user, attachment: attachment, status: 0)
          expect(reaction.status).to eq('dislike')
        end
      end
      it 'update liked attachment to dislike' do
        reaction = Reaction.create(user: user, attachment: attachment, status: 1)
        reaction.update(user: user, attachment: attachment, status: 0)
        reaction.reload
        expect(reaction.status).to eq('dislike')
      end
    end
  end

  context 'with client user signed in' do
    before do
      client = create(:user)
      sign_in client
    end

    describe 'GET #show' do
      it 'assign the requested attachment' do
        get :show, params: { id: attachment.id }
        expect(assigns[:attachment]).to eq(attachment)
      end
      it 'render #show view' do
        get :show, params: { id: create(:attachment) }
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #all_attachments' do
      it 'render all_attachments view' do
        get :all_attachments
        expect(response).to render_template(:all_attachments)
      end
      it 'populates an array of attachments' do
        attachment = create(:attachment)
        get :all_attachments
        expect(assigns[:attachments]).to include(attachment)
      end
    end

    describe 'GET #show_gallery' do
      it 'render show_gallery view' do
        get :show_gallery, params: { id: attachment.id }
        expect(response).to render_template(:show_gallery)
      end
    end

    describe 'GET #edit' do
      it 'assignd the required attachment' do
        get :edit, params: { id: attachment.id }
        expect(assigns(:attachment)).to eq(attachment)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        subject { post :create, params: { attachment: valid_attributes } }

        it 'creates a new attachment' do
          expect { subject }.to change { Attachment.count }.by(1)
        end
        it 'redirects to the new attachment' do
          expect(subject).to redirect_to Attachment.last
        end
        it 'assigns a newly created attachment' do
          subject
          expect(assigns(:attachment)).to be_a(Attachment)
          expect(assigns(:attachment)).to be_persisted
        end
      end

      context 'with invalid params' do
        subject { post :create, params: { attachment: invalid_attributes } }

        it 'do not create a new attachment' do
          expect { subject }.not_to change(Attachment, :count)
        end
        it 're-renders the new method' do
          expect(subject).to render_template :new
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        it 'located the requested @attachment' do
          put :update, params: { id: attachment.id, attachment: valid_attributes }
          expect(assigns(:attachment)).to eq(attachment)
        end
        it "changes @attachment's attributes" do
          attachment = create(:attachment, user: controller.current_user)
          put :update, params: { id: attachment.id, attachment: valid_attributes }
          attachment.reload
          expect(attachment.title).to eq(valid_attributes[:title])
        end
        it 'redirects to the updated attachment' do
          attachment = create(:attachment, user: controller.current_user)
          expect(put(:update, params: { id: attachment.id, attachment: valid_attributes })).to redirect_to(attachment)
        end
      end
      context 'with invalid params' do
        it 're-renders the edit method' do
          attachment = create(:attachment, user: controller.current_user)
          expect(put(:update, params: { id: attachment.id, attachment: invalid_attributes })).to render_template :edit
        end
        it "does not change attachment's attributes" do
          put :update, params: { id: attachment.id, attachment: invalid_attributes }
          attachment.reload
          expect(attachment.title).not_to eq(invalid_attributes[:title])
        end
      end
    end

    describe 'DELETE #Destroy' do
      it 'deleted the attachment' do
        attachment = create(:attachment, user: subject.current_user)
        expect { delete :destroy, params: { id: attachment.id } }.to change(Attachment, :count).by(-1)
      end
    end
  end

  context 'with guest user not signed in' do
    describe 'GET #show' do
      it 'assign the requested attachment' do
        get :show, params: { id: attachment.id }
        expect(assigns[:attachment]).to eq(attachment)
      end
      it 'render #show view' do
        get :show, params: { id: create(:attachment) }
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #all_attachments' do
      it 'render all_attachments view' do
        get :all_attachments
        expect(response).to render_template(:all_attachments)
      end
      it 'populates an array of attachments' do
        attachment = create(:attachment)
        get :all_attachments
        expect(assigns[:attachments]).to include(attachment)
      end
    end

    describe 'GET #show_gallery' do
      it 'render show_gallery view' do
        get :show_gallery, params: { id: attachment.id }
        expect(response).to render_template(:show_gallery)
      end
    end
  end
end
