YAML.load_file(Rails.root.join("config/environment.yml")).each { |k,v| ENV.store(k,v) }
