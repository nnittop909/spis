module Settings
	class ResolutionPolicy < ApplicationPolicy

		def index?
      user.developer?
    end
  end
end