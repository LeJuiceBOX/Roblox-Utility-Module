--======================================================================================================
--// Author: 	Le_JuiceBOX [Larrold#7001] [Discord ID: 263073829226676226]							   
--// Desc:		Helper functions, used inside the main module.                                                             
--======================================================================================================

local Main = script.Parent.Parent
local Config = Main.Configuration
local Data = Main.Data

local module = {}
	
	module.ModPrint = function(cont,t)
		local text = Config.PrintName.Value " - "..tostring(cont)  
		if not t or t =='print' or t=='p' then print(text);
		elseif t=='warn' or t=='wrn' or t=='w' then warn(text);
		elseif t=='error' or t =='err' or t=='e' then error(text); end
	end
	
	module.DebugPrint = function(cont,t)
		if Data._DebugMode.Value then module.ModPrint(cont,t); end
	end
	
	module.HasProp = function(object,property)
		if object:FindFirstChild(property) then 
			module.ModPrint("A child cant have the same name as one of its parent's properties. (its also bad practice)",'warn')
			return; 
		end
		local successful = pcall(function()
			return object[property]
		end)
		return successful
	end
	
	module.ConfVal = function(valueName)
		local value = Config:FindFirstChild(valueName,true) or nil
		return value.Value
	end 
	
	module.TempFolder = function()
		local location = module.ConfVal("TempFolder_Location")
		local name = module.ConfVal("TempFolder_Name")
		local Folder = location:FindFirstChild(name)
		if Folder then return Folder; end --// One already exists, return it
		local location = location or workspace
		local folder = Instance.new("Folder",location)
		folder.Name = module.ConfVal("TempFolder_Name")
		spawn(function()
			repeat wait(0.5) until #folder:GetChildren() < 1
			folder:Destroy()
		end)
		return folder
	end

return module
