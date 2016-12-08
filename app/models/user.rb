# frozen_string_literal: true
class User < ActiveRecord::Base
  extend FriendlyId

  has_many :authorizations
  has_many :directions, dependent: :destroy
  has_one :attachment, as: :attachable, dependent: :destroy
  has_many :system_logs, dependent: :destroy

  has_secure_password

  friendly_id :nick, use: [:finders]

  delegate :finished_directions, :new_directions, :in_progress_directions, to: :scope_object

  def scope_object
    @scope_object ||= UserScope.new(self)
  end
end
