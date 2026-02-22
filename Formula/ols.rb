class Ols < Formula
  desc "Language server for the Odin programming language"
  homepage "https://github.com/DanielGavin/ols"
  url "https://github.com/DanielGavin/ols/archive/refs/tags/dev-2026-02.tar.gz"
  version "dev-2026-02"
  sha256 "cf374fc128dc76ef263366905a31802de3e1123ffdc27cf3cbe31249c641753c"
  license "MIT"

  depends_on "odin"

  def install
    system "odin", "build", "src/",
           "-collection:src=src",
           "-out:ols",
           "-no-bounds-check",
           "-o:speed",
           "-microarch:native",
           "-define:VERSION=#{version}"

    system "odin", "build", "tools/odinfmt/main.odin",
           "-file",
           "-collection:src=src",
           "-out:odinfmt",
           "-no-bounds-check",
           "-o:speed",
           "-microarch:native"

    bin.install "ols"
    bin.install "odinfmt"
    prefix.install "builtin"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ols --version 2>&1", 1)
  end
end
