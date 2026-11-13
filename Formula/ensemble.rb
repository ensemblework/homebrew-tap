class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.14"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.14/ensemble-cli-0.7.14-darwin-arm64.tar.gz"
      sha256 "994fedc6b5f2e9b9535194f084b97f277b225378a9e4c87efd50b26fa0290ff6"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.14/ensemble-cli-0.7.14-darwin-x64.tar.gz"
      sha256 "5ebd471ae15975c81fede4df645f5ddf79778d52a912ab7c6f72c78c2c6b57e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.14/ensemble-cli-0.7.14-linux-arm64.tar.gz"
      sha256 "36acb3aee45d5ca6d332f437ae2cd2f234a4a125a24b51a94676bfe7b6e9a710"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.14/ensemble-cli-0.7.14-linux-x64.tar.gz"
      sha256 "f8487a224630b7e582b3be7e9be805e592bcba9dca7de61a0070f720eb5ba52d"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/ensemble"
  end

  service do
    run [opt_bin/"ensemble", "runner", "start", "--foreground"]
    keep_alive true
    log_path var/"log/ensemble-runner.log"
    error_log_path var/"log/ensemble-runner.err.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ensemble --version")
  end
end
