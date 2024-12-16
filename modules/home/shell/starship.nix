{
  programs.starship = {
    enable = true;
    enableTransience = true;
  };
  home.file.".config/starship.toml".text = # toml
    ''
      format = """
      ''${custom.dir}\
      ''${custom.home_dir}\
      $directory\
      ''${custom.file_number}\
      ''${custom.folder_number}\
      ''${custom.df}\
      ''${custom.git_host}\
      $git_branch\
      $git_commit\
      $git_state\
      $git_status\
      ''${custom.lastcommit}\
      $all\
      $character
      """

      continuation_prompt = '▶▶ '

      scan_timeout = 10

      add_newline = false

      [battery]
      disabled = true

      [character]
      vimcmd_symbol = "[](bold-blue)"
      success_symbol = "[󰘧](bold-green)"
      error_symbol = "[](bold-red)"
      # disabled = true

      [directory]
      truncation_length = 1
      style = "fg:white bg:black bold"
      read_only_style = "fg:white bg:black bold"
      format = "[ $path ]($style)[$read_only]($read_only_style)"
      read_only = "  "

      [directory.substitutions]
      '~/Downloads' = "Downloads  "
      '~/Documents' = "Documents  "
      '~/Music' = "Music  "
      '~/Pictures' = "Pictures  "
      '~/Videos' = "Videos  "
      '~/Desktop' = "Desktop  "
      '~/Projects' = "Projects  "
      '~/Games' = "Games  "

      [custom.home_dir]
      command = "echo  "
      when = '[ "$PWD" == "$HOME" ]'
      shell = ["bash","--norc","--noprofile"]
      style = "fg:bright-blue bg:black"
      format = "[$output]($style)"

      [custom.dir]
      command = "echo  "
      when = '[ "$PWD" != "$HOME" ]'
      shell = ["bash","--norc","--noprofile"]
      style = "fg:bright-blue bg:black"
      format = "[$output]($style)"

      [cmd_duration]
      show_notifications = false
      min_time_to_notify = 60_000

      [lua]
      symbol=" "

      [git_branch]
      format = ":[$symbol$branch]($style)"
      symbol = " "

      [git_state]
      format = '\(:[$state( $progress_current/$progress_total)]($style)\)'

      [git_status]
      format = '(:[$all_status$ahead_behind]($style)) '
      conflicted = '\[ [$count](bright-white bold)\]'
      ahead = '\[[ ](bright-blue)[$count](bright-white bold)\]'
      behind = '\[[ ](white)[$count](bright-white bold)\]'
      diverged = '\[[ ](purple)|[ 󱡷 ](bright-blue)[$ahead_count](bright-white bold)[ 󱡷 ](white)[$behind_count](bright-white)\]'
      untracked = '\[ [$count](bright-white bold)\]'
      stashed = '\[[󰃖 ](yellow) [$count](bright-white bold)\]'
      modified = '\[[ ](bright-yellow)[$count](bright-white bold)\]'
      staged = '\[[✓ ](bright-green)[$count](bright-white bold)\]'
      renamed = '\[[ ](bright-cyan) [$count](bright-white bold)\]'
      deleted = '\[ [$count](bright-white bold)\]'

      [python]
      format = 'via [''${symbol}''${pyenv_prefix}(''${version} )(\($virtualenv\) )]($style)'

      [custom.git_host]
      command = """
      URL=$(command git ls-remote --get-url 2> /dev/null)

      if [[ "$URL" =~ "github" ]]; then
          ICON=" "
      elif [[ "$URL" =~ "gitlab" ]]; then
          ICON=" "
      elif [[ "$URL" =~ "bitbucket" ]];then
          ICON=" "
      elif [[ "$URL" =~ "kernel" ]];then
          ICON=" "
      elif [[ "$URL" =~ "archlinux" ]];then
          ICON=" "
      elif [[ "$URL" =~ "gnu" ]];then
          ICON=" "
      elif [[ "$URL" =~ "git" ]];then
          ICON=" "
      else
          ICON=" "
          URL="localhost"
      fi

      for PATTERN in "https" "http" "git" "://" "@"; do
          [[ "$URL" == "$PATTERN"* ]] && URL="''${URL##$PATTERN}"
      done

      for PATTERN in "/" ".git"; do
          [[ "$URL" == *"$PATTERN" ]] && URL="''${URL%%$PATTERN}"
      done
      printf "%s%s" "$ICON" "$URL"
      """

      directories = [".git"]
      when = 'git rev-parse --is-inside-work-tree 2> /dev/null'
      shell = ["bash","--norc","--noprofile"]
      style = "bright-yellow bold"
      format = "[$output]($style)"

      [hostname]
      ssh_only = true
      format = '$ssh_symbol$hostname'

      [custom.lastcommit]
      description = "Display last commit hash and message"
      command = "git show -s --format='%h \"%s\"'"
      when = 'git rev-parse --is-inside-work-tree 2> /dev/null'
      style = "#fd9f9f bold"
      format = '\([$output]($style)\) '
      # TODO: fix heuristic
      [nix_shell]
      impure_msg = '[❄️ impure shell](bold red)'
      pure_msg = '[❄️ pure shell](bold green)'
      unknown_msg = '[](bold yellow)'
      format = '[$state( \($name\))](bold blue) '
      heuristic = true

      [custom.df]
      command = 'df -h --output=avail "$PWD" | tail -n 1'
      when = "true"
      shell = ["bash", "--noprofile", "--norc"]
      symbol = ""
      format = "[$symbol ($output)]($style) "
      style = "bright-blue"
      disabled = true # disable because of rclone mount

      [custom.file_number]
      command = "find . -maxdepth 1 ''\( -type f -o -type l ''\) -not -name '.DS_Store' | wc -l"
      when = "exit 0" # run always
      symbol = " "
      description = "Number of files in the current working directory"
      format = '[$symbol$output]($style)'
      style = "fg:white bg:black bold"

      [custom.folder_number]
      command = "echo \"$(find . -maxdepth 1 -type d -not -name '.git' -not -name '.' | wc -l)\""
      when = "exit 0"
      symbol = "  "
      description = "Number of folders in the current working directory"
      format = '[$symbol$output]($style) '
      style = "fg:white bg:black bold"
    '';
}
