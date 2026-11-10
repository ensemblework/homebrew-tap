class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.6"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.6/ensemble-cli-0.7.6-darwin-arm64.tar.gz"
      sha256 "df6f686e737835c697fc3cda86979034564d6e9585b6139205b11441c6f6c4aa"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.6/ensemble-cli-0.7.6-darwin-x64.tar.gz"
      sha256 "ec6fca9a24c4fd7cd67b5e222a5496e72afb7dd3c32999f40e99fbfa01a0d81f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.6/ensemble-cli-0.7.6-linux-arm64.tar.gz"
      sha256 "a7ca070600bcc2e8103addaee2244866dd24828d20b2a18f29c7356d423884f4"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.6/ensemble-cli-0.7.6-linux-x64.tar.gz"
      sha256 "4749c7031b97e84b24c3f00cf5180fa21fb6ded7d0a156a9fe33c9ac0932c606"
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
