{ pkgs, inputs, system, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.ergho = {
      search = {
        force = true;
	default = "ddg";
	engines = {
	  bind.metaData.hidden = true;
	};
      };
    };
  };
}
