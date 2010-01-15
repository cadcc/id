namespace :admin do
  namespace :user do
    desc "Creates a new User"
    task :create => :environment do
      if ENV['user'].blank? or ENV['email'].blank?
        puts "USAGE: rake admin:user:create user=USERNAME email=EMAIL"
        exit(1)
      end
      puts "creating user: #{ENV['user']} with email: #{ENV['email']}"

      a = Account.new( :login => ENV['user'], :email => ENV['email'])

      # create random password
      a.password = a.password_confirmation = Array.new(4) { rand(256) }.pack('C*').unpack('H*').first

      if a.save
        puts "Account created sucsessfully, password was sent to #{ENV['email']}"
      else
        puts "An error ocurred!"
        puts a.errors
      end
    end
  end
end
