{ pkgs, ... }:

let
  chromeIcon = "${pkgs.google-chrome}/share/icons/hicolor/128x128/apps/google-chrome.png";
in
{

  home.packages = with pkgs; [
    google-chrome
  ];

  xdg.desktopEntries = {
    chrome = {
      name = "Google Chrome (Wayland)";
      genericName = "Web Browser";
      exec = "google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland %U";
      terminal = false;
      icon = chromeIcon;
      categories = [
        "Application"
        "Network"
        "WebBrowser"
      ];
      mimeType = [
        "text/html"
        "text/xml"
      ];
    };
  };

}
