class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.3.5"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.5/ensemble-cli-0.3.5-darwin-arm64.tar.gz"
      sha256 "d4b002c4d25812676acf16bcfd41b64f9f3ebf2daf85353132cb5b44eb4e03fd"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.5/ensemble-cli-0.3.5-darwin-x64.tar.gz"
      sha256 "8d7e011be5e5c8ae44c93118c9ff64685784f41edda618b12f4219f7f69476fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.5/ensemble-cli-0.3.5-linux-arm64.tar.gz"
      sha256 "4ead4e12b9064ef184d300b293177fcc2ec4bb2a7b66f274098cf7437edcf338"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.5/ensemble-cli-0.3.5-linux-x64.tar.gz"
      sha256 "ba5834658c63478a108b6a5899934d52a9b51a927f712489b7de1140e2492e64"
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
