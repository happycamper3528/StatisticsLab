f = File.new('./Baby_Names__Beginning_2007.csv', 'r')
data_string = f.read
f.close

# Convert string of data into an array of data
data_points = data_string.split("\n")

# Go through each data point (iterator... EACH)and fetch the needed value by splitting it into an array of data values
# e.g. data_point.split(',')
sum = 0
data_points.each do |data_point|
  data_point_values = data_point.split(',')
  data_value = data_point_values[4]
  data_value = data_value.to_f
  sum = sum + data_value
end

# divide by number of points to find mean
number_of_points = data_points.count
mean = sum / number_of_points

# calculate standard deviation
sum = 0
data_points.each do |data_point|
  data_point_values = data_point.split(',')
  data_value = data_point_values[4]
  data_value = data_value.to_f
  sum = sum + (data_value - mean)**2
end

standard_deviation1 = sum / number_of_points
standard_deviation_final = standard_deviation1**0.5

# calculate z scores
new_data_points = []
data_points.each do |data_point|
  data_point_values = data_point.split(',')
  data_value = data_point_values[4]
  data_value = data_value.to_f
  zscore = (data_value - mean) / standard_deviation_final
  new_data_points.push(data_point + ',' + zscore.to_s)
end

# put z scores in csv file with data
f = File.new('./data_with_zscores.csv', 'r')
data_string2 = f.read
f.close

data_points2 = data_string2.split(',')

f = File.new('./data_with_zscores.csv', 'w')
all_data = data_points2 + new_data_points
f.write all_data
f.close
new_data = all_data.join(',')

# not finished yet