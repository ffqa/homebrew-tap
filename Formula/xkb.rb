class Xkb < Formula
  desc "Spec splitter, conflict-aware kanban scheduler and two-stage verifier"
  homepage "https://github.com/ffqa/xkb"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ffqa/xkb/releases/download/v0.1.4/xkb-v0.1.4-darwin-arm64.tar.gz"
      sha256 "03d0b48620976a79c5264bc45c4e533d10bd1e45e8a74613382acbdae49539c5"
    else
      url "https://github.com/ffqa/xkb/releases/download/v0.1.4/xkb-v0.1.4-darwin-amd64.tar.gz"
      sha256 "2cad32b08a7a81004557bae6d0c6e86745a7a32fb17d4a039e5be9f1cbf946db"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ffqa/xkb/releases/download/v0.1.4/xkb-v0.1.4-linux-arm64.tar.gz"
      sha256 "ef0c51c54674b1b37d67ea565bc0d4a1cf045671c66051b46af07a6dbc5f8f6d"
    else
      url "https://github.com/ffqa/xkb/releases/download/v0.1.4/xkb-v0.1.4-linux-amd64.tar.gz"
      sha256 "0dbfb78d3bec5c9544f39b3ff3a1c6ce68afccfb2dda5948d9d246da48ac0ea3"
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
