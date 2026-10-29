class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.23"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.23/ensemble-cli-0.4.23-darwin-arm64.tar.gz"
      sha256 "c2e2c30b4439b033aad394831ddb4583a35f404697e9e50fdd6f28f0c09680a9"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.23/ensemble-cli-0.4.23-darwin-x64.tar.gz"
      sha256 "33adc682aa1212e331c0f29a2552d7c8f5fd3b119202ec81a9991bf564f066b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.23/ensemble-cli-0.4.23-linux-arm64.tar.gz"
      sha256 "94441c6c64b379512b6e7e07f7e6eec5e590faa1944722c484eb9c31eb10289d"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.23/ensemble-cli-0.4.23-linux-x64.tar.gz"
      sha256 "35bfb2588379686bd8f4b3281f896243cefc218c31a140df61d1f43fd0d03604"
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
