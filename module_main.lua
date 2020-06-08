--======================================================================================================
--// Author: 	Le_JuiceBOX [Larrold#7001] [Discord ID: 263073829226676226]							   
--// Desc:		A module filled to the brim with functions to speed up development among other things.                                                                
--======================================================================================================

--// Dependencies
local Helper = require(script:WaitForChild("Helper"))

--// Folders
_RUM = {}
_RUM.General = {}
_RUM.Objects = {}
_RUM.Tables = {}
_RUM.Tools = {}
_RUM.Audio = {}
	
--// Aliases
local cont_General = _RUM.General
local cont_Objects = _RUM.Objects
local cont_Tables = _RUM.Tables
local cont_Tools = _RUM.Tools
local cont_Audio = _RUM.Audio

local pOut = Helper.PluginPrint
local debOut = Helper.DebugPrint

--=======================================================================================================
-- General
--=======================================================================================================

		cont_General.CloneTo = function(items,dest)
			for i,v in pairs(items) do v:Clone().Parent = dest end
		end
		
		cont_General.GetPlayersWithin = function(object,maxDist)
			local result = {}
			local players = game.Players:GetPlayers()
			for i,v in pairs(players) do
				local hum = v.Character:FindFirstChild("Humanoid")
				local hrp = v.Character:FindFirstChild("HumanoidRootPart")
				if hrp and hum and hum.Health > 0 then
					local dist = (object.Position - hrp.Position).magnitude
					if dist < maxDist then table.insert(result,v); end
				end
			end
			return result;
		end
		
		cont_General.CastRay = function(origin,dest,ignores,appearance)
			if not typeof(origin) == "Vector3" or not typeof(dest) == "Vector3" then return; end
			local rayOrigin = origin
			local rayDestination = dest
			local rayDirection = rayDestination - rayOrigin
			local ray = Ray.new(rayOrigin, rayDirection)
			local TempFolder = Helper.TempFolder()
			-- Detect if the ray hits a part
			table.insert(ignores,TempFolder)
			local hitPart, hitPosition = workspace:FindPartOnRayWithIgnoreList(ray, ignores)
		
			if appearance then
				local dist = (dest - origin).magnitude
				local beam = Instance.new("Part",TempFolder)
				beam.Name = appearance.Name or "Ray"
				beam.Anchored = appearance.Anchored or true
				beam.CanCollide = appearance.CanCollide or false
				beam.Color = appearance.Color or Color3.fromRGB(200,200,200)
				beam.Transparency = appearance.Transparency or 0
				beam.Reflectance = appearance.Reflectance or 0
				beam.Material = appearance.Material or Enum.Material.SmoothPlastic
				beam.Size = Vector3.new(appearance.Size or 0.2, appearance.Size or 0.2, dist)
				beam.CFrame = CFrame.new(origin, hitPosition) * CFrame.new(0, 0, -dist / 2)
				game.Debris:AddItem(beam,appearance.LifeTime or 1)
			end
			return {Hit = hitPart or nil, HitPos = hitPosition or nil}
		end
	
--=======================================================================================================
-- Tables
--=======================================================================================================
		
		cont_Tables.Print = function(t)
			if type(t) ~= "table" then return; end
			for i,v in pairs(t) do print("[ "..tostring(i).." ] - \'"..tostring(v)..'\''); end
		end
		
--=======================================================================================================
-- Objects
--=======================================================================================================	
		
		cont_Objects.GetPlayer = function(p)
			local player = game:GetService("Players"):GetPlayerFromCharacter(p)
			if player then return player; end
			return nil;
		end
		
		cont_Objects.GetCharacter = function(p)
			local humanoid = p.Parent:FindFirstChild("Humanoid") 
			if humanoid then return p.Parent, humanoid; end
			return nil;
		end
		
		cont_Objects.ParentHasHumanoid = function(p)
			local humanoid = p.Parent:FindFirstChild("Humanoid")
			return humanoid
		end
		
		cont_Objects.DestroyList = function(object,list)
			for _,obj in pairs(object:GetChildren()) do
				for i,v in pairs(list) do if obj.Name == v then obj:Destroy(); end end
			end
		end
		
		cont_Objects.DestroyChildrenOfClass = function(object,class)
			for i,v in pairs(object:GetChildren()) do
				if v:IsA(class) then v:Destroy() end
			end
		end
		
		cont_Objects.TableToProperties = function(object,properties)
			for pName,pValue in pairs(properties) do
				if Helper.HasProp(object,pName) then object[pName] = pValue else debOut("Skipped property \""..pName.."\".") end
			end
		end
	
--=======================================================================================================
-- Tools
--=======================================================================================================
										
	cont_Tools = {}
	
		cont_Tools.UserAlive = function(tool)
			if not tool then return; end
			local char = cont_Objects.GetCharacter(tool)
			local hum = char:FindFirstChild("Humanoid")
			if not char or not hum then return false; end
			if hum.Health > 0 then return true; else return false; end
		end
		
		cont_Tools.FPBodyTransparency = function(char,list)
			for i,v in pairs(char:GetChildren()) do
				if v:IsA("BasePart") and v.Name ~= "Head" then
					if list[v.Name] then
						v.LocalTransparencyModifier = list[v.Name]
						print(v.Name)
					end
				end
			end
		end
		
		cont_Tools.UserPlayer = cont_Objects.GetPlayer
		
		cont_Tools.UserCharacter = cont_Objects.GetCharacter
		

--=======================================================================================================
-- Audio
--=======================================================================================================

	cont_Audio = {}

		cont_Audio.Play = function(audio,location,volume,pitch)
			if not audio then return; end
			local location = location or audio.Parent
			local sound = audio:Clone()
			sound.Parent = location
			sound.Volume = volume or sound.Volume
			sound.PlaybackSpeed = pitch or sound.PlaybackSpeed
			sound:Play()
			game:GetService("Debris"):AddItem(sound,sound.TimeLength+(0.1))
			return sound;
		end
		
		cont_Audio.PlayID = function(audioId,location,volume,pitch)
			warn("Does nothing rn.")
		end
	
--=======================================================================================================
debOut("Loaded successfully.")
return _RUM
