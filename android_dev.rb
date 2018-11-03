
dep "android dev" do
  requires "android build"
  requires "intel-haxm" # Requires "Allow" in system preferences (will be prompted)
  requires "android-studio"
end

# If you only need to be able to build projects (e.g. CI)
dep "android build" do
  requires "stripysock:homebrew tap".with "homebrew/cask-versions"
  requires "java8"
  requires "ant.managed"
  requires "gradle.managed"
  requires "android-sdk"
  requires "android-ndk"
end

dep "ant.managed"
dep "gradle.managed"

def cask(name); dep name, :template => "stripysock:cask"; end # Avoid repitition below

cask "android-ndk"
cask "android-sdk"
cask "android-studio"
cask "intel-haxm"
cask "java8"
