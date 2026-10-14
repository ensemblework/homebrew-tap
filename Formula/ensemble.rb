class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.3.9"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.9/ensemble-cli-0.3.9-darwin-arm64.tar.gz"
      sha256 "6c13537313d4075de16defa9f75c12b24d07c095707ddde47d0f00f40f61890a"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.9/ensemble-cli-0.3.9-darwin-x64.tar.gz"
      sha256 "3e3e18de75db65885b955cc2d5129fdd742085555ecea74eb9bbbe62f8ee1dcd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.9/ensemble-cli-0.3.9-linux-arm64.tar.gz"
      sha256 "63d1d44f50a94c690694193d7928f094b757e183bc60586196f2994ad54dea8d"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.9/ensemble-cli-0.3.9-linux-x64.tar.gz"
      sha256 "e24e2c4a32b9c2bcfeed06dc7f76cf2c9b1359971dcb1e5a4b4b2dfa43682bff"
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
