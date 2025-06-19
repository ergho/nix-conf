{ pkgs, inputs, system, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.ergho = {
      search = {
        force = true;
	default = "ddg";
	engines = {
	  bing.metaData.hidden = true;
	};
      };
      extension.packages = with pkgs.inputs.firefox-addons; [
        ublock-origin
      ];
    };
  };
}
