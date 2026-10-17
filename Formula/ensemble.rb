class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.1"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.1/ensemble-cli-0.4.1-darwin-arm64.tar.gz"
      sha256 "2e4db8d092fe03878ef4eff9d21b2ff5597f0e0b5590adb52ada1693be9b45de"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.1/ensemble-cli-0.4.1-darwin-x64.tar.gz"
      sha256 "4e1946f80fe955612438037149155956f2dc890b500f822b16e1155dc62872c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.1/ensemble-cli-0.4.1-linux-arm64.tar.gz"
      sha256 "52b991ba822f8efcd82c94c8cad188af7342654599cb1465f81eba8982106807"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.1/ensemble-cli-0.4.1-linux-x64.tar.gz"
      sha256 "52844d88440b36638fb899900b6cfb6f56ab4321f9fde31f61822bca897884b2"
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
