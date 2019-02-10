RSpec.describe 'users API', type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }

  context 'with admin user' do
    let(:user) { create(:user, :admin) } 
    before { allow_any_instance_of(DecodeAuthCommand).to receive(:result).and_return(user) }
    describe 'API User' do
      let(:email) { Faker::Internet.email }
      let(:password) { Faker::Internet.password }
      let(:valid_attributes) { { email: email, password: password } }

      context 'Create user, role employee' do
        before { post "/api/v1/users", params: valid_attributes }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'Show user by id' do
        before { get "/api/v1/users/#{user_id}"}

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'List all users' do
        before { get '/api/v1/users'}

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'Update users' do
        before { put "/api/v1/users/#{user_id}", params: valid_attributes }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'delete users' do
        before { delete "/api/v1/users/#{user_id}" }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end