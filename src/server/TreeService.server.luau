local ServerStorage = game:GetService("ServerStorage")
local TreePrefab = ServerStorage:WaitForChild("TreePrefab")
local WoodFolder = workspace.Wood
local SpawnPoints = WoodFolder.SpawnPoints:GetChildren()
local TreeFolder = WoodFolder.Trees


print("Hello World!")
local function setupTree(tree)
	local prompt = tree:FindFirstChild("ChopPoint"):FindFirstChild("ProximityPrompt")


	prompt.Triggered:Connect(function(player)
		local leaderstats = player:FindFirstChild("leaderstats")
		if not leaderstats then return end

		local wood = leaderstats:FindFirstChild("Wood")
		if not wood then return end


		local woodAmount = tree:GetAttribute("WoodLoot") or 1

		wood.Value += woodAmount
		tree:Destroy()
	end)
end

for _, spawnPoint in SpawnPoints do
	local tree = TreePrefab:Clone()
	tree.Parent = TreeFolder
	tree:PivotTo(spawnPoint.CFrame)
	setupTree(tree)
	print("Tree spawned at", spawnPoint.CFrame.Position)
end
