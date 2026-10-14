class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.3.7"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.7/ensemble-cli-0.3.7-darwin-arm64.tar.gz"
      sha256 "6d516a0ccef91b9668029be1bb524dd745cff1d074a1151996f295351bee5077"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.7/ensemble-cli-0.3.7-darwin-x64.tar.gz"
      sha256 "8704f01681910aa8e6539ab6d2d8a8a22ccc1408ff595f02146bd4dff72c233c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.7/ensemble-cli-0.3.7-linux-arm64.tar.gz"
      sha256 "14b8b64ff0c38dbaa92af2404039e7a2e0f0250b7db0fee63cb67048395e6045"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.7/ensemble-cli-0.3.7-linux-x64.tar.gz"
      sha256 "975ea4cf512426c73f09c826cae93b6b86547afb55faceb4e695fa361291d22a"
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
