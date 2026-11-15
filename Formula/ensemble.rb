class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.8.0"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.0/ensemble-cli-0.8.0-darwin-arm64.tar.gz"
      sha256 "e2c721a6375f922cf598244eac58ee69ccb3e0d0de4a8d96d7fba5336d052a84"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.0/ensemble-cli-0.8.0-darwin-x64.tar.gz"
      sha256 "9f222a0b338a5b7494fb270d08e84f0f6b5b4487d1e35010630b7756324f63d4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.0/ensemble-cli-0.8.0-linux-arm64.tar.gz"
      sha256 "75e8853dbdace822679386b21ff93f83b3d505aa75c60c21dd6b6072e43f5c20"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.0/ensemble-cli-0.8.0-linux-x64.tar.gz"
      sha256 "ee4aedc84655a5a50925bf9135ed1ebc11a75ad85be3f3e42b111108aac11be9"
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
