################################################
####  Configuration for host                ####
####        Dragon -- MSI personal computer ####
################################################
{ config, pkgs, pkgs-unstable, userSettings, systemSettings, ... }:

let 
	user = userSettings.user;
		 
in 
{		
	imports = [
		### Mandatory Imports ####
		./hardware-configuration.nix    
		./host/common/core

		####       Users 		  ####
		./host/user/cfeki.nix
		
		####     Optional     ####	
		
		];
	
	# Bootloader
	boot.loader.grub = {
		enable = true;
		device = "/dev/sda";
		useOSProber = true;
		};
	
	# Network management 
	networking= {
		hostName = "dragon";
		networkmanager.enable = true;
		# wireless.enable = true;  # Enables wireless support via wpa_supplicant.
		# proxy = {   # configure proxy if necessary
		#		default = "http://user:password@proxy:port/";
		#		noProxy = "127.0.0.1,localhost,internal.domain;
		#};
	}; 
	
	# Set your time zone.
	time.timeZone = systemSettings.timezone;
	
	# Select internationalisation properties.
	i18n.defaultLocale = systemSettings.locale;
	
	# Configure console keymap
	console.keyMap = systemSettings.layout;
	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.${user}= {
		isNormalUser = true;
		description = userSettings.name;
		extraGroups = [ "networkmanager" "wheel" ];
	};
	
	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	environment = {		
		systemPackages = (with pkgs; [
			bat
			btop
			fzf
			git
			lf
			powertop
			tldr
			wget
		])  ++ (with pkgs-unstable; [
				# unstable packages here
		]);
	};

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment
	
	nix = {
		package = pkgs.nixFlakes;
		extraOptions = "experimental-features = nix-command flakes";						
	};

}
