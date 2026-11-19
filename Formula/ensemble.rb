class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.8.3"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.3/ensemble-cli-0.8.3-darwin-arm64.tar.gz"
      sha256 "b057cc0226061fbf49f9dc2ba68266e7f71698965694c4326d0058baf6057a54"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.3/ensemble-cli-0.8.3-darwin-x64.tar.gz"
      sha256 "1b7fafd30c4c406eb6ee094cd6e2228dbb9da7953be785573cac6c7b192c239b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.3/ensemble-cli-0.8.3-linux-arm64.tar.gz"
      sha256 "5210c7333e2c24be903aea609acda78a59d3851434c2214231757c2928d3a6b3"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.3/ensemble-cli-0.8.3-linux-x64.tar.gz"
      sha256 "704dbbdb7fa3395cbce1ae36c91716622bbb3a141a45045445c145c1fdedf876"
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
