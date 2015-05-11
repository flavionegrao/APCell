Pod::Spec.new do |s|
  s.name             = "APCell"
  s.version          = "0.1"
  s.summary          = "Subclasses of UITableViewCells"
  s.homepage         = "https://github.com/flavionegrao/APCell"
  s.license          = 'MIT'
  s.author           = { "Flavio Negrao Torres" => "flavio@apetis.com" }

  s.source           = { :git => "https://github.com/flavionegrao/APCell.git", :tag => "#{s.version}" }
  s.source_files     = "APCell/**"

  s.ios.deployment_target = '7.1'
  s.requires_arc = true

end

