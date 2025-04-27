{ inputs, ... }:
(next: prev: {
  stable = import inputs.nixpkgs-stable {
    # This allows me to use `pkgs.stable`
    inherit (prev) system;
    config.allowUnfree = true;
  };
  tmux = prev.tmux.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [ ./patches/tmux-pr-4364.sixel.patch ];
  });
  google-chrome = prev.google-chrome.override {
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };

  materialgram = (
    prev.symlinkJoin {
      name = "materialgram";
      paths = [ prev.materialgram ];
      buildInputs = [ prev.makeWrapper ];
      postBuild = ''
        wrapProgram "$out/bin/materialgram"--run "export XDG_CURRENT_DESKTOP=gnome"
      '';
    }
  );
  telegram-desktop = (
    prev.symlinkJoin {
      name = "materialgram";
      paths = [ prev.telegram-desktop ];
      buildInputs = [ prev.makeWrapper ];
      postBuild = ''
        wrapProgram "$out/bin/telegram-desktop" --run "export XDG_CURRENT_DESKTOP=gnome"
      '';
    }
  );

})
