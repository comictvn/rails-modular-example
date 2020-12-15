module Identity
  module V1
    class MeSerializer
      include FastJsonapi::ObjectSerializer

      attributes :id, :name, :email
    end
  end
end
