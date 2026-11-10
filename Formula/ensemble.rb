class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.9"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.9/ensemble-cli-0.7.9-darwin-arm64.tar.gz"
      sha256 "5aa51ad8a87457d70ae17ca85e99e53034552fb2b417c68a57d246edc607c3cb"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.9/ensemble-cli-0.7.9-darwin-x64.tar.gz"
      sha256 "80285eff1d9de4bef6b5d584a4acda8593904908864c05ba77fda06922be9c4a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.9/ensemble-cli-0.7.9-linux-arm64.tar.gz"
      sha256 "eddad262c7710fc83956b2ef7f1c62cb8aa57eea930bda332189bebbb4129b47"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.9/ensemble-cli-0.7.9-linux-x64.tar.gz"
      sha256 "af5aa3b719e6aabaa4f5e02aa681dc40647041f9ef82cb50899d2941dc53ed26"
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
