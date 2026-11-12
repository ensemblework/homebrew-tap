class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.13"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.13/ensemble-cli-0.7.13-darwin-arm64.tar.gz"
      sha256 "ea71550492cb19b376241e7334f2e86832576f3a1eb85172079eba586e552801"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.13/ensemble-cli-0.7.13-darwin-x64.tar.gz"
      sha256 "2a4ce54045bd8ffe1d5c853e4e5f9b454a81a561e798855e3246759131ca2299"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.13/ensemble-cli-0.7.13-linux-arm64.tar.gz"
      sha256 "b4c92a97c03af2ebb551857312cd324a7a612ec57a310f9ca85273dccab1db4b"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.13/ensemble-cli-0.7.13-linux-x64.tar.gz"
      sha256 "6d5da758d7d4aaa994a75b4f5f891ac365a3422f95ee7e91729f6509baaad7b8"
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
