class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.12"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.12/ensemble-cli-0.7.12-darwin-arm64.tar.gz"
      sha256 "7696d721162b61f4219f55cf46418dafde03086583002c167c3e2619545d30db"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.12/ensemble-cli-0.7.12-darwin-x64.tar.gz"
      sha256 "b8d4a10af0bb8efbca3d91e8eff65474bfcf4d5bed49217731c869bdb616d60c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.12/ensemble-cli-0.7.12-linux-arm64.tar.gz"
      sha256 "f084e19f62ffcc0bd44fdc45df54a882a6cc8e7a07af35f32affd246e211bede"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.12/ensemble-cli-0.7.12-linux-x64.tar.gz"
      sha256 "d0a2275f5a14fa0b660cc3d3d62ae81ed199f227d84c775069d626753dd4c5c6"
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
