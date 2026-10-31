class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.6.2"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.2/ensemble-cli-0.6.2-darwin-arm64.tar.gz"
      sha256 "ce945bb244c4b5aa57c9ac073dbb776acb3ee37e328c9e80fd0ca8fd649e1890"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.2/ensemble-cli-0.6.2-darwin-x64.tar.gz"
      sha256 "a20bc3aad00db23c24396a25d81592d4ab749641438356c338c9692f30898813"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.2/ensemble-cli-0.6.2-linux-arm64.tar.gz"
      sha256 "3791eff052c0edab804c759a1e980e0d6fc6fb80247d4979600b13d00b96eceb"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.2/ensemble-cli-0.6.2-linux-x64.tar.gz"
      sha256 "d68936d31bdc971a8b39c63742f461393c6b6387d43894d7aa9ebec23a31a5c1"
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
