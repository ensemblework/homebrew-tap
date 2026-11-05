class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.6.8"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.8/ensemble-cli-0.6.8-darwin-arm64.tar.gz"
      sha256 "200fb8e79ab848159982105b7fe229f5bb452307eabec70a920073578ab80c05"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.8/ensemble-cli-0.6.8-darwin-x64.tar.gz"
      sha256 "3b25e0fa507669f6769388eed0bf8ff0502a0d089683e82d39d0e613f69788df"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.8/ensemble-cli-0.6.8-linux-arm64.tar.gz"
      sha256 "fa85bd86f68ff9f880ef985feffe6033adee3eabdffc15290618d2e7059ea83f"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.8/ensemble-cli-0.6.8-linux-x64.tar.gz"
      sha256 "12f09cd49913567f0b17306e67c54d2f659e72b8d72f3ffc37cace8dd7cb82f2"
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
