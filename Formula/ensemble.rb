class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.3"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.3/ensemble-cli-0.4.3-darwin-arm64.tar.gz"
      sha256 "4150a1306a5f3a802dba441a7cf7839ab4097e25a5709584b6d643bd9c346da4"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.3/ensemble-cli-0.4.3-darwin-x64.tar.gz"
      sha256 "1abf0cb12e9eb4ad8992c279f1d420c797e1b4db89eee7d729d81792ff49a457"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.3/ensemble-cli-0.4.3-linux-arm64.tar.gz"
      sha256 "78b017a4725c4f1b5d1925bbbbc745a0db78384f8aee31d37e4b84a1ce91de46"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.3/ensemble-cli-0.4.3-linux-x64.tar.gz"
      sha256 "1239b44ddbf34504a349be7f9afd2a0efdb12055ae610d347c07316412007da1"
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
