class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.6.1"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.1/ensemble-cli-0.6.1-darwin-arm64.tar.gz"
      sha256 "b3a7016a2061cbf39340d9888713670e60d7240aa200b4267e4ed4b3a3c9562c"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.1/ensemble-cli-0.6.1-darwin-x64.tar.gz"
      sha256 "698be7f981b16d8ce322680ace742416937c7ef148d49da33228ddb6624e42ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.1/ensemble-cli-0.6.1-linux-arm64.tar.gz"
      sha256 "e9c89d24a8d0b6f212199b8fe1e01b73bb1da9be029dfcffe4c66112acc7fd2f"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.1/ensemble-cli-0.6.1-linux-x64.tar.gz"
      sha256 "9ae084c0d451440a954aa7b36c24620f08708a3ea2cc516b90e4e65e3ea79de5"
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
