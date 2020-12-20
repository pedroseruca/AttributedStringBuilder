Pod::Spec.new do |spec|

  spec.name         = "AttributedStringBuilder"
  spec.version      = "0.0.2"
  spec.summary      = "A type safe implementation for AttributedStrings"
  spec.description  = "A builder for AttributedString that ensures a safe use of any attribute"
  spec.homepage     = "https://github.com/pedroseruca/AttributedStringBuilder"
  spec.license      = { :type => "MIT", :file => "https://github.com/pedroseruca/AttributedStringBuilder/blob/main/LICENSE" }

  spec.author       = { "Pedro Seruca" => "pedroseruca+github@gmail.com" }
  spec.social_media_url   = "https://www.linkedin.com/in/pedroseruca/"

  spec.platform     = :ios, "12.0"
  spec.swift_version = "5.0"

  spec.source       = { :git => "https://github.com/pedroseruca/AttributedStringBuilder.git", :tag => "0.0.2" }

  spec.source_files  = "AttributedStringBuilder"
end
