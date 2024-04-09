#####
##  default environment  variables and packages.
#####


{pkgs, upkgs,...}: 
{
  environment = {		
	variables = {
		EDITOR = "vim";
	};
	systemPackages = (with pkgs; [
			bat
    		btop
    		fzf
    		git
    		lf 
			vim
			powertop
    		tldr
    		wget
			zsh
  	])  ++ (with upkgs; [
		# unstable packages here 

	]);
  };

}
