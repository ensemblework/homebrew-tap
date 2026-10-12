class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.3.4"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.4/ensemble-cli-0.3.4-darwin-arm64.tar.gz"
      sha256 "ae0d46dbf0c2eee1bbd7df7f31245e0e39bfd6b30b378cda7f7b31431da652ea"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.4/ensemble-cli-0.3.4-darwin-x64.tar.gz"
      sha256 "b50b40984470584888643b64778c8fb344600f3a4db2e662adf6ff69b2f0570b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.4/ensemble-cli-0.3.4-linux-arm64.tar.gz"
      sha256 "299ee9dd1a166388fd3a9195914883d9928e417ad1d88c6f82d3ae1099cab235"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.4/ensemble-cli-0.3.4-linux-x64.tar.gz"
      sha256 "5fc9f3ba7e4f00b0bf69e50dcacb168a2d96bf9cfcabbec171f1c38c3581541f"
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
