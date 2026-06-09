class HornbillCli < Formula
  desc "CLI client for Hornbill bill tracker"
  homepage "https://github.com/chickenzord/hornbill"
  version "0.1.5"
  license "AGPL-3.0-only"

  url "https://github.com/chickenzord/hornbill/releases/download/v0.1.5/hornbill-linux-x64"
  sha256 "9104bba4d1f833da47c7f77be128ba07e270e9d0204f5aa39013361e44e39cbb"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.5/hornbill-darwin-arm64"
      sha256 "fd3022a53ca7e0f14a4ac8406b91d11c033bf27f34848b7b687b32cbe551267a"
    else
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.5/hornbill-darwin-x64"
      sha256 "3943144c037d7c188ceb46ad5d829f03cd0fa240b20b0d9d747bd33731f3ec8a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.5/hornbill-linux-arm64"
      sha256 "83ba84d99c6c41a09352d627b09e0d32f31c6b7ea46a26b7fa72f71dc842903c"
    else
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.5/hornbill-linux-x64"
      sha256 "9104bba4d1f833da47c7f77be128ba07e270e9d0204f5aa39013361e44e39cbb"
    end
  end

  head "https://github.com/chickenzord/hornbill.git", branch: "main"

  depends_on "bun" => :build if build.head?

  def install
    if build.head?
      system "bun", "install"
      system "bun", "run", "--cwd", "packages/cli", "build"
      bin.install "packages/cli/bin/hornbill"
    else
      # Homebrew renames single-file downloads to the formula name (hornbill-cli)
      # but we check both names to be safe.
      if File.exist?("hornbill-cli")
        bin.install "hornbill-cli" => "hornbill"
      else
        binary_name = if OS.mac?
          Hardware::CPU.arm? ? "hornbill-darwin-arm64" : "hornbill-darwin-x64"
        else
          Hardware::CPU.arm? ? "hornbill-linux-arm64" : "hornbill-linux-x64"
        end
        bin.install binary_name => "hornbill"
      end
    end
  end

  test do
    system "#{bin}/hornbill", "--help"
  end
end
