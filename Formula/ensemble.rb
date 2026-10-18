class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.2"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.2/ensemble-cli-0.4.2-darwin-arm64.tar.gz"
      sha256 "b9a16d47bc6e801543774c9f735dffc7d64c3eff819a92089de0b04f0d8659d0"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.2/ensemble-cli-0.4.2-darwin-x64.tar.gz"
      sha256 "eab5de396ce96e7615c954f4bc822feea2bd1959eaa499a57bc07ac0d77a77bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.2/ensemble-cli-0.4.2-linux-arm64.tar.gz"
      sha256 "b15646ed6fa4b587194e5abd691698194a08d64477f57b2e7d4c075af00d4519"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.2/ensemble-cli-0.4.2-linux-x64.tar.gz"
      sha256 "b5dfc2950ea16b2475f4bb3add6ebb9d8063e923fd4a864edeab3ef6c959abef"
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
