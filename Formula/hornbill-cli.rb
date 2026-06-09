class HornbillCli < Formula
  desc "CLI client for Hornbill bill tracker"
  homepage "https://github.com/chickenzord/hornbill"
  version "0.1.4"
  license "AGPL-3.0-only"

  url "https://github.com/chickenzord/hornbill/releases/download/v0.1.4/hornbill-linux-x64"
  sha256 "0b1dc23f7aae4fdf972b2445a8ebbd8e117b769a8cd39824c8533db39eee9bbe"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.4/hornbill-darwin-arm64"
      sha256 "0d0455e48e4b8d83bf2e5e6c12d4008f9a73522208bd46167c74c584cfca1ec0"
    else
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.4/hornbill-darwin-x64"
      sha256 "c72c5a51ff38df338fa94cddb946614afcc993bb389617972ca0c50dee1343fc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.4/hornbill-linux-arm64"
      sha256 "2ee281ecd4fc665413569e29cf8ec383436ae6aac65fe71a4e5b0a6e8126f6b7"
    else
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.4/hornbill-linux-x64"
      sha256 "0b1dc23f7aae4fdf972b2445a8ebbd8e117b769a8cd39824c8533db39eee9bbe"
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
