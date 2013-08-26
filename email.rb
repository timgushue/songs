def send_message
	Pony.mail(
		:from => params[:name] + "<" + params[:email] + ">",
		:to => 'ito.prime@gmail.com',
		:subject => params[:name],
		:body => params[:message],
		:port => '587',
		:via_options => {
			:address							=> 'smtp.gmail.com',
			:port									=> '587',
			:enable_starttls_auto =>  true,
			:user_name						=>	'ito.prime',
			:password							=>	'xxxxxx',
			:authentication				=>	:plain,
			:domain								=>	'localhost.localdomain'
		})
end