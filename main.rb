#         x  y  metal?
$data = [ {:coord => [0,0, 0], :metal => true},
          {:coord => [1,1,1], :metal => false },
          {:coord => [3,4, 0], :metal => false},
          {:coord => [12,12, 12], :metal => true},
        ]


$distance_data = Array.new($data.size()) { Array.new($data.size(), 9999)}

# compute the distance between two planets
def distance(ii, jj)
  x_delta = $data[ii][:coord][0] - $data[jj][:coord][0]
  y_delta = $data[ii][:coord][1] - $data[jj][:coord][1]
  z_delta = $data[ii][:coord][2] - $data[jj][:coord][2]

  delta = Math.sqrt( Math.sqrt(x_delta ** 2 + y_delta **2) ** 2 + z_delta **2)
  puts "delta = #{delta}"
  delta
end

# compute only a triangle
for ii in 0 .. $data.size() - 1 
  for jj in ii + 1 .. $data.size() -1
    puts "ii = #{ii} ; jj = #{jj}"
    # don't compute for like/like
    if $data[ii][:metal] == $data[jj][:metal]
      next
    else 
      $distance_data[ii][jj] = distance(ii,jj)
    end
  end
end

def get_distance(aa, bb)
  ii = [aa,bb].min()
  jj = [aa,bb].max()
  $distance_data[ii][jj]
end

def get_closest(planet_number, metal)
  #puts "planet_number = #{planet_number}"
  $data.each_with_index.map { |data, index| { :index => index, :data => data} }.select {|hh| hh[:data][:metal] == metal}.map { |hh| { :index => hh[:index], :dist => get_distance(planet_number, hh[:index]) }}.min_by { |hh| hh[:dist]}[:index]
end

puts "food planets"
$data.each_with_index.map { |data, index| {:index => index, :data => data}}.select{ |hh| ! hh[:data][:metal]}.each do |hh|
  puts "* #{hh[:index]} - closest = #{get_closest(hh[:index], true)}"
end

puts "metal planets"
$data.each_with_index.map { |data, index| {:index => index, :data => data}}.select{ |hh| hh[:data][:metal]}.each do |hh|
  puts "* #{hh[:index]} - closest = #{get_closest(hh[:index], false)}"
end
