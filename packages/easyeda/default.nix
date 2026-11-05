{ pkgs, ... }:

let
  easyedaFiles = pkgs.fetchzip {
    url = "https://image.easyeda.com/files/easyeda-linux-x64-6.5.61.zip";
    hash = "sha256-h0CuCL03ExW/yTV4ILIThvei0usEZL+mNkRu5tjc4iY=";
    extension = "zip";
    stripRoot = false;
  };

  launcher = pkgs.writeShellScript "easyeda-launcher" ''
    cd ${easyedaFiles}/easyeda-linux-x64
    exec ${easyedaFiles}/easyeda-linux-x64/easyeda "$@"
  '';

  fhsEnv = pkgs.buildFHSEnv {
    name = "easyeda";

    targetPkgs = pkgs: with pkgs; [
      # Core libraries
      glib
      glibc
      stdenv.cc.cc.lib
      zlib
      expat

      # GTK / accessibility
      gtk3
      atk
      at-spi2-atk
      at-spi2-core
      pango
      cairo
      gdk-pixbuf

      # Fonts
      fontconfig
      freetype

      # Chromium / Electron
      nss
      nspr
      dbus
      cups
      libsecret
      udev

      # Graphics
      libGL
      libglvnd
      libdrm
      mesa
      libgbm      # libgbm.so.1 moved out of `mesa` into its own package

      # X11
      libx11
      libxcomposite
      libxdamage
      libxext
      libxfixes
      libxrandr
      libxcb
      libxcursor
      libxi
      libxrender
      libxtst
      libxscrnsaver
      libxshmfence
      libxkbcommon

      # Audio
      alsa-lib
    ];

    runScript = "${launcher}";
  };

  desktopItem = pkgs.makeDesktopItem {
    name = "easyeda";
    desktopName = "EasyEDA";
    genericName = "PCB Design Tool";
    comment = "Schematic capture and PCB layout";
    exec = "easyeda %U";
    icon = "easyeda";
    terminal = false;
    categories = [ "Development" "Electronics" "Engineering" ];
    keywords = [ "EDA" "PCB" "schematic" "circuit" "electronics" ];
    startupWMClass = "easyeda";
  };

in
pkgs.symlinkJoin {
  name = "easyeda-with-desktop";

  paths = [ fhsEnv desktopItem ];

  postBuild = ''
    for size in 16 32 128 256 512; do
      dir="$out/share/icons/hicolor/''${size}x''${size}/apps"
      mkdir -p "$dir"
      ln -s ${easyedaFiles}/easyeda-linux-x64/icon/icon_''${size}x''${size}.png \
        "$dir/easyeda.png"
    done
  '';

  meta = {
    description = "EasyEDA standalone client (FHS-wrapped)";
    mainProgram = "easyeda";
    platforms = [ "x86_64-linux" ];
  };
}
