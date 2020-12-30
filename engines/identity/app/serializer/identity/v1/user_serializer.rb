module Identity
  module V1
    class UserSerializer
      include FastJsonapi::ObjectSerializer

      attributes :id, :name, :email
    end
  end
end
