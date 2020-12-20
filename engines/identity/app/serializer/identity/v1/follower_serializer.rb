module Identity
  module V1
    class FollowerSerializer
      include FastJsonapi::ObjectSerializer

      attributes :id, :addressee_id

      attribute :name do |object|
        object.addressee.name
      end
    end
  end
end
