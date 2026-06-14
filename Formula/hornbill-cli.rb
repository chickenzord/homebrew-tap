class HornbillCli < Formula
  desc "CLI client for Hornbill bill tracker"
  homepage "https://github.com/chickenzord/hornbill"
  version "0.2.0"
  license "AGPL-3.0-only"

  url "https://github.com/chickenzord/hornbill/releases/download/v0.2.0/hornbill-linux-x64"
  sha256 "73346ec5eccd96e677e2021dfac1216ca8dd78f92bc9d86eb3263365c2b9a328"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chickenzord/hornbill/releases/download/v0.2.0/hornbill-darwin-arm64"
      sha256 "fc31d9908def2e79820101b9fc6099b6159a963741f3adc70c0d35de82eb47e1"
    else
      url "https://github.com/chickenzord/hornbill/releases/download/v0.2.0/hornbill-darwin-x64"
      sha256 "5d017cfc4fb09c6ca95f63cc53634d0d1562791deacba3742f3ed20d1c2768dd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chickenzord/hornbill/releases/download/v0.2.0/hornbill-linux-arm64"
      sha256 "21323050801610a131e2fc25f246c8d5b506f3d28c3441d0e1b3e0198acc320b"
    else
      url "https://github.com/chickenzord/hornbill/releases/download/v0.2.0/hornbill-linux-x64"
      sha256 "73346ec5eccd96e677e2021dfac1216ca8dd78f92bc9d86eb3263365c2b9a328"
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
