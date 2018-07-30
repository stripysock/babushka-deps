# A bootstrapping dep for first-time installs. This prepares the shell
# environment for the rest of the deps to run.
dep "workstation bootstrapped" do
  # Install the version managers
  requires "stripysock:rbenv", "stripysock:ruby-build"
  requires "nodenv"

  # Bring in the Stripy Sock dotfiles, which includes zsh config to initialize the
  # version managers
  requires "dotfiles"

  # And set the shell to zsh, so this config can take effect
  requires "shell".with :shell_name => "zsh"

  after {
    message = word_wrap("The environment is bootstrapped. If this is your first installation, open a new shell and run \"babushka stripysock:workstation\" to continue.")

    log "*"*80,        :as => :warning
    log message,       :as => :warning
    log "*"*79 + "!",  :as => :warning
  }

  # Thanks, ActionView
  def word_wrap(text, options = {})
    line_width = options.fetch(:line_width, 80)

    text.split("\n").collect! do |line|
      line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
    end * "\n"
  end
end

dep "workstation" do
  requires "workstation bootstrapped"
  requires "homebrew services"

  # Ruby
  requires "ruby 2.4.0"
  requires "global ruby version".with "2.4.0"
end

dep "workstation webdev" do

  requires "workstation"

  # General homebrew packages
  requires "docker.cask"
  requires "imagemagick.managed"
  requires "watch.managed"
  requires "heroku.managed"
  requires "yarn"

  # Node
  requires "node 6.10.0"
  requires "global node version".with "6.10.0"

end

dep "workstation iosdev" do
  requires "workstation"
  # TODO
end

dep "workstation androiddev" do
  requires "workstation"
  # TODO
end