class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.15"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.15/ensemble-cli-0.4.15-darwin-arm64.tar.gz"
      sha256 "3ff5ceda70d0866655340d2dd50b2f93dcae425a726a0bbd8ed3f820d13d55a8"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.15/ensemble-cli-0.4.15-darwin-x64.tar.gz"
      sha256 "3061e1752b576da66294b6962d39f2b964c9967f347b1e20cff9a5deeaeaf80b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.15/ensemble-cli-0.4.15-linux-arm64.tar.gz"
      sha256 "834c5f245e9819a82a5db6e2aab7001ea21eab61836bc6a3170d9445d56a0719"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.15/ensemble-cli-0.4.15-linux-x64.tar.gz"
      sha256 "51810e0a005b0b525ac91c4bec00dce72d5cd06d7d5b89ca4c1a163a11ac8027"
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
