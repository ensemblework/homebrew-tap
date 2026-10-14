class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.3.6"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.6/ensemble-cli-0.3.6-darwin-arm64.tar.gz"
      sha256 "baabe5fb0012807796fff439bdeec6845515d6653f692c26156201fde0447952"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.6/ensemble-cli-0.3.6-darwin-x64.tar.gz"
      sha256 "e570a7492e5a6a5ce2cbe42d9077ae529b7bc40e98b98bbd257dccc99866b954"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.6/ensemble-cli-0.3.6-linux-arm64.tar.gz"
      sha256 "2bc3c7abdfd8936c19fe2898a8ed7125c9ac2bc1fa0600385a9178ef9435431d"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.6/ensemble-cli-0.3.6-linux-x64.tar.gz"
      sha256 "c32a52b12ab720ec31b07e5d208e7590589fd93db653f37d3783f56399092225"
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
