
namespace :custom_job do
  desc 'Send Notifications'
  task :work => :environment do
    exec 'bin/delayed_job start --exit-on-complete'
  end
end
