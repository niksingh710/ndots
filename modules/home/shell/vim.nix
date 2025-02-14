{
  programs.vim = {
    # Basic Vim Config (will be overridden by my editor)
    # Still here if only shell initialization is needed
    enable = true;
    defaultEditor = true;
    settings = {
      background = "dark";
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      smartcase = true;
      ignorecase = true;
      undofile = true;
      number = true;
      relativenumber = true;
    };
    extraConfig = # vim
      ''
        set clipboard=unnamedplus
        set autoindent
        syntax on
        let g:mapleader=" "

        imap <silent> jk <esc>
        imap <c-s> <esc>:w!<cr>

        nmap <c-s> :w!<cr>
        nmap <leader>q :q!<cr>
      '';
  };

}
