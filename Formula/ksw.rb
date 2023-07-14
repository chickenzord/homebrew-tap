# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Ksw < Formula
  desc "Switch Kubeconfig context in new shell"
  homepage ""
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/chickenzord/ksw/releases/download/v0.1.1/ksw_Darwin_x86_64.tar.gz", using: CurlDownloadStrategy
      sha256 "88af5b289cc6c7e5a44db5c582fd93f6c25239ced36b62e562c1c74ac07cb1a3"

      def install
        bin.install "ksw"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/chickenzord/ksw/releases/download/v0.1.1/ksw_Darwin_arm64.tar.gz", using: CurlDownloadStrategy
      sha256 "e880396f03b35ef44e2d21aa2563ff78c699b97b6215b707e2b4a842e204d6cd"

      def install
        bin.install "ksw"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/chickenzord/ksw/releases/download/v0.1.1/ksw_Linux_arm64.tar.gz", using: CurlDownloadStrategy
      sha256 "4f8babb5a9b30124ffda3fb7c4e9b8fb886194c9798fb2ce66a92e670f5a92bb"

      def install
        bin.install "ksw"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/chickenzord/ksw/releases/download/v0.1.1/ksw_Linux_x86_64.tar.gz", using: CurlDownloadStrategy
      sha256 "b79b90e658eb4f83cbae344c33aa5a37bd565fad4c9c1eb18f460a7525b667cf"

      def install
        bin.install "ksw"
      end
    end
  end
end
