class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.16"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.16/ensemble-cli-0.4.16-darwin-arm64.tar.gz"
      sha256 "f61f3c8199339099aa4c3e2be779e0b10214a05a39d487d856baa0356ca1b917"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.16/ensemble-cli-0.4.16-darwin-x64.tar.gz"
      sha256 "91081cd29a0c2b1d966765ccba0b715b96f122f60deceba0c23f18065a2d7fea"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.16/ensemble-cli-0.4.16-linux-arm64.tar.gz"
      sha256 "0330de3613e61dddd7985d7630d0e238b7cadb56063491af9b4bb32b0e53b9d2"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.16/ensemble-cli-0.4.16-linux-x64.tar.gz"
      sha256 "cd62604c85270213d3693e0e6c6b9c5f78140ac632b57a7ddd83c1576e6d936d"
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
