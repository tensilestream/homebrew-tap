class Yieldpoint < Formula
  desc "Deterministic verification for agents that write code"
  homepage "https://github.com/tensilestream/yieldpoint"
  url "https://github.com/tensilestream/yieldpoint/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "6620cc41a76a18c0381482cd5ec5883486931e80e368288357fbe5c436e2e7f6"
  license "BUSL-1.1"

  depends_on "python"

  def install
    libexec.install Dir["*"]
    (bin / "yieldpoint").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{libexec}:${PYTHONPATH:-}"
      exec "#{Formula["python"].opt_bin}/python3" -m yieldpoint "$@"
    EOS
    bin.install_symlink "yieldpoint" => "yp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/yieldpoint --version")
    assert_match "unverified", shell_output("#{bin}/yieldpoint check --path sample.py --before /dev/null --after /dev/null --json", 3)
    assert_match version.to_s, shell_output("#{bin}/yp --version")
  end
end
