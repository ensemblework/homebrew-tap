class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.17"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.17/ensemble-cli-0.4.17-darwin-arm64.tar.gz"
      sha256 "8040c7dbbf97779f48a181bce171442fda4b35ceb8585c5d568c77d7e16a3d1e"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.17/ensemble-cli-0.4.17-darwin-x64.tar.gz"
      sha256 "43a4824089048d08b64f3ada856ccdb578fb4dfd1da4eedf9f9c50dafaa7bbaa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.17/ensemble-cli-0.4.17-linux-arm64.tar.gz"
      sha256 "4f3b4cec71f93cf04296d872f48db0b8cc034482a4045a43f92d4dbb924ddddc"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.17/ensemble-cli-0.4.17-linux-x64.tar.gz"
      sha256 "6df0f7c59bb9a50e5c2ea473662f0cdc49cb04f0de8588c3bd26a7e8e3748b0e"
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
