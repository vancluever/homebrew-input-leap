class InputLeap < Formula
  desc "Open-source KVM software (formerly Barrier)"
  homepage "https://github.com/input-leap/input-leap"
  url "https://github.com/input-leap/input-leap.git", using: :git, revision: "6cfeacdfa00096cd8bdbecc95a4c1c9dc2cd2113"
  version "2.4.0-7+6cfeacd"
  license :cannot_represent

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on xcode: :build
  depends_on macos: :sierra
  depends_on "openssl"
  depends_on "qt@5"

  patch :DATA

  def install
    ENV["B_BUILD_TYPE"] = "Release"
    ENV["B_CMAKE_FLAGS"] = "-DINPUTLEAP_BUILD_TESTS=OFF"
    ENV["INPUTLEAP_BUILD_ENV"] = "1"
    system "./clean_build.sh"
    system "codesign", "--deep", "--force", "--sign", "-", "build/bundle/InputLeap.app"
    prefix.install "build/bundle/InputLeap.app"
    bin.install_symlink prefix/"InputLeap.app/Contents/MacOS/input-leapc"
    bin.install_symlink prefix/"InputLeap.app/Contents/MacOS/input-leaps"
    man.mkpath
    man1.install "doc/input-leapc.1"
    man1.install "doc/input-leaps.1"
    doc.install Dir["doc/*"]
  end

  def caveats
    <<~EOS
      You will need to access the InputLeap.app directly from:
        #{opt_prefix}/InputLeap.app

      Run this at least once to properly register accessibility
      permissions before using the CLI tools.

      If your run into an accessibility permissions loop, try
      running:
        tccutil reset Accessibility input-leap

      This will reset your accessibility permissions; running the app
      again should then correctly grant it.

      The command-line binaries input-leapc (client) and input-leaps
      (server) have been linked and should be available from your
      PATH.

      Man pages have also been installed, and you will be able to find
      config file examples in:
        #{HOMEBREW_PREFIX}/share/doc/input-leap
    EOS
  end

  test do
    # Test not implemented for the time being as we're likely not
    # sending this to homebrew-core. Official formula will likely be
    # a cask, similar to Barrier.
    system "false"
  end
end

__END__
diff --git a/dist/macos/bundle/build_dist.sh.in b/dist/macos/bundle/build_dist.sh.in
index 55610614..7ac2a247 100755
--- a/dist/macos/bundle/build_dist.sh.in
+++ b/dist/macos/bundle/build_dist.sh.in
@@ -37,19 +37,6 @@ cp -r "$B_BINDIR" "$B_MACOS" || exit 1
 
 DEPLOYQT=@QT_DEPLOY_TOOL@
 
-# Use macdeployqt to include libraries and create dmg
-if [ "$B_BUILDTYPE" = "Release" ]; then
-    info "Building Release disk image (dmg)"
-    "$DEPLOYQT" InputLeap.app -dmg \
-    -executable="$B_INPUTLEAPC" \
-    -executable="$B_INPUTLEAPS" || exit 1
-    mv "InputLeap.dmg" "InputLeap-$B_VERSION.dmg" || exit 1
-    success "Created InputLeap-$B_VERSION.dmg"
-else
-    warn "Disk image (dmg) only created for Release builds"
-    info "Building debug bundle"
-    "$DEPLOYQT" InputLeap.app -no-strip \
-    -executable="$B_INPUTLEAPC" \
-    -executable="$B_INPUTLEAPS" || exit 1
-    success "Bundle created successfully"
-fi
+info "Building app bundle"
+"$DEPLOYQT" InputLeap.app -executable="$B_INPUTLEAPC" -executable="$B_INPUTLEAPS" || exit 1
+success "Bundle created successfully"
