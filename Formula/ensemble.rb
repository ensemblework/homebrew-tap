class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.19"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.19/ensemble-cli-0.4.19-darwin-arm64.tar.gz"
      sha256 "9d9fa977bff0dd2067c7eaeb49f9e5e6bca4fdcb0f50d918393746a301cfde12"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.19/ensemble-cli-0.4.19-darwin-x64.tar.gz"
      sha256 "ac4927ffb1fc4eec4830ffadd27bc30e18034a138d88bcb9e8a56f7d196e6bb3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.19/ensemble-cli-0.4.19-linux-arm64.tar.gz"
      sha256 "bf1c1f5868b9cc8ec407764bdee1fe41663a004341d2869023e876f53be24f1f"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.19/ensemble-cli-0.4.19-linux-x64.tar.gz"
      sha256 "f7a7d46533eb42d67626baebaf05aec8e897943faea20f4210541f38c24bf10a"
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
