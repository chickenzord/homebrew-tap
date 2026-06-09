class HornbillCli < Formula
  desc "CLI client for Hornbill bill tracker"
  homepage "https://github.com/chickenzord/hornbill"
  version "0.1.2"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.2/hornbill-darwin-arm64"
      sha256 "35a9f00393203afe639243de13cf8799d4dd2c639d0f4a0acf579b8308785984"
    else
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.2/hornbill-darwin-x64"
      sha256 "6496cec2395dc313e5aa37f420f6051533bc503ddf211fdcd0a86c228900d0b1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.2/hornbill-linux-arm64"
      sha256 "5f6c4cf7c4b77ee3a0553908b220b5d9f641740d8caf337d2528ab8fae7ee819"
    else
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.2/hornbill-linux-x64"
      sha256 "1f48690db799dec2707dc6330dc144f73dcb090b486a1af83d734321447d18d1"
    end
  end

  url "https://github.com/chickenzord/hornbill/releases/download/v0.1.2/hornbill-linux-x64"
  sha256 "1f48690db799dec2707dc6330dc144f73dcb090b486a1af83d734321447d18d1"

  head "https://github.com/chickenzord/hornbill.git", branch: "main"

  depends_on "bun" => :build if build.head?

  def install
    if build.head?
      system "bun", "install"
      system "bun", "run", "--cwd", "packages/cli", "build"
      bin.install "packages/cli/bin/hornbill"
    else
      binary_name = if OS.mac?
        Hardware::CPU.arm? ? "hornbill-darwin-arm64" : "hornbill-darwin-x64"
      else
        Hardware::CPU.arm? ? "hornbill-linux-arm64" : "hornbill-linux-x64"
      end
      bin.install binary_name => "hornbill"
    end
  end

  test do
    system "#{bin}/hornbill", "--help"
  end
end
