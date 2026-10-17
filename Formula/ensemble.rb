class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.0"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.0/ensemble-cli-0.4.0-darwin-arm64.tar.gz"
      sha256 "0d0a5469c5a90e37f582e6e1deae996a658e8f349a8d4642fdbd555ddbb27d69"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.0/ensemble-cli-0.4.0-darwin-x64.tar.gz"
      sha256 "cc6b4a6720230cb40e24a8b3d905e03ae9e5cbd056762908bb66056c38f5376f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.0/ensemble-cli-0.4.0-linux-arm64.tar.gz"
      sha256 "adf09886b81be7f4de6501bda92cb2eb8354124fb5220ba2cb2a2b181e750d39"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.0/ensemble-cli-0.4.0-linux-x64.tar.gz"
      sha256 "7dc2da42c199bba2cd8864a9c9b1587b075092d3f82bfbabb6c9083f5af8b53b"
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
