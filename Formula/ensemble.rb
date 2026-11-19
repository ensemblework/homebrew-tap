class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.8.4"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.4/ensemble-cli-0.8.4-darwin-arm64.tar.gz"
      sha256 "2aea47905bb9be7c8f774db5e79a626a1971c8aac37d7b33009411ff02dc5228"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.4/ensemble-cli-0.8.4-darwin-x64.tar.gz"
      sha256 "2f8b071860abab9e6e035b9a999d9b81e4f6f1c819b0de92fe28629285e11c28"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.4/ensemble-cli-0.8.4-linux-arm64.tar.gz"
      sha256 "f34f6c8a3e06c83b1ef560a42fe155a44d096107c908266970a0adab38f48ed6"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.4/ensemble-cli-0.8.4-linux-x64.tar.gz"
      sha256 "a3bca66bb3b26ede625c4560581aa2279c122286eed37e26a775610444399d77"
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
