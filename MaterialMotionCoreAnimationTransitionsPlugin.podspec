Pod::Spec.new do |s|
  s.name         = "MaterialMotionCoreAnimationTransitionsPlugin"
  s.summary      = "Core Animation Transitions Material Motion Plugin"
  s.version      = "1.0.0"
  s.authors      = "The Material Motion Authors"
  s.license      = "Apache 2.0"
  s.homepage     = "https://github.com/material-motion/coreanimation-transitions-plugin-swift"
  s.source       = { :git => "https://github.com/material-motion/coreanimation-transitions-plugin-swift.git", :tag => "v" + s.version.to_s }
  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source_files = "src/*.{swift}", "src/private/*.{swift}"
end
