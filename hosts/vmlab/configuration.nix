# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{inputs, pkgs, upkgs, systemSettings , ... }:
	
{
	
	imports = [ 
		########## Required configurations ##########
		./hardware-configuration.nix
		../common/core
		########## Optional configurations ##########



        ##########        Users            ##########
		../common/users/cfeki


	];

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	boot.loader.grub.useOSProber = true;  

	networking = {
		hostName = "vmlab"; # Define your hostname.
		# wireless.enable = true;  # Enables wireless support via wpa_supplicant.
		# Configure network proxy if necessary
		# proxy.default = "http://user:password@proxy:port/";
		# proxy.noProxy = "127.0.0.1,localhost,internal.domain";
		networkmanager.enable = true;
	};



  # Enable the X11 windowing system.
  services = {
	xserver = { 
		enable = true;
		# Enable the mate desktop Environment.
		desktopManager.xfce.enable=true;
		displayManager = {
			sddm.enable = true;
		};
		# set keyboard layout
		layout = systemSettings.layout;
		xkbVariant = "";
		# libinput.enable = true; # enables touchpad click if needed
	};
  };

  # Configure console keymap
  console.keyMap = systemSettings.layout;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  
  # This value determines the NixOS release from which the default

  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?


}
