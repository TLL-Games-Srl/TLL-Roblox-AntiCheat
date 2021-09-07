--\\AntiCheat
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Backpack = Player:WaitForChild("Backpack")
local Character = Player.Character
local HRP = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

local MaxSpeed = 25
local MinSpeed = 15
local MaxJump = 50
local MinJump = 50

function kick()
	Player:Kick("TLL Roblox AntiCheat interrupted the experience because you are using methods to have superiority over the players, which is deemed illicit. Close the program you are using to get the cheats")
end

function teleport()
	local FirstPos = HRP.Position

	delay(1, function()
		local SecondPos = HRP.Position

		if (SecondPos - FirstPos).Magnitude >= 140 then return kick() end
	end)
end

--\\Prevents btools
Backpack.ChildAdded:Connect(function(Obj)
	if Obj:IsA("HopperBin") then return kick() end
end)

--\\Prevents fly
HRP.ChildAdded:Connect(function(Obj)
	if Obj:IsA("BodyVelocity") or Obj:IsA("BodyGyro") or Obj:IsA("BodyPosition") then return kick() end
end)



while wait(.05) do
	--\\WalkSpeed
	if Humanoid.WalkSpeed > MaxSpeed then return kick() end
	if Humanoid.WalkSpeed < MinSpeed then return kick() end
	--\\JumpPower
	if Humanoid.JumpPower > MaxJump then return kick() end
	if Humanoid.JumpPower < MinJump then return kick() end
	--\\Check they're teleposting
	teleport()
end
