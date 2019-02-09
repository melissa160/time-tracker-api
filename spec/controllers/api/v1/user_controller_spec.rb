RSpec.describe 'users API', type: :request do
  let!(:users) { create_list(:user, 10) }
  #let(:user_id) { users.first.id }

  context 'with admin user' do
    before do
      allow_any_instance_of(DecodeAuthCommand).to receive(:result).and_return(user)
    end
    describe ' /api/v1/users/{user_id}' do
      # Admin user factory
      let(:user) { create(:user, :admin) } 
      let(:valid_attributes) { { user: { email: Faker::Internet.email, password: "hay password" } } }

      # context 'Create user, role employee' do
      #   before { post "/api/v1/users", params: valid_attributes }

      #   it 'returns status code 200' do
      #     puts "reponseeeeeee"
      #     puts response.inspect
      #     expect(response).to have_http_status(200)
      #   end
      # end

      # context 'Show user by id' do
      #   before { get "/api/v1/users/#{user_id}", params: {} }

      #   it 'returns status code 200' do
      #     expect(response).to have_http_status(200)
      #   end
      # end

      context 'List all users' do
        before { get '/api/v1/users', params: {} }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end