class OrderSerializer < ActiveModel::Serializer
  attributes :id , :name, :shipping_address ,:created_at

  belongs_to :user, serializer: UserSerializer

  has_many :order_items, serializer: OrderitemsSerializer
end