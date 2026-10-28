class Slackterm < Formula
  desc "Slack in your terminal: real time, threads, search and sections, all from the keyboard"
  homepage "https://github.com/simoncdna/slackterm"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/simoncdna/slackterm/releases/download/v0.3.0/slackterm-aarch64-apple-darwin.tar.xz"
      sha256 "344daac0ad0e0786264ae1b36ef479ab0169f295bb5a1baa525d6562a778b855"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simoncdna/slackterm/releases/download/v0.3.0/slackterm-x86_64-apple-darwin.tar.xz"
      sha256 "0780414d9ece9a31be14dcd195e28818cbb39dea566baccaa79446f8de9a9271"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/simoncdna/slackterm/releases/download/v0.3.0/slackterm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9c21a3d29f16304ea07d66885150e40c7341a23b8c8d17bca76440350162d03d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/simoncdna/slackterm/releases/download/v0.3.0/slackterm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "43bad72d1d47cb620c861bb98274cae99321b3188adbca6f0665d1ca9d837028"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "slackterm"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "slackterm"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "slackterm"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "slackterm"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
