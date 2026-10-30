class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.6.0"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.0/ensemble-cli-0.6.0-darwin-arm64.tar.gz"
      sha256 "ab78cf4a921f54afc0e2b7d5b2eaf3ab6b16798a219887f65567d7733249760e"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.0/ensemble-cli-0.6.0-darwin-x64.tar.gz"
      sha256 "8665cbac72365aa1d5f669421a64b8606e86b1d1538f81f3cb3ed986526a9d70"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.0/ensemble-cli-0.6.0-linux-arm64.tar.gz"
      sha256 "f0339e4b37ed73dae2009ee501252d6b5790d18e72c1a402445330ed14ea32b6"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.0/ensemble-cli-0.6.0-linux-x64.tar.gz"
      sha256 "838ce925c14a1560e841d9fede53f7a9deab535216130f3b55ae7d7479904c1e"
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
