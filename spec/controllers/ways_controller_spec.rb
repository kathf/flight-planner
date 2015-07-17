# very much a work in progress

require 'rails_helper'

RSpec.describe WaysController, type: :controller do
  render_views

  describe '#set_location' do
    context 'user location detected' do
      get :show, params: { id: articles(:first).id }, xhr: true

      let(  ) { cookies[:lat_lng] }
      expect(subject).to receive(:set_location)
    end

    # context 'no user location detected' do
    # end
  end

  describe '#index' do

    specify 'that the page loads successfully' do
      get :index
      expect(response).to be_success
      expect(response).to render_template('index')
    end

    # context 'initial visit to page' do
    # end
    #
    # context ''
    # end
  end

  describe '#update' do
    let(:way) { Way.create!(origin: Airport.find(2346)) }

    before  { get :update, id: way.id }
    subject { response }

    it { is_expected.to respond_with(403) }
  end

end


 #  describe '#create' do
 #    specify 'that user is redirected to show page' do
 #      post :create, person: { name: 'Eddie', email: 'me@murphy.com' }
 #      expect(response).to redirect_to person_url(Person.last)
 #    end
 #  end
 #
 #  describe '#create' do
 #   context 'valid attributes' do
 #     let(:attrs) { { name: 'Mike' } }
 #
 #     specify 'that a person is created' do
 #       expect { post :create, person: attrs }.to change { Person.count }.by(1)
 #     end
 #
 #     specify 'that the user is redirected' do
 #       post :create, person: attrs
 #       expect(response).to redirect_to(person_url(Person.last))
 #     end
 #   end
 #
 #   context 'invalid attributes' do
 #     let(:attrs) { { name: '' } }
 #
 #     specify 'that a person is NOT created' do
 #       expect { post :create, person: attrs }.to_not change { Person.count }
 #     end
 #
 #     specify 'that the form is rendered again' do
 #       post :create, person: attrs
 #       expect(response).to render_template('new')
 #     end
 #   end
