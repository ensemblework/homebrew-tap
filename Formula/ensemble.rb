class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.13"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.13/ensemble-cli-0.4.13-darwin-arm64.tar.gz"
      sha256 "9cdcdf851d35923c5e0797630070f1dc29f77926dd124dca95be4c9ebf610853"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.13/ensemble-cli-0.4.13-darwin-x64.tar.gz"
      sha256 "e016934e91259ebde9cadf0321b11e12b49bcf6e6ce719b55a1575be7f22b6b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.13/ensemble-cli-0.4.13-linux-arm64.tar.gz"
      sha256 "0599549dfe46c701cc34d041177e38eb89f167830e67a20646af91206af9fbc3"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.13/ensemble-cli-0.4.13-linux-x64.tar.gz"
      sha256 "985e608cd32e633f09dd421a54c937976fbae62d21159b8db25196fe3f61d3c7"
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
