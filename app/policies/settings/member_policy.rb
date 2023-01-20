module Settings
	class MemberPolicy < ApplicationPolicy

		def index?
      user.developer?
    end
  end
end