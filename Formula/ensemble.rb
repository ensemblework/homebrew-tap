class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.14"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.14/ensemble-cli-0.4.14-darwin-arm64.tar.gz"
      sha256 "dc7c724c142af8b94b0f85aec18386bf7aff77c31d54dfaef0223b2527676324"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.14/ensemble-cli-0.4.14-darwin-x64.tar.gz"
      sha256 "62b2ab4d4527041688bc35f67e9e7b1d3d1dcbb3e5e01e5810c992fcc373e145"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.14/ensemble-cli-0.4.14-linux-arm64.tar.gz"
      sha256 "a2814891a9acb7e351a41ad3bf641e22ed8e3fcb33b824d0b7f5555b10c6252f"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.14/ensemble-cli-0.4.14-linux-x64.tar.gz"
      sha256 "47ff0f33220f2d5bf5ba8af6075435360de5ecf114b57e65acee266833cad43a"
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
