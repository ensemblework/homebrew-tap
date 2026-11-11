class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.10"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.10/ensemble-cli-0.7.10-darwin-arm64.tar.gz"
      sha256 "f66ea781170fef6c4b725b020ea302a36f3f3bc9304aae624149195d88ce74a0"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.10/ensemble-cli-0.7.10-darwin-x64.tar.gz"
      sha256 "f1cc81431b7e6bb1679655e14ff2c4f7133c6cbf062480f577764b6b5a0bba3e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.10/ensemble-cli-0.7.10-linux-arm64.tar.gz"
      sha256 "c1e53601493f1fa3a5b1ca8d64352ddbcc1470f5038dac10736cfef465a4ba5a"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.10/ensemble-cli-0.7.10-linux-x64.tar.gz"
      sha256 "83a7c6286410caea0852c6072389bdc4a1f2c5a61d0858d6157a11cc062a2a1f"
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
