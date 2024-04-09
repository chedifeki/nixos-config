{
  description = "NixOs Config";


  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixvim,hyprland, hyprlock, hypridle, plasma-manager, ...}@ inputs: 
	let
		systemSettings =  {
			system 	 = "x86_64-linux";
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
		upkgs= import  nixpkgs-unstable {
			system = systemSettings.system;
			config.allowUnfree=true;
		};
		
		lib = nixpkgs.lib;
	in {
								
		nixosConfigurations = {
      dragon = lib.nixosSystem {
				system = systemSettings.system;
				specialArgs = {
					inherit upkgs;
					inherit userSettings;
					inherit systemSettings;
					inherit hyprland hyprlock hypridle ;
				};
				modules =  [
					./hosts/dragon/configuration.nix
					home-manager.nixosModules.home-manager {
						home-manager = {
							useGlobalPkgs = true;
	 						useUserPackages = true;
							extraSpecialArgs = {
								inherit upkgs;
								inherit userSettings;
								inherit nixvim;

							};	
						};
					}
				];
			};
			vmlab = lib.nixosSystem {
				system = systemSettings.system;
				specialArgs = { 
					inherit inputs;	
					inherit pkgs;
					inherit upkgs;
					inherit systemSettings;
				};

				modules =  [
					./hosts/vmlab/configuration.nix
					home-manager.nixosModules.home-manager {
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							extraSpecialArgs = {
								inherit inputs;
								inherit pkgs;
								inherit upkgs;
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
