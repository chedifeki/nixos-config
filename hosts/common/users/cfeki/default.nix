{inputs, config, pkgs, upkgs, ...}:


let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

in {
  users.users.cfeki= {
    isNormalUser = true;
    description = "Chedi Feki";
    extraGroups = [ 
		"networkmanager" 
		"wheel"
		"audio"
		"video"
	] ++ ifTheyExist [
		"git"
	];
	
	packages = [pkgs.home-manager]; 
  };

	home-manager.users.cfeki = import ../../../../home/cfeki/${config.networking.hostName}.nix;

}
