class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.3.11"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.11/ensemble-cli-0.3.11-darwin-arm64.tar.gz"
      sha256 "3bc07ccc386100a3de0003f3d48e87220c01c8448f953148b4bbd929c33cfb82"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.11/ensemble-cli-0.3.11-darwin-x64.tar.gz"
      sha256 "f4a6387504af1a145e5490f5f0b1364d0227cca75fafe350738b681e3d12f616"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.11/ensemble-cli-0.3.11-linux-arm64.tar.gz"
      sha256 "66b404e28f2cd79209d40a66e975a242e97f931a15a16a2bdb202e3bb201cc6f"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.11/ensemble-cli-0.3.11-linux-x64.tar.gz"
      sha256 "c9d1849a80768948271369f83968c38262430e93ffb8bf1af1c53f8fb679131b"
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
