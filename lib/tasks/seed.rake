namespace :seed do
  desc "TODO"
  task :make_kids, [:count] => [:environment] do |t, args|
    args[:count].to_i.times do |t|
      Kid.create(
        net_id: 'fz75',
        fname: "Feifan #{ t }",
        lname: 'Zhou',
        phone: '123-456-7890',
        address: '123 College Ave',
        image: "data:image/png;base64,#{ SecureRandom.base64(302598) }"
      )
    end
  end

end
