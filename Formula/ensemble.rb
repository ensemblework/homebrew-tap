class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.3.3"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.3/ensemble-cli-0.3.3-darwin-arm64.tar.gz"
      sha256 "6aec8f305a6ca6ff349744f33f49c7e98d886ffb44908dbcd52324594d56a5bc"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.3/ensemble-cli-0.3.3-darwin-x64.tar.gz"
      sha256 "0efa2a6399897619092fc255a84e94cde477ae13fb97b3524b074e237c04cdd4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.3/ensemble-cli-0.3.3-linux-arm64.tar.gz"
      sha256 "380381b8a40ddb53e9f764907fd9a2b0635843979bc02d85e2fc9bc368627b03"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.3/ensemble-cli-0.3.3-linux-x64.tar.gz"
      sha256 "d6d6248efc1755103631ab12ce612c1ce397365ae8aaccac7ed24ecb081ba87d"
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
