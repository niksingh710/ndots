{ opts, ... }: {
  programs = {
    lazygit.enable = true;
    gh = {
      enable = true;
      settings.editor = "vim";
      settings.git_protocol =
        "https"; # NOTE: :( Have to use this till under my College Network
    };
    git = {
      enable = true;
      userName = "${opts.username}";
      userEmail = "${opts.mail}";

      extraConfig = {
        init.defaultBranch = "master";
        core.editor = "vim";
        alias = { blame = "blame -w -C -C -C"; };
        diff = {
          tool = "nvim -d";
          colorMoved = "default";
        };
        format = {
          pretty =
            "format:%C(yellow)%h%Creset -%C(red)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset";
        };
        merge = { conflictstyle = "diff3"; };
        pull = { rebase = true; };
        push = { default = "simple"; };

        rerere = {
          enabled = true;
          autoUpdate = true;
        };

      };
    };
  };
}
