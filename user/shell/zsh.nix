{pkgs , ...}:

let
	aliases = {
		cat = "bat";
		htop = "btop";
		nxbuild = "sudo nixos-rebuild switch --flake ~/nixos-config/.#vm";
		nxtest = "sudo nixos-rebuild test --flake ~/nixos-config/.#vm";
		vim = "nvim";
	};

in {
	home.packages = [pkgs.zsh];
	programs.zsh = {
		enable = true;
		#autosuggestion.enable=true;
		syntaxHighlighting.enable = true;
		enableCompletion = true;
		shellAliases = aliases;
		oh-my-zsh={
			enable=true;
			theme = "fino";
		};
	};
}
