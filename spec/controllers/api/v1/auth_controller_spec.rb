RSpec.describe 'auth controller', type: :request do
  context 'authenticate in app' do
    let(:user) { create(:user) } 
    before { allow_any_instance_of(DecodeAuthCommand).to receive(:result).and_return(user) }
    describe 'User try authenticate in app' do
      let(:valid_attributes) { { email: user.email, password: user.password } }
      let(:invalid_attributes) { { email: "wrong@email.com", password: "" } }

      context 'User has right credentials' do
        before { post "/api/v1/auth", params: valid_attributes }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'User has wrong credentials' do
        before { post "/api/v1/auth", params: invalid_attributes }

        it 'returns status code 401' do
          expect(response).to have_http_status(401)
        end
      end
    end
  end
end