{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    anki-bin
    bun
    spotify
    clang
    clang-tools
    glibc.dev
    rustup
    git
    gh
    lazygit
    vim
    neovim
    openjdk21
    dbeaver-bin
    shotcut
    meld
    vscode
    nodejs
    pnpm
    networkmanager
    pcmanfm
    pavucontrol
    blueman
    bluetooth_battery
    nh
    solaar
    usbutils
    libnotify
    lxappearance
    gcc
    gnumake
    cmake
    ninja
    meson
    wget
    unzip
    eza
    zoxide
    tmux
  ];
}
