class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.2.0/ensemble-cli-0.2.0-darwin-arm64.tar.gz"
      sha256 "391a922f029b229f77cd5998f201fea0527c2f39a409d40694a15c6c713d7b56"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.2.0/ensemble-cli-0.2.0-darwin-x64.tar.gz"
      sha256 "8b5e333815066fc4d97bdc6197d92da0f71f97c3d58876f583a4e4df46fe8067"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.2.0/ensemble-cli-0.2.0-linux-arm64.tar.gz"
      sha256 "7cfe8f3697bab016295b55d5b0855f2e0246b48f3195e943a108b24dfb460d53"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.2.0/ensemble-cli-0.2.0-linux-x64.tar.gz"
      sha256 "2c660b495c30a0db95b0581c8f2ad5a820753319e2c7a22b0566285602e9be44"
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
