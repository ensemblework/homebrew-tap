class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.2"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.2/ensemble-cli-0.7.2-darwin-arm64.tar.gz"
      sha256 "2809b7e5a5eadc6e5c8796cb21bddb1f5745c4687b0cf046b40117ef568d6f34"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.2/ensemble-cli-0.7.2-darwin-x64.tar.gz"
      sha256 "598ff4a80fd85908ca17e9eb208cd801f487362987fcf5898e193f799c4aa312"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.2/ensemble-cli-0.7.2-linux-arm64.tar.gz"
      sha256 "1d73c69df21ad4d41defeadd9e80865c85705c75f7ef04b53857e2ff71b3642f"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.2/ensemble-cli-0.7.2-linux-x64.tar.gz"
      sha256 "538a128428c81cfd566e4341b72f5b240a37f786f65f8c00a1875766f93f73de"
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
