module Settings
	class OrdinancePolicy < ApplicationPolicy

		def index?
      user.developer?
    end
  end
end