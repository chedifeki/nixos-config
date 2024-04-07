{pkgs,...}:

{

	programs = {
		nixvim = {
			enable = true;
			viAlias = true;
			vimAlias = true;
			options = {
				number = true;
				relativenumber=true;
				tabstop =4;
				shiftwidth= 4;					 
				softtabstop= 4;
				autoindent = true;
				fileencoding="utf-8";
				cursorline=true;
			};
			colorschemes.base16 = {
				enable = true;
				colorscheme = "irblack";
			};
				      
      globals.mapleader = " "; # set the leader character to space
			keymaps = [
				{
					key ="<leader>e";
					action="<CMD>Neotree toggle<CR>";
					options.desc= "Toggle NeoTree";
				}
				{
					key = "<leader>sh";
					action="<C-w>s";
					options.desc="Split Horizontal";
}
				{
					key = "<leader>sv";
					action="<C-w>v";
					options.desc="Split Vertical";
				}
				{
					key="<leader><Left>";
					action="<C-w>h";
					options.desc="Select Window Left";
				}
				{
					key="<leader><Right>";
					action="<C-w>l";
					options.desc="Select Window Right";
				}
				{
					key="<leader><Up>";
					action="<C-w>k";
					options.desc="Select Window Left";
				}
				{
					key="<leader><Down>";
					action="<C-w>j";
					options.desc="Select Window Right";
				}

			];

			plugins = {
				lualine.enable=true;
				telescope = {
					enable = true;
					keymaps={
						"<leader>ff" = {
							action = "find_files";
							desc= "Find File";
						};
					};
				};
				neo-tree = {
					enable=true;
					window.width=30;
					closeIfLastWindow=true;
					extraOptions.filesystem.filtered_items.visible=true;
				};
				undotree = {
					enable=true;
					focusOnToggle=true;
					highlightChangedText=true;
				};
				lsp = {
					enable = true;
					servers = {
						nil_ls.enable=true;
						html.enable=true;
						cssls.enable=true;
					};
				};
			};

		};
	};
}
