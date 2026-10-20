{
  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
    # Add your custom initialization code here
    interactiveShellInit = ''
      # Automatically source project-specific Fish files passed by direnv
      function auto_source_project_fish --on-variable SOURCE_FISH_FILE
          if test -n "$SOURCE_FISH_FILE"; and test -f "$SOURCE_FISH_FILE"
              source "$SOURCE_FISH_FILE"
          end
      end
    '';
  };
}
