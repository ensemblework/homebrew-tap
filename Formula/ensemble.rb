class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.12"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.12/ensemble-cli-0.4.12-darwin-arm64.tar.gz"
      sha256 "77a8f6520a4776fdba965f36e26895764ede087d106c31a63447265320748032"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.12/ensemble-cli-0.4.12-darwin-x64.tar.gz"
      sha256 "736e79ad03fdb39595b4b697424a9b30855b358ad33df32fd1bceddf09865cb3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.12/ensemble-cli-0.4.12-linux-arm64.tar.gz"
      sha256 "af04e6e7692894f4f1d1384f67cd29211fe1434f5433410b9546628792790067"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.12/ensemble-cli-0.4.12-linux-x64.tar.gz"
      sha256 "e47546ca261a52ecdd45717ed9aad77e49f7b33d4de3d9729b0118348e0ec6ae"
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
