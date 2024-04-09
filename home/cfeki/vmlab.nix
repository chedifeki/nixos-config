{inputs, config, pkgs, upkgs, userSettings, ...}: 
{
	imports = [
		# required : 
		./common/core

		# optional :
	];	

	home.packages= with pkgs; [
		firefox
	];

}
