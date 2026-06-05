local npc = workspace:WaitForChild("SellNPC")
local prompt = npc:WaitForChild("ProximityPrompt")

local WOOD_PRICE = 5

prompt.Triggered:Connect(function(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end

	local wood = leaderstats:FindFirstChild("Wood")
	local coins = leaderstats:FindFirstChild("Coins")

	if not wood or not coins then return end
	if wood.Value <= 0 then return end

	local earnedCoins = wood.Value * WOOD_PRICE

	coins.Value += earnedCoins
	wood.Value = 0
end)
