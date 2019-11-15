# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :current_password

  rolify

  validates :username, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments

  has_many :reactions

  after_create :assign_default_role

  def admin?
    has_role?(:admin)
  end

  def client?
    has_role?(:client)
  end

  def visitor?
    has_role?(:visitor)
  end

  def assign_default_role
    add_role(:client) if roles.blank?
  end

  scope :admin, -> { joins(:roles).where(roles: { name: 'admin' }) }
  scope :client, -> { joins(:roles).where(roles: { name: 'client' }) }
end
