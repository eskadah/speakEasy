every :day, :at => '1:01am' do
  rake 'custom_job:work', :environment => 'development'
end
