def read_data
  input_data_file_path = './data/input.json'
  input_file = File.read(input_data_file_path)
  JSON.parse(input_file)
end