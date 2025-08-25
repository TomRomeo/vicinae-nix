{
  config,
  pkgs,
  lib,
  vicinae,
  ...
}:
let
  cfg = config.services.vicinae;
in {

  options.services.vicinae = {
    enable = lib.mkEnableOption "vicinae launcher daemon" // {default = true;};

    package = lib.mkOption {
      type = lib.types.package;
      default = vicinae;
      defaultText = lib.literalExpression "vicinae";
      description = "The vicinae package to use";
    };

    autoStart = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "If the vicinae daemon should be started automatically";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    systemd.user.services.vicinae = {
      Unit = {
        Description = "Vicinae server daemon";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${cfg.package}/bin/vicinae server";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install = lib.mkIf cfg.autoStart {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
