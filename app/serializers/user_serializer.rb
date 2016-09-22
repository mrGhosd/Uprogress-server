# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  root 'user'
  attributes :id, :nick

  has_many :directions, serializer: DirectionsSerializer
end