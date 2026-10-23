class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.9"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.9/ensemble-cli-0.4.9-darwin-arm64.tar.gz"
      sha256 "dd4cdcbf57c5c60ac9c9d1a887aacb7fc38e799fd47a4f1f4f0d4ed61150e64e"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.9/ensemble-cli-0.4.9-darwin-x64.tar.gz"
      sha256 "69b1fb14a256fda42ac6e83dd5e9d6718a6f0b48c2a9a7643270b1658c359f16"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.9/ensemble-cli-0.4.9-linux-arm64.tar.gz"
      sha256 "b4d1101482e0a9743e6993428b3abaa8c9b7616444f8e077fac62ba5135a69c3"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.9/ensemble-cli-0.4.9-linux-x64.tar.gz"
      sha256 "157a574b4ab289909c4fc6226d54af2ac43599c86a98e4425562c61383507c9b"
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
