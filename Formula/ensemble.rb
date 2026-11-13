class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.16"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.16/ensemble-cli-0.7.16-darwin-arm64.tar.gz"
      sha256 "53b6655e7ce5191ba9ae31ec32672a933eead325b8315c91c7ce378fa3bbb3dd"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.16/ensemble-cli-0.7.16-darwin-x64.tar.gz"
      sha256 "21136f0b899eed78fa371f585502eca14f5180a57b0bb7f5b04402afa1236ae1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.16/ensemble-cli-0.7.16-linux-arm64.tar.gz"
      sha256 "5f9fc2fab2649fc7ec4ba47db2e9bcf98e33e814866989bbd2e3a95663e88fb4"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.16/ensemble-cli-0.7.16-linux-x64.tar.gz"
      sha256 "fbf7e7655dedd727828731f56a9a13424fe1b56708566bdddbbe0be2d11b3acc"
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
