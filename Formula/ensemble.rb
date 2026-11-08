class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.0"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.0/ensemble-cli-0.7.0-darwin-arm64.tar.gz"
      sha256 "912270f852b0ad5f56d0141f39096f2ec3a368da0d81c01b0e53d9afba6d0f40"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.0/ensemble-cli-0.7.0-darwin-x64.tar.gz"
      sha256 "2885aa26d5eb3c64a1a38cf80592c161f1b5d29e902aacc199505710fac03a29"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.0/ensemble-cli-0.7.0-linux-arm64.tar.gz"
      sha256 "7854dc6530f4bb05c6ab32053e68373c25ecca9e685a65e6cfc7c18b494248a4"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.0/ensemble-cli-0.7.0-linux-x64.tar.gz"
      sha256 "bee6f24cc5d3161791e89047acede5610351aba958718d64d8895da2c925b952"
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
