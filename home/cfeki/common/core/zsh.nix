{pkgs , ...}:

let
	aliases = {
		cat = "bat";
		htop = "btop";
		top = "btop";
		nxbuild = "sudo nixos-rebuild switch --flake ~/nixos-config/.#vmlab";
		nxtest = "sudo nixos-rebuild test --flake ~/nixos-config/.#vmlab ";
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
