{ pkgs, ... }: {
  home.packages = with pkgs; [ ffmpegthumbnailer ];
  persist.dir = [ ".local/state/mpv" ];
  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto-safe";
      vo = "gpu";
      osc = "no";
      border = "no";
      profile = "gpu-hq";
      gpu-context = "wayland";
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "video/mp4" = "mpv.desktop";
    "video/x-matroska" = "mpv.desktop";
    "video/webm" = "mpv.desktop";
    "video/quicktime" = "mpv.desktop";
    "video/x-msvideo" = "mpv.desktop";
    "video/x-ms-wmv" = "mpv.desktop";
    "video/x-flv" = "mpv.desktop";
    "video/x-m4v" = "mpv.desktop";
    "video/3gpp" = "mpv.desktop";
    "video/3gpp2" = "mpv.desktop";
    "video/x-matroska-3d" = "mpv.desktop";
    "video/x-ms-asf" = "mpv.desktop";
    "video/x-ms-wvx" = "mpv.desktop";
    "video/x-ms-wmx" = "mpv.desktop";
    "video/x-ms-wm" = "mpv.desktop";
    "video/x-ms-wmp" = "mpv.desktop";
    "video/x-ms-wmz" = "mpv.desktop";
  };
}
