local Players = game:GetService("Players")
local Player = Players.LocalPlayer

function kick()
	Player:Kick("You have tried to disable the AntiCheat and for this reason you have been expelled from the experience.")
end

while wait(0,05) do
	local success, errorMessage = pcall(function()
		local Anti = script.Parent.Anti
		
		if Anti.Disabled == true then return kick() end
	end)
	
	if errorMessage then return kick() end
end