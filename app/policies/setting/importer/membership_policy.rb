module Setting
	module Importer
		class MembershipPolicy < ApplicationPolicy

			attr_reader :user, :record

		  def initialize(user, record)
		    @user = user
		    @record = record
		  end

		  def create?
		    user.admin? || user.developer?
		  end
		end
	end
end