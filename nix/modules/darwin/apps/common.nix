{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [ "agavra/tap" ];

    brews = [
      "agavra/tap/tuicr"
      "defaultbrowser"
    ];

    casks = [
      "bose-updater"
      "caffeine"
      "jumpcut"
      "logi-options+"
      "logitune"
      "notion"
      "tableplus"
    ];
  };
}