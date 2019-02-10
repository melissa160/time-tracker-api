RSpec.describe 'time tracker reports controller', type: :request do  
  context 'with admin user' do
    let(:admin) { create(:user, :admin) }
    let(:employee) { create(:user) }
    let(:employee_id) { employee.id }
    before { allow_any_instance_of(DecodeAuthCommand).to receive(:result).and_return(admin) }
    
    describe 'Request report by employee id list' do
      let!(:time_tracker_employee_1) { create(:time_tracker_employee, :in, user_id: employee_id)}
      let!(:time_tracker_employee_2) { create(:time_tracker_employee, :out, user_id: employee_id)}
      let(:valid_attributes) { { start_at: (Time.now.utc - 1.day), end_at: (Time.now.utc + 1.day), user_ids: [employee_id] } }

      context 'Return report succesfully' do
        before { post "/api/v1/time-tracker-reports", params: valid_attributes }

        it 'returns status code 200 and two registers' do
          expect(json.size).to eq(2)
          expect(response).to have_http_status(200)
        end
      end

      context 'Return empty report when employee id does not exist' do
        let(:invalid_attributes) { { start_at: (Time.now.utc - 1.day), end_at: (Time.now.utc + 1.day), user_ids: [employee_id + 10] } }
        before { post "/api/v1/time-tracker-reports", params: invalid_attributes }

        it 'returns status code 200 and empty list' do
          expect(json.size).to eq(0)
          expect(response).to have_http_status(200)
        end
      end
    end

    describe 'Request report for employee view when you are admin' do
      let!(:time_tracker_employee_1) { create(:time_tracker_employee, :in, user_id: admin.id)}
      let(:valid_attributes) { { start_at: (Time.now.utc - 1.day), end_at: (Time.now.utc + 1.day)} }

      context 'Return report succesfully with /me endpoint' do
        before { post "/api/v1/time-tracker-reports/me", params: valid_attributes }

        it 'returns status code 200 and 1 register' do
          expect(json.size).to eq(1)
          expect(response).to have_http_status(200)
        end
      end

      context 'Return empty report when doesnt exist registers in dates range sended, with /me endpoint' do
        let(:invalid_attributes) { { start_at: (Time.now.utc + 1.day), end_at: (Time.now.utc + 1.day) } }
        before { post "/api/v1/time-tracker-reports/me", params: invalid_attributes }

        it 'returns status code 200 and empty list' do
          expect(json.size).to eq(0)
          expect(response).to have_http_status(200)
        end
      end
    end
  end

  context 'with employee user' do
    let(:employee_test) { create(:user) }
    let(:employee_id) { employee_test.id }
    before { allow_any_instance_of(DecodeAuthCommand).to receive(:result).and_return(employee_test) }
    
    describe 'Request report by employee id list' do
      let!(:time_tracker_employee_1) { create(:time_tracker_employee, :in, user_id: employee_id)}
      let(:valid_attributes) { { start_at: (Time.now.utc - 1.day), end_at: (Time.now.utc + 1.day), user_ids: [employee_id] } }

      context 'Return report succesfully' do
        before { post "/api/v1/time-tracker-reports", params: valid_attributes }

        it 'returns status code 403 and two registers' do
          expect(response).to have_http_status(403)
        end
      end

      context 'Return empty report when employee id does not exist' do
        let(:invalid_attributes) { { start_at: (Time.now.utc - 1.day), end_at: (Time.now.utc + 1.day), user_ids: [employee_id + 10] } }
        before { post "/api/v1/time-tracker-reports", params: invalid_attributes }

        it 'returns status code 403 and empty list' do
          expect(response).to have_http_status(403)
        end
      end
    end

    describe 'Request report for employee view when you are admin' do
      let!(:time_tracker_employee_1) { create(:time_tracker_employee, :in, user_id: employee_id)}
      let(:valid_attributes) { { start_at: (Time.now.utc - 1.day), end_at: (Time.now.utc + 1.day)} }

      context 'Return report succesfully with /me endpoint' do
        before { post "/api/v1/time-tracker-reports/me", params: valid_attributes }

        it 'returns status code 200 and 1 register' do
          expect(json.size).to eq(1)
          expect(response).to have_http_status(200)
        end
      end

      context 'Return empty report when doesnt exist registers in dates range sended, with /me endpoint' do
        let(:invalid_attributes) { { start_at: (Time.now.utc + 1.day), end_at: (Time.now.utc + 1.day) } }
        before { post "/api/v1/time-tracker-reports/me", params: invalid_attributes }

        it 'returns status code 200 and empty list' do
          expect(json.size).to eq(0)
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end