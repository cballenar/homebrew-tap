class Arborist < Formula
  desc "High-performance Git worktree and isolated database manager for local web development"
  homepage "https://github.com/cballenar/arborist"
  version "2.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cballenar/arborist/releases/download/v#{version}/arborist-macos-aarch64"
      sha256 "a3b7ddf66f4d84a403cbecc19aa0c52ddc1536d1be5fa387872234400a9fffc8"
    else
      url "https://github.com/cballenar/arborist/releases/download/v#{version}/arborist-macos-x86_64"
      sha256 "b94c13540cf1504be07e9abbd40e53ef14b7b0f0b8ab6555f93eb662de59ae60"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cballenar/arborist/releases/download/v#{version}/arborist-linux-aarch64"
      sha256 "39026d7e15d2c23b45bec69420e45d7a6ec462446f265bc1f1f9728565fac42b"
    else
      url "https://github.com/cballenar/arborist/releases/download/v#{version}/arborist-linux-x86_64"
      sha256 "5b386c861f986582948705848cdc0051b691b154273abd2eb1c448b9ceadc317"
    end
  end

  def install
    binary = Dir["arborist-*"].first || "arborist"
    bin.install binary => "arborist"
    bin.install_symlink "arborist" => "gar"
  end

  def caveats
    <<~EOS
      To enable automatic directory switching (`gar switch`) and tab completion, add this to your ~/.zshrc or ~/.bashrc:
        eval "$(gar hook)"
    EOS
  end

  test do
    assert_match "Git Arborist (gar) v#{version}", shell_output("#{bin}/gar --version")
    assert_match "Git Arborist", shell_output("#{bin}/gar --help")
  end
end
