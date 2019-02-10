RSpec.describe 'time tracker employees controller', type: :request do  
  context 'with admin user' do
    let(:user) { create(:user, :admin) }
    let(:employee) { create(:user) }
    before { allow_any_instance_of(DecodeAuthCommand).to receive(:result).and_return(user) }
    
    describe 'Create time-in register' do
      let(:tag) { Faker::HarryPotter.location }
      let(:valid_attributes) { { time_tracker_employee: { tag: tag, user_id: employee.id } } }

      context 'Create time-in register succesfully' do
        before { post "/api/v1/time-tracker-employees/in", params: valid_attributes }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'Not posible create register, employee id does not exist' do
        let(:invalid_attributes) { { time_tracker_employee: { tag: tag, user_id: employee.id+1 } }}
        before { post "/api/v1/time-tracker-employees/in", params: invalid_attributes }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end
    end

    describe 'Create time-out register' do
      let(:tag) { Faker::HarryPotter.location }
      let(:valid_attributes) { { time_tracker_employee: { tag: tag, user_id: employee.id } } }

      context 'Create time-out register succesfully' do
        before { post "/api/v1/time-tracker-employees/out", params: valid_attributes }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'Not posible create register, employee id does not exist' do
        let(:invalid_attributes) { { time_tracker_employee: { tag: tag, user_id: employee.id+1 } }}
        before { post "/api/v1/time-tracker-employees/out", params: invalid_attributes }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end
    end
  end

  context 'with employee user' do
    let(:user) { create(:user) }
    let(:employee) { create(:user) }
    before { allow_any_instance_of(DecodeAuthCommand).to receive(:result).and_return(user) }
    
    describe 'Create time-in register' do
      let(:tag) { Faker::HarryPotter.location }
      let(:valid_attributes) { { time_tracker_employee: { tag: tag, user_id: employee.id } } }

      context 'Create time-in register succesfully' do
        before { post "/api/v1/time-tracker-employees/in", params: valid_attributes }

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end

      context 'Not posible create register, employee id does not exist' do
        let(:invalid_attributes) { { time_tracker_employee: { tag: tag, user_id: employee.id+1 } }}
        before { post "/api/v1/time-tracker-employees/in", params: invalid_attributes }

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end
    end

    describe 'Create time-out register' do
      let(:tag) { Faker::HarryPotter.location }
      let(:valid_attributes) { { time_tracker_employee: { tag: tag, user_id: employee.id } } }

      context 'Create time-out register succesfully' do
        before { post "/api/v1/time-tracker-employees/out", params: valid_attributes }

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end

      context 'Not posible create register, employee id does not exist' do
        let(:invalid_attributes) { { time_tracker_employee: { tag: tag, user_id: employee.id+1 } }}
        before { post "/api/v1/time-tracker-employees/out", params: invalid_attributes }

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end
    end
  end
end