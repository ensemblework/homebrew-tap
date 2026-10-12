class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.2/ensemble-cli-0.3.2-darwin-arm64.tar.gz"
      sha256 "ecf7f317e84723328ea0317bba864017ce320c3ccac2239a6e80e731c554ef86"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.2/ensemble-cli-0.3.2-darwin-x64.tar.gz"
      sha256 "8c0304e882bf72a262b3ce6545c7db1c1f762f65e1c95722f9bdeb7e6c4021ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.2/ensemble-cli-0.3.2-linux-arm64.tar.gz"
      sha256 "2968085185e16a70511ad01f641d47855c31199ac9b40c4253a42ce5b7704d2a"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.2/ensemble-cli-0.3.2-linux-x64.tar.gz"
      sha256 "3c6c520e33b1d6887f69b60a0b0dcc9cba68d0e70d88890583534020e4f7d37a"
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
