class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.6.7"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.7/ensemble-cli-0.6.7-darwin-arm64.tar.gz"
      sha256 "166f8992954bcfa00f140b5bc069d49b2c54ad01d18d1ed5908a8236b3626be3"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.7/ensemble-cli-0.6.7-darwin-x64.tar.gz"
      sha256 "d01ec4d77534cb60f7ffb12bd1cffb9b6533b091170c0a3229c9bf26005c3635"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.7/ensemble-cli-0.6.7-linux-arm64.tar.gz"
      sha256 "c71aca1a43ffebff6458b1df03404ad039d78413bd54835e4270ee370a3c303d"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.7/ensemble-cli-0.6.7-linux-x64.tar.gz"
      sha256 "ee228ca04bc2a415592c9299bdac1cce6556059d888f1a413203f7e040e50617"
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
