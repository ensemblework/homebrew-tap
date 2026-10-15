class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.3.10"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.10/ensemble-cli-0.3.10-darwin-arm64.tar.gz"
      sha256 "ef31d80e158ec1f83f504cd9648e9f740757aed43eef8695d3413c4731b6c606"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.10/ensemble-cli-0.3.10-darwin-x64.tar.gz"
      sha256 "e1c281c955a6731471af5d7ecff372862728fc8445a4953630a8f4e1bf7df412"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.10/ensemble-cli-0.3.10-linux-arm64.tar.gz"
      sha256 "37d5ccab415d29fbf595b527c6077ade5e79bccfa4fd26e4d2648a3bda9c1d80"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.10/ensemble-cli-0.3.10-linux-x64.tar.gz"
      sha256 "88cb59f6f1102f27be4f32234d5478d7ec9787efc830cb802d593b5bef669e47"
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
