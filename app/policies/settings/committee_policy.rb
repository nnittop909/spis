module Settings
	class CommitteePolicy < ApplicationPolicy

		def index?
      user.developer?
    end
  end
end