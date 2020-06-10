--======================================================================================================
--// Author: 	Le_JuiceBOX [Larrold#7001] [Discord ID: 263073829226676226]							   
--// Desc:		This is how the plugin generates all RUM's descendants.                                                                
--======================================================================================================

return{
	
	Generate = function(location)
		--// GENERATION
		local scr_main = Instance.new("ModuleScript",location)
		-- Folders
			local fld_abt = Instance.new("RemoteFunction",scr_main)
			local fld_dat = Instance.new("Sparkles",scr_main)
			local fld_int = Instance.new("Folder",scr_main)
			local fld_cnf = Instance.new("Configuration",scr_main)

		-- Items
			-- In Internal
			local scr_helper = Instance.new("ModuleScript",fld_int)
			-- In About
			local txt_readme = Instance.new("LocalScript",fld_abt)
			local txt_updates = Instance.new("LocalScript",fld_abt)
			local val_version = Instance.new("StringValue",fld_abt)
			-- In Data
			local val_print_name = Instance.new("StringValue",fld_int)
			local val_auto_update = Instance.new("BoolValue",fld_int)
			local val_debug_mode = Instance.new("BoolValue",fld_int)
			-- In Configuration
			local val_tempfolder_name = Instance.new("StringValue",fld_cnf)
			local val_tempfolder_location = Instance.new("ObjectValue",fld_cnf)
		
		--// SETUP
		scr_main.Name = "_RUM"
		scr_helper.Name = "Helper"
		fld_abt.Name = "|- About"
		fld_dat.Name = "|- Data"
		fld_int.Name = "|- Internal"
		fld_cnf.Name = "|- Config"
		val_print_name.Name = "_PrintName"
		val_auto_update.Name = "_AutoUpdate"
		val_debug_mode.Name = "_DebugMode"
		txt_readme.Name = "|- ReadMe"
		txt_updates.Name = "|- UpdateLog"
		val_version.Name = "|- Version"
		val_tempfolder_name.Name = "TempFolder_Name"
		val_tempfolder_location.Name = "TempFolder_Location"
		
		
		--// VALUE REPLACMENT
		val_print_name.Value = "RUM"
		val_auto_update.Value = true
		val_debug_mode.Value = false
		
		val_tempfolder_name.Value = "TempFolder [RUM]"
		val_tempfolder_location.Value = workspace
		
		return scr_main;
	end
}
