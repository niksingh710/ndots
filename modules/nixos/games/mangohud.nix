{ pkgs, lib, ... }: with lib;
{
  options.nmod.games.mangohud.enable = lib.mkEnableOption "Enable MangoHud";
  config = {
    environment.systemPackages = with pkgs; [
      mangohud
    ];
    hm.home.file.".config/MangoHud/MangoHud.conf".text = /* conf */ ''
        toggle_fps_limit=F1

        legacy_layout=false
        gpu_temp
        gpu_power
        gpu_text=GPU
        cpu_stats
        cpu_temp
        cpu_power
        cpu_mhz
        cpu_text=CPU
        vram
        ram
        fps
        gpu_name
        vulkan_driver
        frame_timing=0
        resolution
        background_alpha=0.4
        font_size=24

        position=top-left
    '';
  };
}
