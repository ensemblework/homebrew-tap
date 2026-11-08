class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.1"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.1/ensemble-cli-0.7.1-darwin-arm64.tar.gz"
      sha256 "8db25c574ef1373dec7c424b964bb2d30f878416c963ae93d9ee79e3df929367"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.1/ensemble-cli-0.7.1-darwin-x64.tar.gz"
      sha256 "ac5106a686b6ee6fe0d2c2cb83f3487a8cfac954d9444b0a40a0bffee5bcaa19"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.1/ensemble-cli-0.7.1-linux-arm64.tar.gz"
      sha256 "5244ee06b022dd931f184e5c05cb706eefc10ad93950390b73d2fef2a5636cde"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.1/ensemble-cli-0.7.1-linux-x64.tar.gz"
      sha256 "c9fb8f540317a849a5068d0f469289a6ba7b588d1fbd303135167ef933c67834"
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
