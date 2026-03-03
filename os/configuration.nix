# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
 
  hardware.enableRedistributableFirmware=true;

  # Update kernel
  boot.kernelPackages=pkgs.linuxPackages_latest;

  # Mount windows filesystem
  fileSystems."/home/sn0w/Windows"={
    device="/dev/nvme0n1p3";
    fsType="ntfs-3g";
  };

  # Activate flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.android_sdk.accept_license = true;

  # Service audio
  services.pulseaudio.enable=false;
  services.pipewire={
    enable=true;
    alsa.support32Bit=true;
    pulse.enable=true;
    jack.enable=true;
  };

  # hardware bluetooth
  hardware.bluetooth={
    enable=true;
    powerOnBoot=true;
  };

  services.blueman={
    enable=true;

  };

  virtualisation.containers.enable = true;

  # Enable xdg portal for hyprland
  programs.hyprland.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true; 
  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.dns="none";
  networking.nameservers=["8.8.8.8" "1.1.1.1"];
  services.tailscale.enable=true;

  # Enable all firmware
  hardware.enableAllFirmware=true;
  

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Docker
  virtualisation.docker.enable = true; 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sn0w = {
    isNormalUser = true;
    description = "sn0w";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Mtp service
  services.udev.packages = [ pkgs.libmtp.out ];
  programs.fuse.userAllowOther = true;
  services.gvfs.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    spotify
    nodejs
    gcc
    clang
    clang-tools
    jetbrains-toolbox
    unzip
    grimblast
    hyprcursor
    catppuccin-cursors.macchiatoBlue
    lsd
    mpv
    vscode
    dunst
    libnotify
    hyprpaper
    ripgrep
    pulseaudio
    playerctl
    neofetch
    postman
    dotnetCorePackages.sdk_9_0
    obsidian
    unzip
    maven
    libreoffice
    thunderbird
    unzip
    spring-boot-cli
    ngrok
    telegram-desktop
    remmina
    zoom-us
    ccls
    cmake
    wl-clipboard
    calibre
    wireshark-qt
    python312
    python312Packages.uv
    scrcpy
    ntfs3g
    android-file-transfer
    gparted
    kdePackages.dolphin
    papirus-icon-theme
    glib
    qt6ct
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    cloudflared
    kdePackages.qtsvg
    kdePackages.ffmpegthumbs
    kdePackages.kio-extras
    kdePackages.kdegraphics-thumbnailers
    kdePackages.qtstyleplugin-kvantum
    kdePackages.kio
    kdePackages.kio-fuse
    mtpfs
    libmtp
    tailscale
    wireplumber
    obs-studio
    tty-clock
    p7zip
    google-chrome
    discord
    zip
    kdePackages.kdeconnect-kde
    kdePackages.plasma-workspace
    visualvm
    rustup
    busybox
    pavucontrol
    cmatrix
    go
    tomcat11
    realvnc-vnc-viewer
    dbeaver-bin
    android-studio-full
    mongodb-compass
  ];

  services.openssh.enable=true;

  fonts.packages = with pkgs; [nerd-fonts.fira-code];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # environment.sessionVariables = {
  # TZ = "Asia/Jakarta";
  #
  # };

  # environment.variables={
  #   WILDFLY_HOME="$HOME/Wildfly";
  #   JAVA_HOME="$HOME/Java/Java_21";
  #
  #   PATH=[
  #     "$HOME/Wildfly/bin"
  #     "$HOME/Java/Java_21/bin"
  #   ];
  # };

  # environment.variables={
  #   JAVA_HOME="$HOME/Java/Java_21";
  #   PATH=["$HOME/Java/Java_21/bin"];
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # JAR Application wrapper
  # systemd.services.ivrgateway={
  #   description="IVR Gateway Maybank - Dev";
  #   wantedBy=["multi-user.target"];
  #   after=["network.target"];
  #
  #   serviceConfig={
  #     ExecStart="${pkgs.jdk21}/bin/java -jar /home/sn0w/Development/Maybank/IvrGatewayMaybank-1.0.0-REST.jar";
  #     Restart="on-failure";
  #     RestartSec=2;
  #   };
  #
  # };
  #
  # services.tomcat={
  #   enable=true;
  #   port=8080;
  #   package=pkgs.tomcat11;
  #   webapps = [];
  #   commonLibs = [];
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
