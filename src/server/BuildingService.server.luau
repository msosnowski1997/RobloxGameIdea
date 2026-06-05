local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local buildingSystem = ReplicatedStorage:WaitForChild("BuildingSystem")
local definitions = require(buildingSystem:WaitForChild("BuildingDefinitions"))
local buildRequest = buildingSystem:WaitForChild("Remotes"):WaitForChild("BuildRequest")

local cityTerrain = Workspace:WaitForChild("CityBuildTerrain")
local buildPad = cityTerrain:WaitForChild("CityBuildingPad")
local placedBuildings = Workspace:FindFirstChild("PlacedBuildings") or Instance.new("Folder")
placedBuildings.Name = "PlacedBuildings"
placedBuildings.Parent = Workspace

local occupiedTiles = {}

local function tileKey(gridX, gridZ)
	return tostring(gridX) .. ":" .. tostring(gridZ)
end

local function isWholeNumber(value)
	return typeof(value) == "number" and value == math.floor(value)
end

local function canAfford(player, cost)
	if not cost then
		return true
	end

	local leaderstats = player:FindFirstChild("leaderstats")
	for resourceName, amount in pairs(cost) do
		local resource = leaderstats and leaderstats:FindFirstChild(resourceName)
		if not resource or resource.Value < amount then
			return false
		end
	end

	return true
end

local function charge(player, cost)
	if not cost then
		return
	end

	local leaderstats = player:FindFirstChild("leaderstats")
	for resourceName, amount in pairs(cost) do
		local resource = leaderstats and leaderstats:FindFirstChild(resourceName)
		if resource then
			resource.Value -= amount
		end
	end
end

local function isAreaAvailable(buildingDefinition, gridX, gridZ)
	local columns, rows = definitions.GetPadGrid(buildPad)
	local sizeTiles = buildingDefinition.SizeTiles

	if gridX < 0 or gridZ < 0 then
		return false
	end

	if gridX + sizeTiles.X > columns or gridZ + sizeTiles.Y > rows then
		return false
	end

	for x = gridX, gridX + sizeTiles.X - 1 do
		for z = gridZ, gridZ + sizeTiles.Y - 1 do
			if occupiedTiles[tileKey(x, z)] then
				return false
			end
		end
	end

	return true
end

local function markArea(buildingDefinition, gridX, gridZ, buildingModel)
	local sizeTiles = buildingDefinition.SizeTiles
	for x = gridX, gridX + sizeTiles.X - 1 do
		for z = gridZ, gridZ + sizeTiles.Y - 1 do
			occupiedTiles[tileKey(x, z)] = buildingModel
		end
	end
end

local function createBuilding(player, buildingDefinition, gridX, gridZ)
	local tileSize = definitions.TileSize
	local height = buildingDefinition.Height
	local sizeTiles = buildingDefinition.SizeTiles

	local part = Instance.new("Part")
	part.Name = buildingDefinition.DisplayName
	part.Anchored = true
	part.CanCollide = true
	part.Size = Vector3.new(sizeTiles.X * tileSize, height, sizeTiles.Y * tileSize)
	part.CFrame = CFrame.new(definitions.GridToWorld(buildPad, gridX, gridZ, sizeTiles, height))
	part.Material = buildingDefinition.Material or Enum.Material.SmoothPlastic
	part.Color = buildingDefinition.Color or Color3.fromRGB(120, 80, 40)
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = placedBuildings

	part:SetAttribute("BuildingId", buildingDefinition.Id)
	part:SetAttribute("OwnerUserId", player.UserId)
	part:SetAttribute("GridX", gridX)
	part:SetAttribute("GridZ", gridZ)
	part:SetAttribute("SizeTilesX", sizeTiles.X)
	part:SetAttribute("SizeTilesZ", sizeTiles.Y)

	return part
end

buildRequest.OnServerEvent:Connect(function(player, buildingId, gridX, gridZ)
	if typeof(buildingId) ~= "string" or not isWholeNumber(gridX) or not isWholeNumber(gridZ) then
		return
	end

	local buildingDefinition = definitions.Get(buildingId)
	if not buildingDefinition then
		return
	end

	if not isAreaAvailable(buildingDefinition, gridX, gridZ) then
		return
	end

	if not canAfford(player, buildingDefinition.Cost) then
		return
	end

	charge(player, buildingDefinition.Cost)
	local building = createBuilding(player, buildingDefinition, gridX, gridZ)
	markArea(buildingDefinition, gridX, gridZ, building)
end)
