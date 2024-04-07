{
  description = "NixOs Config";


  outputs = inputs @{ self, nixpkgs, nixpkgs-unstable, home-manager, nixvim,hyprland, hyprlock, hypridle, plasma-manager, ...}: 
	let
		systemSettings =  {
			system 	 = "x86_64-linux";
			hostname = "vm";
			timezone = "Europe/Brussels";
			locale   = "en_US.UTF-8";
	 		layout   = "fr";
		};
		userSettings = {
			user   = "cfeki";
			name   = "Chedi Feki";
			email  = "chedifeki@gmail.com";
			wm     = "hyprland";
			wmType = "wayland";
			browser = "brave";
			terminal = "alacritty";
			editor = "nvim";
		};
		pkgs = import nixpkgs {
			system = systemSettings.system;
			config.allowUnfree=true;		
		};
		pkgs-unstable = import  nixpkgs-unstable {
			system = systemSettings.system;
			config.allowUnfree=true;
		};
		
		lib = nixpkgs.lib;
	in {

		nixosConfigurations = {
			"${systemSettings.hostname}" = lib.nixosSystem {
				system = systemSettings.system;
				specialArgs = {
					inherit pkgs-unstable;
					inherit userSettings;
					inherit systemSettings;
					
					inherit hyprland hyprlock hypridle ;
				};
				modules =  [
					./configuration.nix
					home-manager.nixosModules.home-manager {
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							users.${userSettings.user} = {
								imports = [./home.nix];
							};
							extraSpecialArgs = {
								inherit pkgs-unstable;
								inherit userSettings;
								inherit nixvim;

							};	
						};
					}
				];
			};
		};
	};

  inputs = {
		nixpkgs = {
			url = "github:nixos/nixpkgs/nixos-23.11";
		};

		nixpkgs-unstable = {
			url = "github:nixos/nixpkgs/nixos-unstable";
		};

		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";		
			inputs.nixpkgs.follows = "nixpkgs";
		};

		home-manager-unstable = {
			url = "github:nix-community/home-manager";		
			inputs.nixpkgs.follows = "nixpkgs-unstable";
		};


		#Neovim 
		nixvim = {
			url = "github:nix-community/nixvim/nixos-23.11";
			inputs.nixpkgs.follows="nixpkgs";
		};


		# Hyprland
    		hyprland = {
			url = "github:hyprwm/Hyprland";
			inputs.nixpkgs.follows = "nixpkgs-unstable";
		};

		    hyprlock = {
			url = "github:hyprwm/hyprlock";
			inputs.nixpkgs.follows = "nixpkgs-unstable";
		};
   		 hypridle = {
			url = "github:hyprwm/hypridle";
			inputs.nixpkgs.follows = "nixpkgs-unstable";
		};

		# Plasma
		plasma-manager = {
			url = "github:pjones/plasma-manager";
      			inputs.nixpkgs.follows = "nixpkgs";
			inputs.home-manager.follows = "nixpkgs";
		};

	};

}
