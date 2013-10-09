if Rails.env.development?
	APPSETTINGS = YAML.load(File.read("#{Rails.root.join("config/application.yml")}"))
end