class AccountsController < ApplicationController

	def user_details
		get_account
		Xfers.set_api_key '2zsujd47H3-UmsxDL784beVnYbxCYCzL4psSbwZ_Ngk'
		Xfers.set_sg_sandbox
		@connect_user = Xfers::User.retrieve
		@available_bal = @connect_user[:available_balance]
		@resp = Xfers::User.transfer_info
		@bank_name = @resp[:bank_name_full]
		@account_no = @resp[:bank_account_no]
		@unique_id = @resp[:unique_id]
	end

	def charge
		Xfers.set_api_key '2zsujd47H3-UmsxDL784beVnYbxCYCzL4psSbwZ_Ngk'
		Xfers.set_sg_sandbox
		begin
		  puts 'Creating charge...'
		  params = {
		        'amount' => '9.99',
		        'currency' => 'SGD',
		        'notify_url' => 'http://localhost:3000/payment_notification',
		        'return_url' => 'http://localhost:3000/return',
		        'cancel_url' => 'http://localhost:3000/cancel',
		        'order_id' => 'AZ9912XX',
		        'description' => 'unused red dress',
		        'shipping' => '2.50',
		        'tax' => '0.0',
		        'redirect' => false,
		        'items' => [{'description' => 'Red dress Size M', 'price' => '9.99', 'quantity' => 1, 'name' => 'Red dress'}],
		        'meta_data' => {'firstname'=> 'Tianwei', 'lastname'=> 'Liu'}
		  }
		  resp = Xfers::Charge.create params
		  charge_id = resp[:id]
		  puts resp
		rescue Xfers::XfersError => e
		  puts e.to_s
		end
	end

	def payment_notification

	end

	def return

	end

	def cancel

	end

	def get_account
		@account = Account.last
	end

end
