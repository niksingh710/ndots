{ pkgs, inputs, ... }: {
  home.packages = with pkgs;[
    taskwarrior3
    inputs.syncall.packages.${pkgs.system}
  ];
}
