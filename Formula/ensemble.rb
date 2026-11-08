class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.4"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.4/ensemble-cli-0.7.4-darwin-arm64.tar.gz"
      sha256 "d7aa35112ed401428e2f3d8d0be1b7cdf9787ee55f3c093bd745e05d792ef32d"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.4/ensemble-cli-0.7.4-darwin-x64.tar.gz"
      sha256 "b94868f5f2ab49c2089d5a753846508453bdbabfa634748bd18906cd860ed252"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.4/ensemble-cli-0.7.4-linux-arm64.tar.gz"
      sha256 "46565d77e7a60e082f2e04edcc1bae1e4c6adb6de15b6ad40a6d4d9e90812457"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.4/ensemble-cli-0.7.4-linux-x64.tar.gz"
      sha256 "be2b6df9a3ba51c35f670f94f5edffe6071fc289c2334cfc3870d804a0be2a1c"
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
