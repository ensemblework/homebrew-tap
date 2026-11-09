class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.5"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.5/ensemble-cli-0.7.5-darwin-arm64.tar.gz"
      sha256 "850898f11ff38f419d91b4512037f277c2a3dc696734b3d05312b3e59da1d4b4"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.5/ensemble-cli-0.7.5-darwin-x64.tar.gz"
      sha256 "b77b2eead174c1f4aa70f1a0285ca5dfaef5a240febe26b61174678c286497d9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.5/ensemble-cli-0.7.5-linux-arm64.tar.gz"
      sha256 "07873952fa16c1bc61c78bccd245717319d640ad4b3c7bb67cba35b0af587a67"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.5/ensemble-cli-0.7.5-linux-x64.tar.gz"
      sha256 "698c3c0cba4441f2006a1c90bb82c34a343df6b9c0aabdcde6efb46593d5f5fc"
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
