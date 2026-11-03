class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.6.6"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.6/ensemble-cli-0.6.6-darwin-arm64.tar.gz"
      sha256 "c40814d5d31ceafaefca3f4bdc076f5179265a2ef4bd446db021b69f6b9cdd58"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.6/ensemble-cli-0.6.6-darwin-x64.tar.gz"
      sha256 "250ffffbfb4126cfd202d40e2850d2e056409d5d53b21529168676f15b003ad2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.6/ensemble-cli-0.6.6-linux-arm64.tar.gz"
      sha256 "a984a8a1aa4b36b9d7600e2e9af12a8c119fccd8e5095e5c059af2923d33b0e0"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.6/ensemble-cli-0.6.6-linux-x64.tar.gz"
      sha256 "44e3e0bc3b3b170973148fcb2a5dc9afc64a7de75133fbcdf0e774fd46dba0d3"
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
