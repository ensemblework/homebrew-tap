class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.6.9"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.9/ensemble-cli-0.6.9-darwin-arm64.tar.gz"
      sha256 "46107a6493ee498ad52d1db8fa93e43ed156081bb7081d5827ef5cf0d0d37b8a"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.9/ensemble-cli-0.6.9-darwin-x64.tar.gz"
      sha256 "d27fb53009b894ad93636a447b68ca5eff54fa68167433c39b1d402ad9a38a83"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.9/ensemble-cli-0.6.9-linux-arm64.tar.gz"
      sha256 "57d7bee3d3310a98575d288531d425238c6af5436b2b2577e66c094df7dc4046"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.9/ensemble-cli-0.6.9-linux-x64.tar.gz"
      sha256 "0264e2303df0347091c9239f0dcdf14b2613426f3d0070731212c5a9ca052344"
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
