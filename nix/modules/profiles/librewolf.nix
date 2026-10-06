{ lib, pkgs, ... }:
{
  programs.librewolf = {
    enable = true;

    profiles.personal = {
      id = 0;
      isDefault = true;
      settings."extensions.autoDisableScopes" = 0;

      search = {
        force = true;
        default = "qwant";
        privateDefault = "qwant";
        order = [ "qwant" ];
        engines.qwant = {
          name = "Qwant";
          urls = [
            {
              template = "https://www.qwant.com/";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }
          ];
          definedAliases = [ "@qwant" ];
        };
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        languagetool
        bitwarden
        ghostery
        keepa
        noscript
        (buildFirefoxXpiAddon {
          pname = "popupoff";
          version = "2.1.3";
          addonId = "{154cddeb-4c8b-4627-a478-c7e5b427ffdf}";
          url = "https://addons.mozilla.org/firefox/downloads/file/4150911/popupoff-2.1.3.xpi";
          sha256 = "sha256-0arPSC56m0+0tGXkASgtWiaEnMu5U2ynwO/j9ekO+Ls=";
          meta.platforms = lib.platforms.all;
        })
      ];
    };
  };
}