dep "stripysock dotfiles" do
  requires "rcm.managed"
  requires "repository".with  :path => "~/.dotfiles-stripysock",
                              :url => "https://github.com/stripysock/dotfiles.git",
                              :branch => "master"

  met? {
    # Require that the dotfiles repository is checked out _and_ installed (by checking just one dotfile)
    "~/.dotfiles-stripysock".p.exists? && (zshrc = "~/.zshrc".p).symlink? && zshrc.readlink == "~/.dotfiles-stripysock/zshrc".p
  }

  after {
    shell "rcup -d ~/.dotfiles-stripysock -x README.md -x LICENSE"
  }
end

dep "dotfiles", :template => "task" do
  requires "stripysock dotfiles"

  run {
    shell "rcup"
  }
end
