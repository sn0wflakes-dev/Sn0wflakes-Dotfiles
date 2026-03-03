{config, pkgs, ... }:

{

  # basic user information
  home.username="sn0w";
  home.homeDirectory="/home/sn0w";
  home.stateVersion="25.05";

  nixpkgs.config.allowUnfree=true;

  programs.home-manager.enable=true;

  # Section 1
  # Used for common programs

  # Bash
  programs.bash = {
    enable = true;
    initExtra = ''
      # Load Oh My Posh
      eval "$(oh-my-posh init bash --config ${pkgs.oh-my-posh}/share/oh-my-posh/themes/space.omp.json)"

      # Load teamsfx-cli
      export PATH="/home/sn0w/.bun/bin:$PATH"

      # Show pretext only when using Kitty terminal
      if [[ "$TERM" == "xterm-kitty" ]]; then
        echo -e "\n$(cat ~/.config/kitty/pretext.txt)\n"
      fi
    '';
    shellAliases={
      clock="tty-clock -c -s -C 4";
    };
  };

  # Git
  programs.git={
    enable=true;
    lfs.enable = true;
    extraConfig={
      init.defaultBranch="main";
    };
    userEmail="abdurrahmanali.dev@gmail.com";
    userName="Abdurrahman ali";
  };

  # Waybar
  programs.waybar={
    enable=true;
  };

  programs.superfile={
    enable=true;
  };

  # Btop
  programs.btop={
    enable=true;
    settings={
      theme_background=false;
      color_theme="machiatto.theme";
    
    };

  };

  # Cava
  programs.cava={
    enable=true;
  };

  # Neovim
  programs.neovim={
    enable=true;

  };

  # Hyprpaper
  services.hyprpaper={
    enable=true;
    settings={
     ipc = "on";
     splash = false;
     splash_offset = 2.0;
     preload = [ 
       "$HOME/Pictures/Wallpaper/miku-and-flower.png"
     ];
     wallpaper = [
     "eDP-1,$HOME/Pictures/Wallpaper/miku-and-flower.png"
     "HDMI-A-1,$HOME/Pictures/Wallpaper/miku-and-flower.png"
     ];
    };
  };

  # Wofi
  programs.wofi={
    enable=true;
  };

  programs.kitty={
    enable=true;
    extraConfig=''
      background_opacity 0.9
    '';
    settings={
      window_padding_width=8;
    };
    themeFile="Catppuccin-Macchiato";
  };

  # Oh My Posh
  programs.oh-my-posh={
    enable=true;
    settings={
      builtins.fromJson=builtins.unsafeDiscardStringContext(
        builtins.readFile "${pkgs.oh-my-posh}/share/oh-my-posh/themes/space.omp.json"  
      );
    };
  };

  # Section 2
  # Used for development tools or programs


  # Bun, Javascript runtime
  programs.bun={
    enable=true;
  };

  programs.vscode={
    enable=true;

  };
}
