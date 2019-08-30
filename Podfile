# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

def pod_lib
  pod 'Alamofire'
  pod 'Swinject'
  pod 'SwinjectStoryboard'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'SwiftLint'
end

target 'DependencyMVVM' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DependencyMVVM
  pod_lib

  target 'DependencyMVVMTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
