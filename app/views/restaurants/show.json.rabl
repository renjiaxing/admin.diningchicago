object @restaurant
attribute :id, :permalink, :name, :state, :closed, :description,
  :opentable_rid, :telephone, :website, :other_neighbors, :created_at

node :cuisines do |r|
  r.cuisines.map(&:name).join(', ')
end

node :amenities do |r|
  r.amenities.map(&:name).join(', ')
end

node :logo do |r|
  r.logo.url(:thumb)
end

child :address do
  extends 'addresses/show'
end

child :pictures do
  extends 'pictures/show'
end

