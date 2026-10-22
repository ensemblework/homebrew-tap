class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.8"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.8/ensemble-cli-0.4.8-darwin-arm64.tar.gz"
      sha256 "f0e3b4e5eb7ce32449544d9d01d5d8e4eddc173cc1ee50dda895d12dce1f0575"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.8/ensemble-cli-0.4.8-darwin-x64.tar.gz"
      sha256 "ab8e3004621c030ea579b90ebd7413f3c96c954eef63f28c8fe8e3f70e7db643"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.8/ensemble-cli-0.4.8-linux-arm64.tar.gz"
      sha256 "72273ef86b64f55b1075746f8b86a55346250f30149aa46846cf2fa028d6dcf2"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.8/ensemble-cli-0.4.8-linux-x64.tar.gz"
      sha256 "35f92794c583e90f026bcab7cc940a23dac04a04bb0da855b34f9e188c02d60c"
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
