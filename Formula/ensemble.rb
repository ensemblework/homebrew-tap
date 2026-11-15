class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.8.1"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.1/ensemble-cli-0.8.1-darwin-arm64.tar.gz"
      sha256 "1531de13bfd7a931166c2d090a2c6d3c10bfe1f9bfeab73e174344dbe2f6e992"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.1/ensemble-cli-0.8.1-darwin-x64.tar.gz"
      sha256 "2a69598010a4bb25f7db4f178141e25de96a954a2bb9f9e2b205e36ffa27fa2b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.1/ensemble-cli-0.8.1-linux-arm64.tar.gz"
      sha256 "637266750dd09ba0262ef19ef60c8159e572957f84710d54186fa20bd94917b8"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.8.1/ensemble-cli-0.8.1-linux-x64.tar.gz"
      sha256 "7bada1b006ca83e285e2bcb4b64855161e3a9f1e9f3a53d2d4d908abc55b557b"
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
