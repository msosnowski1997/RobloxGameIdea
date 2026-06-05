local BuildingDefinitions = {}

BuildingDefinitions.TileSize = 4
BuildingDefinitions.Buildings = {
	LumberjackHut = {
		Id = "LumberjackHut",
		DisplayName = "Chata drwala",
		SizeTiles = Vector2.new(2, 2),
		Height = 8,
		Material = Enum.Material.Wood,
		Color = Color3.fromRGB(105, 70, 38),
		Cost = {},
	},
}

function BuildingDefinitions.Get(buildingId)
	return BuildingDefinitions.Buildings[buildingId]
end

function BuildingDefinitions.GetPadGrid(pad)
	local tileSize = BuildingDefinitions.TileSize
	return math.floor(pad.Size.X / tileSize), math.floor(pad.Size.Z / tileSize)
end

function BuildingDefinitions.GetPadOrigin(pad)
	return Vector3.new(
		pad.Position.X - pad.Size.X / 2,
		pad.Position.Y + pad.Size.Y / 2,
		pad.Position.Z - pad.Size.Z / 2
	)
end

function BuildingDefinitions.GridToWorld(pad, gridX, gridZ, sizeTiles, height)
	local tileSize = BuildingDefinitions.TileSize
	local origin = BuildingDefinitions.GetPadOrigin(pad)
	return Vector3.new(
		origin.X + (gridX + sizeTiles.X / 2) * tileSize,
		origin.Y + height / 2,
		origin.Z + (gridZ + sizeTiles.Y / 2) * tileSize
	)
end

function BuildingDefinitions.WorldToGrid(pad, worldPosition)
	local tileSize = BuildingDefinitions.TileSize
	local origin = BuildingDefinitions.GetPadOrigin(pad)
	return math.floor((worldPosition.X - origin.X) / tileSize), math.floor((worldPosition.Z - origin.Z) / tileSize)
end

return BuildingDefinitions
