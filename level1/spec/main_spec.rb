require "./main"

describe '#compute_rent_days' do
  context 'with a rent for a day' do
    let(:rent) { 
      {
        "id": 1,
        "car_id": 1,
        "start_date": "2017-12-8",
        "end_date": "2017-12-8",
        "distance": 100
      } 
    }
    it 'should return 1' do
      expect(compute_rent_days(rent)).to eq(1)
    end
  end

  context 'with a rent for two days' do
    let(:rent) { 
      {
        "id": 1,
        "car_id": 1,
        "start_date": "2017-12-8",
        "end_date": "2017-12-9",
        "distance": 100
      } 
    }
    it 'should return 2' do
      expect(compute_rent_days(rent)).to eq(2)
    end
  end

  context 'with a rent for three days' do
    let(:rent) { 
      {
        "id": 1,
        "car_id": 1,
        "start_date": "2017-12-8",
        "end_date": "2017-12-10",
        "distance": 100
      } 
    }
    it 'should return 3' do
      expect(compute_rent_days(rent)).to eq(3)
    end
  end

  context 'with a rent for ten days' do
    let(:rent) { 
      {
        "id": 1,
        "car_id": 1,
        "start_date": "2017-12-8",
        "end_date": "2017-12-17",
        "distance": 100
      } 
    }
    it 'should return 10' do
      expect(compute_rent_days(rent)).to eq(10)
    end
  end

  context 'with a start date greater than the end date' do
    let(:rent) { 
      {
        "id": 1,
        "car_id": 1,
        "start_date": "2017-12-8",
        "end_date": "2017-12-7",
        "distance": 100
      } 
    }
    it 'should return -1' do
      expect(compute_rent_days(rent)).to eq(-1)
    end
  end
end