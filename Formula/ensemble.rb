class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.22"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.22/ensemble-cli-0.4.22-darwin-arm64.tar.gz"
      sha256 "f1cf69ae8080599f044131930674d01f8a260e4b416cf9c30a35daca299900d0"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.22/ensemble-cli-0.4.22-darwin-x64.tar.gz"
      sha256 "4df878b523d722c66d03b8e892a7b984d66cb0b9bc5c99e485b92b3423dd030a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.22/ensemble-cli-0.4.22-linux-arm64.tar.gz"
      sha256 "1ef6fdaeccd81107d1b6a5ea3537d421a65054b81e9b3fafaa9b461123fdad09"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.22/ensemble-cli-0.4.22-linux-x64.tar.gz"
      sha256 "cdfda4ded2d8ac1527544535333a093f6155dac8e18bcbc40857b2901aa933ef"
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
