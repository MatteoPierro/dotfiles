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
      "chatgpt"
      "copilot-cli"
      "github-copilot-app"
      "miro"
    ];
  };
}