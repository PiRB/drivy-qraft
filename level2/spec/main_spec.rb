require "./main"

describe '#compute_rent_days' do
  context 'with a rent for a day' do
    let(:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-8",
        "distance"=> 100
      } 
    }
    it 'should return 1' do
      expect(compute_rent_days(rent: rent)).to eq(1)
    end
  end

  context 'with a rent for two days' do
    let(:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-9",
        "distance"=> 100
      } 
    }
    it 'should return 2' do
      expect(compute_rent_days(rent: rent)).to eq(2)
    end
  end

  context 'with a rent for three days' do
    let(:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-10",
        "distance"=> 100
      } 
    }
    it 'should return 3' do
      expect(compute_rent_days(rent: rent)).to eq(3)
    end
  end

  context 'with a rent for ten days' do
    let(:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-17",
        "distance"=> 100
      } 
    }
    it 'should return 10' do
      expect(compute_rent_days(rent: rent)).to eq(10)
    end
  end

  context 'with a start date greater than the end date' do
    let(:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-7",
        "distance"=> 100
      } 
    }
    it 'should return -1' do
      expect(compute_rent_days(rent: rent)).to eq(-1)
    end
  end
end

describe '#compute_rent_pricing' do
  context ' with a rent for a day' do
    let (:car) {
      { "id"=> 1, "price_per_day"=> 1000, "price_per_km"=> 10 }
    }
    let (:rent_days) { 1 }
    let (:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-8",
        "distance"=> 10
      }
    }

    it 'should return 1100' do
      expect(compute_rent_pricing(car:, rent:)).to eq(1100)
    end
  end

  context ' with a rent for 3 days' do
    let (:car) {
      { "id"=> 1, "price_per_day"=> 1000, "price_per_km"=> 10 }
    }
    let (:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-10",
        "distance"=> 10
      }
    }

    it 'should return 2900' do
      expect(compute_rent_pricing(car:, rent:)).to eq(2900)
    end
  end

  context ' with a rent for 10 days' do
    let (:car) {
      { "id"=> 1, "price_per_day"=> 1000, "price_per_km"=> 10 }
    }
    let (:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-17",
        "distance"=> 10
      }
    }

    it 'should return 8000' do
      expect(compute_rent_pricing(car:, rent:)).to eq(8000)
    end
  end

  context ' with a rent for 20 days' do
    let (:car) {
      { "id"=> 1, "price_per_day"=> 1000, "price_per_km"=> 10 }
    }
    let (:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-27",
        "distance"=> 10
      }
    }

    it 'should return 13000' do
      expect(compute_rent_pricing(car:, rent:)).to eq(13000)
    end
  end
end