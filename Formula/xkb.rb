class Xkb < Formula
  desc "Spec splitter, conflict-aware kanban scheduler and two-stage verifier"
  homepage "https://github.com/ffqa/xkb"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ffqa/xkb/releases/download/v0.1.0/xkb-v0.1.0-darwin-arm64.tar.gz"
      sha256 "ba5eddc32b7fe12d99e2aa781b7c8daf4fac09bee3e0a916ab6fd45afad2625f"
    else
      url "https://github.com/ffqa/xkb/releases/download/v0.1.0/xkb-v0.1.0-darwin-amd64.tar.gz"
      sha256 "d459917a978f3b2609d2208cdfcec31038542a2df935f5b5385f259b1ae8bfc6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ffqa/xkb/releases/download/v0.1.0/xkb-v0.1.0-linux-arm64.tar.gz"
      sha256 "dd44ea9a26b517912d2044083a278571f292d01fa25b4070cc584178419a8889"
    else
      url "https://github.com/ffqa/xkb/releases/download/v0.1.0/xkb-v0.1.0-linux-amd64.tar.gz"
      sha256 "bf1f9776ee5b570bc564d6ef76e1e99fb9ecb89c3651978ee95e345cb9b06a2a"
    end
  end

  def install
    bin.install "xkb"
  end

  def caveats
    <<~EOS
      启动常驻调度与 HTTP/SSE 服务:
        xkb server --port 7790

      终端看板:
        xkb
    EOS
  end

  test do
    assert_match "xkb", shell_output("#{bin}/xkb version")
  end
end
