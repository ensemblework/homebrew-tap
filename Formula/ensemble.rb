class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.17"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.17/ensemble-cli-0.7.17-darwin-arm64.tar.gz"
      sha256 "7070b9f42d769300e379b6a3261b18cb18b59be96dcc35ce84c0cae3f2260034"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.17/ensemble-cli-0.7.17-darwin-x64.tar.gz"
      sha256 "550c9ea7fed4027c47af97592abc32d4d5cdab297f4ae1623b7eca689a329238"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.17/ensemble-cli-0.7.17-linux-arm64.tar.gz"
      sha256 "37d10c1a64028131f0f8edc64a06d773d3a827977b044f8c5a9746d6220d7a32"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.17/ensemble-cli-0.7.17-linux-x64.tar.gz"
      sha256 "b67d4ac0a6a5c7c7929011757df240540fab9872811a569ea99bb1ff0c989988"
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
