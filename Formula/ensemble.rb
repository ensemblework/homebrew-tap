class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.6.4"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.4/ensemble-cli-0.6.4-darwin-arm64.tar.gz"
      sha256 "2a4053ebed4fa9ea257bc91829436f004ac74dc2c879cfc499a2e9fe242248bf"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.4/ensemble-cli-0.6.4-darwin-x64.tar.gz"
      sha256 "d5b14846028df280ff1cc7c355471c21e11378e469d8b17a6f713e5f8d62621b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.4/ensemble-cli-0.6.4-linux-arm64.tar.gz"
      sha256 "11e355fbc4b0d36d688737d4ca9b8b2732aa32b4fe8773e85cee0218ca3d4bfe"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.4/ensemble-cli-0.6.4-linux-x64.tar.gz"
      sha256 "4c3708ff8940c2083f2aea9b559900d19b4861e0951995bc986b17bc51c4091a"
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
