{ pkgs, lib, ... }: with lib;
{
  boot.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "radeon.cik_support=0" "amdgpu.cik_support=1" ];

  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];

  hardware = {
    # amdgpu.amdvlk = {
    #   enable = true;
    #   support32Bit.enable = true;
    # };
    graphics = {
      enable32Bit = mkDefault true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };
  };
  environment = {
    systemPackages = with pkgs; [
      clinfo
    ];
    variables = {
      ROC_ENABLE_PRE_VEGA = "1";
    };
  };

}
