class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.24"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.24/ensemble-cli-0.4.24-darwin-arm64.tar.gz"
      sha256 "663e3cd6f7648ac67df3f3dee844c04f2ce4873d038bc66930eb08582728400a"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.24/ensemble-cli-0.4.24-darwin-x64.tar.gz"
      sha256 "207981ccd91fcb4509d81eb9a48ae3b8ea282ce77ecfcc212f4fb974e312341a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.24/ensemble-cli-0.4.24-linux-arm64.tar.gz"
      sha256 "44fc16eecf7b5451bbbe182a96b81eb116ec0eacf6d177cb3fa27ab91b6dfe9b"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.24/ensemble-cli-0.4.24-linux-x64.tar.gz"
      sha256 "b0e74efd882dd6d151bfeacce72855695ab4c92a2cd83e9aa03c3f88ffc84008"
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
