class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.6.3"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.3/ensemble-cli-0.6.3-darwin-arm64.tar.gz"
      sha256 "71981a5e8e35fb92dffa0146e9c5bac1f7ec9eed8226e2e44a7b176e4c1bbfea"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.3/ensemble-cli-0.6.3-darwin-x64.tar.gz"
      sha256 "39dcf939efdb7b13791e0355fe24fdc1de335e98eaec5a5bccaa370b11d8d1e9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.3/ensemble-cli-0.6.3-linux-arm64.tar.gz"
      sha256 "3faf3ec5331fb57a244e6e563b5dd4f7941e2bb8d8a576a149c34c93d9997eb7"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.3/ensemble-cli-0.6.3-linux-x64.tar.gz"
      sha256 "516f47a0fada893de3eb573b64fb5d8dc3205e70f42eb02bf3e089710ea50a15"
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
