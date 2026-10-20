class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.6"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.6/ensemble-cli-0.4.6-darwin-arm64.tar.gz"
      sha256 "dfcb3f739586bc9620df1d7678d9bd6d81a7a18a133cdb90aa021d7ede155f33"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.6/ensemble-cli-0.4.6-darwin-x64.tar.gz"
      sha256 "1b9c31d4e55feb7f364e9e5283f14c849c633746e6cef69e667372f6843a0646"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.6/ensemble-cli-0.4.6-linux-arm64.tar.gz"
      sha256 "2f359653990c6502d85804fb91c4a307b19cb705a511d96ee4f45c04fcb85b4f"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.6/ensemble-cli-0.4.6-linux-x64.tar.gz"
      sha256 "c02fe0e8e02c5f39e368a36e7593e85496d8337bf4cb4ae02a84b0100f182fb9"
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
