namespace :cron do

  desc '定期取得'
  task get_current_faces: :environment  do
    User.get_current_faces
  end
end
