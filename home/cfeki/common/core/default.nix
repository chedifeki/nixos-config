{lib, inputs,pkgs, upkgs, ...}:


let 
	nixvim = inputs.nixvim;
in {
	imports = [
		nixvim.homeManagerModules.nixvim
		./nvim.nix
		./zsh.nix
	];
	home = {
		username = "cfeki";
		homeDirectory = lib.mkDefault "/home/cfeki/";
		sessionVariables={ 
			SHELL = "zsh";
			TERMINAL = "alacritty";
			EDITOR = "nvim";
		};
		
		# Packages that don't have a special config go here!
		packages= (with pkgs;[
			#stable
			alacritty
			zellij
			reaper

		]) ++ (with upkgs; [
			#unstable
			kdePackages.plasmatube
			obsidian
			brave
		]); 
			

		#########################################
		stateVersion="23.11"; # don't change this
 	};

	programs = {
		home-manager.enable =true;
	};
	
}
