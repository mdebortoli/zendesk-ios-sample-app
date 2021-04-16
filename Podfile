platform :ios, '13.0'

project 'Zendesk Demo/Zendesk Demo.xcodeproj'

target 'Zendesk Demo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Zendesk Demo
  pod 'ZendeskChatSDK'  
  pod 'ZendeskSupportSDK'
  pod 'ZendeskAnswerBotSDK'
  pod 'ZendeskTalkSDK'

end

post_install do |installer|
  # Find bitcode_strip
  bitcode_strip_path = `xcrun -sdk iphoneos --find bitcode_strip`.chop!

  # Find path to TwilioVoice dependency
  path = Dir.pwd
  framework_path = "'#{path}/Pods/TwilioVoice/Build/iOS/TwilioVoice.framework/TwilioVoice'"

  # Strip Bitcode sections from the framework
  strip_command = "#{bitcode_strip_path} #{framework_path} -m -o #{framework_path}" 
  puts "About to strip: #{strip_command}"
  system(strip_command)
end
