# typed: false
# frozen_string_literal: true

class KswHead < Formula
  desc "Switch Kubeconfig context in new shell (HEAD formula)"
  homepage "https://github.com/chickenzord/ksw"
  license "MIT"

  head "https://github.com/chickenzord/ksw.git", branch: "main"

  depends_on "go" => :build
  conflicts_with "ksw"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end
end
