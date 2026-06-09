class HornbillCli < Formula
  desc "CLI client for Hornbill bill tracker"
  homepage "https://github.com/chickenzord/hornbill"
  version "0.1.3"
  license "AGPL-3.0-only"

  url "https://github.com/chickenzord/hornbill/releases/download/v0.1.3/hornbill-linux-x64"
  sha256 "fb95c637e392ec9bf016e21f65f874591a1426d5e0ea761f05ff3166f96793c7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.3/hornbill-darwin-arm64"
      sha256 "94ad5c911206ad08f2e2495649188df67db120bb903ef1f06984703f2612dc00"
    else
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.3/hornbill-darwin-x64"
      sha256 "1ff7405ad792186ba7f9b3fe6815af7f452b8a016110cb3cf04973794a2c26da"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.3/hornbill-linux-arm64"
      sha256 "f967a9a7a2ef84872367213f12e583bf76085788e292e585a906833ea464a4e2"
    else
      url "https://github.com/chickenzord/hornbill/releases/download/v0.1.3/hornbill-linux-x64"
      sha256 "fb95c637e392ec9bf016e21f65f874591a1426d5e0ea761f05ff3166f96793c7"
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
