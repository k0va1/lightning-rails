class ApplicationSerializer
  include Alba::Resource

  root_key :data
  transform_keys :lower_camel
end
