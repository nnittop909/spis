module Setting
	module Merger
		class CommitteePolicy < ApplicationPolicy

			attr_reader :user, :record

		  def initialize(user, record)
		    @user = user
		    @record = record
		  end

		  def new?
		    user.admin? || user.developer?
		  end

		  def create?
		  	new?
		  end
		end
	end
end