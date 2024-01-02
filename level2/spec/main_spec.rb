require './main'
require '../lib/rent_days'

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
      expect(compute_rent_days(rent)).to eq(1)
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
      expect(compute_rent_days(rent)).to eq(2)
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
      expect(compute_rent_days(rent)).to eq(3)
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
      expect(compute_rent_days(rent)).to eq(10)
    end
  end
end

describe '#days_rent_price' do
  context ' with a rent for a day and a price of 1000 per day' do
    let(:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-8",
        "distance"=> 100
      } 
    }
    let(:price_per_day) { 1000 }
    it ' should renturn 1000' do
      expect(days_rent_price(rent:, price_per_day:)).to eq(1000)
    end
  end

  context ' with a rent for three days and a price of 750 per day' do
    let(:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-10",
        "distance"=> 100
      } 
    }
    let(:price_per_day) { 750 }
    it ' should renturn 2100' do
      expect(days_rent_price(rent:, price_per_day:)).to eq(2100)
    end
  end

  context ' with a rent for ten days and a price of 1000 per day' do
    let(:rent) { 
      {
        "id"=> 1,
        "car_id"=> 1,
        "start_date"=> "2017-12-8",
        "end_date"=> "2017-12-17",
        "distance"=> 100
      } 
    }
    let(:price_per_day) { 1000 }
    it ' should renturn 7900' do
      expect(days_rent_price(rent:, price_per_day:)).to eq(7900)
    end
  end
end

describe '#distance_rent_price' do
  context ' with 100 km and a price of 10 per km' do
    let(:distance) { 100 }
    let(:price_per_km) { 10 }
    it ' should return 1000' do
      expect(distance_rent_price(distance:, price_per_km:)).to eq(1000)
    end
  end

  context ' with 200 km and a price of 8 per km' do
    let(:distance) { 200 }
    let(:price_per_km) { 8 }
    it ' should return 1600' do
      expect(distance_rent_price(distance:, price_per_km:)).to eq(1600)
    end
  end

  context ' with 1000 km and a price of 12 per km' do
    let(:distance) { 1000 }
    let(:price_per_km) { 12 }
    it ' should return 12000' do
      expect(distance_rent_price(distance:, price_per_km:)).to eq(12000)
    end
  end
end