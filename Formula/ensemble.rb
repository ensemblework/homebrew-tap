class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.20"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.20/ensemble-cli-0.4.20-darwin-arm64.tar.gz"
      sha256 "14f46e3546addcc802c6450f269c075536dec88a47e84060775293dd6936a6ec"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.20/ensemble-cli-0.4.20-darwin-x64.tar.gz"
      sha256 "11920710291544bf7418da83c9f0ea5ef26bd22ddef21bb7bfe1bcc8046e2e25"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.20/ensemble-cli-0.4.20-linux-arm64.tar.gz"
      sha256 "116c12564d697a540f7de560dae72fa2e6c9abfc9c98ff778c0a1afed420db60"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.20/ensemble-cli-0.4.20-linux-x64.tar.gz"
      sha256 "dfa5ecade2346107851fe2728deb49fa6d4ff20fe94805c0c25f93af2ebd0c1e"
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
