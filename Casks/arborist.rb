cask "arborist" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "2.0.0"
  sha256 arm:          "a3b7ddf66f4d84a403cbecc19aa0c52ddc1536d1be5fa387872234400a9fffc8",
         intel:        "b94c13540cf1504be07e9abbd40e53ef14b7b0f0b8ab6555f93eb662de59ae60",
         arm64_linux:  "39026d7e15d2c23b45bec69420e45d7a6ec462446f265bc1f1f9728565fac42b",
         x86_64_linux: "5b386c861f986582948705848cdc0051b691b154273abd2eb1c448b9ceadc317"

  url "https://github.com/cballenar/arborist/releases/download/v#{version}/arborist-#{os}-#{arch}"
  name "Git Arborist"
  desc "High-performance Git worktree and isolated database manager for local web development"
  homepage "https://github.com/cballenar/arborist"

  container type: :naked

  binary "arborist-#{os}-#{arch}", target: "arborist"
  binary "arborist-#{os}-#{arch}", target: "gar"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", staged_path], must_succeed: false
    end
  end

  caveats <<~EOS
    To enable automatic directory switching (`gar switch`) and tab completion, add this to your ~/.zshrc or ~/.bashrc:
      eval "$(gar hook)"
  EOS
end
