class CartSerializer < ActiveModel::Serializer
  attributes :id , :user_id

  belongs_to :user, serializer: UserSerializer

  has_many :cart_items
  has_many :dishes
end
