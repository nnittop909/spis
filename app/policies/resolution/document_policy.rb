module Resolution
	class DocumentPolicy < ApplicationPolicy

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

	  def edit?
	  	user.admin? || user.developer?
	  end

	  def update?
	  	edit?
	  end

	  def destroy?
	  	user.admin? || user.developer?
	  end
	end
end