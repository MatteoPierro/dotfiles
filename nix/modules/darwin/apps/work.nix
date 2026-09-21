{ ... }:
{
  homebrew = {
    taps = [
      "datadog-labs/pack"
    ];

    brews = [
      "datadog-labs/pack/pup"
    ];

    casks = [
      "1password"
      "chatgpt"
      "codex-app"
      "copilot-cli"
      "github-copilot-app"
      "miro"
    ];
  };
}