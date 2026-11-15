class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.8.2"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.2/ensemble-cli-0.8.2-darwin-arm64.tar.gz"
      sha256 "82d09b1a74a57477e72e56dfc0cc03e669c4f65fd389ed122a594a3c678649c8"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.2/ensemble-cli-0.8.2-darwin-x64.tar.gz"
      sha256 "b511b38c35c42e910aebba3d50948742616f83412090ffe10c85f910156740c2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.2/ensemble-cli-0.8.2-linux-arm64.tar.gz"
      sha256 "7bba3919aa2aa960c7a8880ea660e281783efb3c409589993ea40d0acc38b831"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.2/ensemble-cli-0.8.2-linux-x64.tar.gz"
      sha256 "6bde217216132e7a85a77665c6a80588ac0a572f1a31b6e10e78d52ba74e5c76"
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
