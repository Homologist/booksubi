Airbrake.configure do |c|
  c.project_id = ENV.fetch("AIRBRAKE_PROJECT_ID")
  c.project_key = ENV.fetch("AIRBRAKE_PROJECT_KEY")
end

