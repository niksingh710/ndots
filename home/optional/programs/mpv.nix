{ pkgs, ... }: {
  home.packages = with pkgs; [ ffmpegthumbnailer ];
  persist.dir = [ ".local/state/mpv" ];
  programs.mpv = {
    enable = true;
    package = pkgs.mpv;
    bindings = {
      h = "seek -5";
      l = "seek 5";
      j = "cycle sub";
      J = "cycle sub down";
      k = "cycle audio";
      K = "cycle audio down";
      H = "seek -60";
      L = "seek 60";
    };
    config = {
      save-position-on-quit = "yes";
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
