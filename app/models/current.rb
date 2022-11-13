class Current < ActiveSupport::CurrentAttributes
	attribute :account, :user

	resets { Time.zone = nil }

	class MissingCurrentAccount < StandardError; end

	def account_or_raise!
		raise Current::MissingCurrentAccount, "You must set an account with Current.account=" unless account

		account
	end

	def user=(user)
		super
		self.account = user.account
		Time.zone = user.time_zone
	end
end



