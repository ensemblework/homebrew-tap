class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.0/ensemble-cli-0.3.0-darwin-arm64.tar.gz"
      sha256 "39f5168d8ca791bff4c967a0ddd2a08d83c1ce48b6d536943ed41a1e786c6656"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.0/ensemble-cli-0.3.0-darwin-x64.tar.gz"
      sha256 "1f5cef01c44c895cb8b4c04640c11da726a8d08e665d8afc482a33ad285521a5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.0/ensemble-cli-0.3.0-linux-arm64.tar.gz"
      sha256 "50efb74133713d0876876acb8bfc2f2eb4c6a3660fb4483eecc29cdcf59a594f"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.0/ensemble-cli-0.3.0-linux-x64.tar.gz"
      sha256 "85fae8df8c94ed93d8286ad8e0b3e90fedfc64ff478c1c765d939470a283aba1"
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
