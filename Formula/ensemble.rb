class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.15"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.15/ensemble-cli-0.7.15-darwin-arm64.tar.gz"
      sha256 "27486df2bd4884f53a5fa9d18aedf523b38881e499111e9f16d342db7ed4463d"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.15/ensemble-cli-0.7.15-darwin-x64.tar.gz"
      sha256 "1fd55762c9e983593f0e183bbdb9d47dec7173ad108f070f58d24daa4ceead6b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.15/ensemble-cli-0.7.15-linux-arm64.tar.gz"
      sha256 "a30ed91858e644f04fce01cc4b91ee3000ea9d5bbc7b44e5a8a4c4e0317bed54"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.15/ensemble-cli-0.7.15-linux-x64.tar.gz"
      sha256 "b234c83f2b8c371bd4e91e4deb21438958c50a3af29e525cb2d10794e6ba28ba"
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
