if ENV["BACKEND_SERVICE_ENDPOINT"].blank?
  raise "Must configure app with BACKEND_SERVICE_ENDPOINT environment variable"
end
