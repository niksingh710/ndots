{
  services.espanso = {
    enable = true;

    matches = {
      base = {
        matches = [
          {
            trigger = ":now";
            replace = "It's {{currentdate}} {{currenttime}}";
          }
          {
            trigger = ":omh";
            replace = ''
              ```
              curl --proto '=https' --tlsv1.2 -sSf -L https://juspay.github.io/nixone/health | sh -s
              ```
            '';
          }
        ];
      };
      global_vars = {
        global_vars = [
          {
            name = "currentdate";
            type = "date";
            params = { format = "%d/%m/%Y"; };
          }
          {
            name = "currenttime";
            type = "date";
            params = { format = "%R"; };
          }
        ];
      };
    };
  };
}
