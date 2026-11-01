class Xkb < Formula
  desc "Spec splitter, conflict-aware kanban scheduler and two-stage verifier"
  homepage "https://github.com/ffqa/xkb"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ffqa/xkb/releases/download/v0.1.3/xkb-v0.1.3-darwin-arm64.tar.gz"
      sha256 "0e2dfeed361cff4656ec70db337e6c56a3dc96c178e88a6ed8fdef26c4945111"
    else
      url "https://github.com/ffqa/xkb/releases/download/v0.1.3/xkb-v0.1.3-darwin-amd64.tar.gz"
      sha256 "b409352bb460e1957f1f1cf0ccdd5164f4f791745f930df53d53ddc527cd56c6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ffqa/xkb/releases/download/v0.1.3/xkb-v0.1.3-linux-arm64.tar.gz"
      sha256 "7ae395c685a1aea6410a3dfe081eb102038a34b5519ca0d1b65fccd0211ab593"
    else
      url "https://github.com/ffqa/xkb/releases/download/v0.1.3/xkb-v0.1.3-linux-amd64.tar.gz"
      sha256 "ca499a106b0a16e5efba0c6b54aa916a19a6a7b381f02db009488f7ea7e5557b"
    end
  end

  def install
    bin.install "xkb"
  end


  service do
    run [opt_bin/"xkb", "server", "--port", "7790"]
    keep_alive true
    working_dir Dir.home
    environment_variables XKB_SERVICE: "1"
    log_path var/"log/xkb.log"
    error_log_path var/"log/xkb.log"
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
