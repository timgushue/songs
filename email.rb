configure :development do 
	set :email_address	=> 'smtp.gmail.com',
			:email_user_name => 'ito.prime',
			:email_password	=> 'xxxxxx',
			:email_domain	=>	'localhost.localdomain'
end

configure :production do 
	set :email_address	=> 'smtp.sendgrid.net',
			:email_user_name => ENV['SENDGRID_USERNAME'],
			:email_password	=> ENV['SENDGRID_PASWORD'],
			:email_domain	=>	'heroku.com'
end

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