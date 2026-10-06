class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.1.0/ensemble-cli-0.1.0-darwin-arm64.tar.gz"
      sha256 "656576e5c8a693db62b7ad68ac72a34979dacf255311fe2ca7a176dba10995c6"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.1.0/ensemble-cli-0.1.0-darwin-x64.tar.gz"
      sha256 "6b448d6e266761fc065d9ab6ac9364176ce04abaee3642ffb150b87914c0af26"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.1.0/ensemble-cli-0.1.0-linux-arm64.tar.gz"
      sha256 "53adebf29885c46d73d9714fd8237eef72c3cacfd101d61e9e5ae9591acb28ca"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.1.0/ensemble-cli-0.1.0-linux-x64.tar.gz"
      sha256 "b786380ac4b622b87d39ee7425cd17ce3519821fdc5fee80e469125fde770b7b"
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
