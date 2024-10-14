{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "timetable";
      bashOptions = [ "pipefail" ];
      runtimeInputs = [ pkgs.wkhtmltopdf pkgs.zathura ];
      text = ''
        echo ".navbar { display: none; }" >/tmp/gbu-remove.css

        wkhtmltopdf --user-style-sheet "/tmp/gbu-remove.css" --page-size A4 --orientation Landscape "https://mygbu.in/schd/?name=SOICT&dept=CSE&section=31" /tmp/gbu-tt.pdf &>/dev/null
        setsid zathura /tmp/gbu-tt.pdf &>/dev/null
      '';
    })
  ];
}
