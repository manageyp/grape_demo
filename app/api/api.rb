class API < Grape::API
  format :json

  include V1::Apis

end