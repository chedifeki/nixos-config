{lib, ...}: 
{

	nix = {
		settings = {
			trusted-users = ["root" "@Wheel"];
			auto-optimise-store = lib.mkDefault true;
			experimental-features = ["nix-command" "flakes" "repl-flake"]; # TODO check what is this repl-flake command"
			warn-dirty=false;
		};

		gc = {
			automatic=true;
			dates="weekly";
			options = "--delete-older-than +5"; # keep the last 5 generations
		}; 
	};


}
