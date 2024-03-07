{ self, config, pkgs, makeMutableSymlink, ... }: {
  home.packages = with pkgs; [ fd wget ripgrep kitty brave discord spotify ];

  home.file = {
    # Scripts
    "scripts".source =
      config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/scripts";
    "wallpapers".source =
      config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/wallpapers";
    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/nvim";
    ".config/kitty".source =
      config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/kitty";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      if test -z (pgrep ssh-agent | string collect)
        eval (ssh-agent -c) > /dev/null
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
      end

      function fish_user_key_bindings
        bind \cf '~/scripts/tmux-sessionizer.sh'
        bind \cgw 'bass source ~/scripts/wts.sh'
      end
    '';
    shellAliases = {
      hms = "home-manager switch --flake ~/.dotfiles#frans@homenix";
      nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles#homenix";
      wtc = "~/scripts/wtc.sh";
    };
    plugins = [{
      name = "bass";
      src = pkgs.fishPlugins.bass.src;
    }];
  };

  programs.git = {
    enable = true;
    userName = "Frans Paasonen";
    userEmail = "franspaasonen@gmail.com";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-custom-linux;
    extraPackages = with pkgs; [
      stylua
      nixfmt
      rnix-lsp
      sumneko-lua-language-server
    ];
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    sensibleOnTop = true;
    escapeTime = 0;
    keyMode = "vi";
    extraConfig = ''
      set -g status off
      set -s set-clipboard external
      set-option -g default-terminal "screen-256color"
      set-option -sa terminal-features ',xterm-kitty:RGB'

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"

      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R

      bind -n 'M-h' if-shell "$is_vim" 'send-keys M-h' 'resize-pane -L 1'
      bind -n 'M-j' if-shell "$is_vim" 'send-keys M-j' 'resize-pane -D 1'
      bind -n 'M-k' if-shell "$is_vim" 'send-keys M-k' 'resize-pane -U 1'
      bind -n 'M-l' if-shell "$is_vim" 'send-keys M-l' 'resize-pane -R 1'

      bind-key -T copy-mode-vi M-h resize-pane -L 1
      bind-key -T copy-mode-vi M-j resize-pane -D 1
      bind-key -T copy-mode-vi M-k resize-pane -U 1
      bind-key -T copy-mode-vi M-l resize-pane -R 1
    '';
  };

  programs.obs-studio.enable = true;
}
