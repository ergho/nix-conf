{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasPackage = name: lib.any (x: x == name) packageNames;
  hasEza = hasPackage "eza";

in
{
  home.packages = [ pkgs.bash-completion ];

  programs.fish = {
    enable = true;
    shellAbbrs = rec {
      jqless = "jq -C | less -r";
      ls = mkIf hasEza "eza";
      exa = ls;

    };

    functions = {
      fish_greeting = "";
    };
    interactiveShellInit = /* fish */ ''
      # Open command buffer in editor when alt+e is pressed
      bind \ee edit_command_buffer

      # Use terminal colors
      set -gx fish_color_autosuggestion      brblack
      set -gx fish_color_cancel              -r
      set -gx fish_color_command             brgreen
      set -gx fish_color_comment             brmagenta
      set -gx fish_color_cwd                 green
      set -gx fish_color_cwd_root            red
      set -gx fish_color_end                 brmagenta
      set -gx fish_color_error               brred
      set -gx fish_color_escape              brcyan
      set -gx fish_color_history_current     --bold
      set -gx fish_color_host                normal
      set -gx fish_color_host_remote         yellow
      set -gx fish_color_match               --background=brblue
      set -gx fish_color_normal              normal
      set -gx fish_color_operator            cyan
      set -gx fish_color_param               brblue
      set -gx fish_color_quote               yellow
      set -gx fish_color_redirection         bryellow
      set -gx fish_color_search_match        'bryellow' '--background=brblack'
      set -gx fish_color_selection           'white' '--bold' '--background=brblack'
      set -gx fish_color_status              red
      set -gx fish_color_user                brgreen
      set -gx fish_color_valid_path          --underline
      set -gx fish_pager_color_completion    normal
      set -gx fish_pager_color_description   yellow
      set -gx fish_pager_color_prefix        'white' '--bold' '--underline'
      set -gx fish_pager_color_progress      'brwhite' '--background=cyan'
    '';
  };
}
