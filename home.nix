{config, pkgs, pkgs-unstable, userSettings, nixvim, ...}: 
{

	imports = [
		./user/shell/zsh.nix
		nixvim.homeManagerModules.nixvim
		./user/app/nvim.nix
	];
	home = {
		stateVersion="23.11"; # don't change this
		username = userSettings.user;
		homeDirectory = "/home/"+userSettings.user;
		packages= (with pkgs;[
			#stable
			nano
			kate
			gwenview
			dolphin
			alacritty
			zellij

		]) ++ (with pkgs-unstable; [
			#unstable
			obsidian
			brave
		]); 
 	};

	programs = {
		home-manager.enable =true;
	};
	
	

}
