class OrderSerializer < ActiveModel::Serializer
  attributes :id , :name, :shipping_address ,:created_at

  has_many :order_items, serializer: OrderitemsSerializer
end