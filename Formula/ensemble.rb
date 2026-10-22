class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.7"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.7/ensemble-cli-0.4.7-darwin-arm64.tar.gz"
      sha256 "b157b20bf009ee1da30f27acc9f1440717b2e73347df90b3c957c56cf5864796"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.7/ensemble-cli-0.4.7-darwin-x64.tar.gz"
      sha256 "ec72f7a6fc42bbfa22e9ad18aaf7f060bc8cb8983e349f5d9c4d3d07f28e0983"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.7/ensemble-cli-0.4.7-linux-arm64.tar.gz"
      sha256 "00062b8b08a9957ca624a4a92c073a8bc279bc417a2b9cc754cba9778fd53b64"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.7/ensemble-cli-0.4.7-linux-x64.tar.gz"
      sha256 "5d7849890d98dc2f10f7447a38f0444be67f3371beeb66f13044da42cc65d19f"
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
