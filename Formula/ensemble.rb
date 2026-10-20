class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.5"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.5/ensemble-cli-0.4.5-darwin-arm64.tar.gz"
      sha256 "5590bdf058a9243aa166e111a908e601b2da30aa77c6a6c631a71def4126ac04"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.5/ensemble-cli-0.4.5-darwin-x64.tar.gz"
      sha256 "aae851feee04b693bbb13e6d3a74e6083971a6412d150bd69612390ffe236fa4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.5/ensemble-cli-0.4.5-linux-arm64.tar.gz"
      sha256 "1b1c8eaaef1ba10417674449b615a22f5a75aa55cb5db8be7b6f2a7b44b33d8f"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.5/ensemble-cli-0.4.5-linux-x64.tar.gz"
      sha256 "41c13b39fb94768e33a6b2fe67237d5376e878efedbda6fbd65e99221b57f3ca"
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
