class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.7"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.7/ensemble-cli-0.7.7-darwin-arm64.tar.gz"
      sha256 "1062e84dbb68ef959dd9fb1294cb1c8a428ccbd54a534a15441f814ed57748f2"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.7/ensemble-cli-0.7.7-darwin-x64.tar.gz"
      sha256 "7695d5e51b71665ab02d1b1f61843ffad52de3e9484c44608437d51e03a62fc6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.7/ensemble-cli-0.7.7-linux-arm64.tar.gz"
      sha256 "8f3f9b8996515985300f9bca7d73eb0fbd9f503d4c218f413fd98304f8c6b983"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.7/ensemble-cli-0.7.7-linux-x64.tar.gz"
      sha256 "1800710eb350a0b60e3b90acc421b6990011a1845f2e2b6e0db2c7d11e088c22"
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
