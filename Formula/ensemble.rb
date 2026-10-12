class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.1/ensemble-cli-0.3.1-darwin-arm64.tar.gz"
      sha256 "11585f1ad02439fd6a83f01a15dac58b903cbf7f681fd56c2edfdf9299005c57"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.1/ensemble-cli-0.3.1-darwin-x64.tar.gz"
      sha256 "8708ef61cf48858b8bd0521d9196600ef47a4a4cc13d1285b73840bdc56a41dc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.1/ensemble-cli-0.3.1-linux-arm64.tar.gz"
      sha256 "b029be3fff8fd04da3f0265f11ebbe779579f01fdd9eb47e44efaacb4174dc3c"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.1/ensemble-cli-0.3.1-linux-x64.tar.gz"
      sha256 "b2b29f2c0cd656b0e146de209cfc06f9190c0fc9b45641c14c68d600a3fb1e31"
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
