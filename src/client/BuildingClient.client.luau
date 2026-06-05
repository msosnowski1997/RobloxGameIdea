local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local buildingSystem = ReplicatedStorage:WaitForChild("BuildingSystem")
local definitions = require(buildingSystem:WaitForChild("BuildingDefinitions"))
local buildRequest = buildingSystem:WaitForChild("Remotes"):WaitForChild("BuildRequest")

local buildPad = Workspace:WaitForChild("CityBuildTerrain"):WaitForChild("CityBuildingPad")
local selectedBuildingId = nil
local currentGridX = 0
local currentGridZ = 0
local previewPart = nil
local canPlacePreview = false

local function getSelectedDefinition()
	if not selectedBuildingId then
		return nil
	end

	return definitions.Get(selectedBuildingId)
end

local function createPreview()
	if previewPart then
		return previewPart
	end

	previewPart = Instance.new("Part")
	previewPart.Name = "BuildingPlacementPreview"
	previewPart.Anchored = true
	previewPart.CanCollide = false
	previewPart.CanQuery = false
	previewPart.CanTouch = false
	previewPart.Transparency = 0.45
	previewPart.Material = Enum.Material.Neon
	previewPart.Parent = Workspace
	return previewPart
end

local function setPreviewVisible(isVisible)
	if previewPart then
		previewPart.Transparency = isVisible and 0.45 or 1
	end
end

local function isInsidePad(buildingDefinition, gridX, gridZ)
	local columns, rows = definitions.GetPadGrid(buildPad)
	local sizeTiles = buildingDefinition.SizeTiles
	return gridX >= 0 and gridZ >= 0 and gridX + sizeTiles.X <= columns and gridZ + sizeTiles.Y <= rows
end

local function isPreviewClear()
	if not previewPart then
		return false
	end

	local overlapParams = OverlapParams.new()
	overlapParams.FilterType = Enum.RaycastFilterType.Exclude
	overlapParams.FilterDescendantsInstances = { previewPart, player.Character }

	local touching = Workspace:GetPartBoundsInBox(previewPart.CFrame, previewPart.Size - Vector3.new(0.2, 0.2, 0.2), overlapParams)
	for _, part in ipairs(touching) do
		if part.Parent and part.Parent.Name == "PlacedBuildings" then
			return false
		end
	end

	return true
end

local function updatePreview()
	local buildingDefinition = getSelectedDefinition()
	if not buildingDefinition then
		setPreviewVisible(false)
		canPlacePreview = false
		return
	end

	local preview = createPreview()
	local gridX, gridZ = definitions.WorldToGrid(buildPad, mouse.Hit.Position)
	currentGridX = gridX
	currentGridZ = gridZ

	local sizeTiles = buildingDefinition.SizeTiles
	local height = buildingDefinition.Height
	preview.Size = Vector3.new(sizeTiles.X * definitions.TileSize, height, sizeTiles.Y * definitions.TileSize)
	preview.CFrame = CFrame.new(definitions.GridToWorld(buildPad, gridX, gridZ, sizeTiles, height))

	canPlacePreview = isInsidePad(buildingDefinition, gridX, gridZ) and isPreviewClear()
	preview.Color = canPlacePreview and Color3.fromRGB(60, 220, 110) or Color3.fromRGB(230, 70, 70)
	setPreviewVisible(true)
end

local function createBuildGui()
	local gui = Instance.new("ScreenGui")
	gui.Name = "BuildingGui"
	gui.ResetOnSpawn = false
	gui.Parent = player:WaitForChild("PlayerGui")

	local button = Instance.new("TextButton")
	button.Name = "LumberjackHutButton"
	button.AnchorPoint = Vector2.new(0, 1)
	button.Position = UDim2.new(0, 20, 1, -20)
	button.Size = UDim2.fromOffset(190, 44)
	button.BackgroundColor3 = Color3.fromRGB(82, 54, 34)
	button.BorderSizePixel = 0
	button.Text = "Chata drwala 2x2"
	button.TextColor3 = Color3.fromRGB(255, 245, 230)
	button.TextSize = 18
	button.Font = Enum.Font.GothamBold
	button.Parent = gui

	button.MouseButton1Click:Connect(function()
		selectedBuildingId = selectedBuildingId == "LumberjackHut" and nil or "LumberjackHut"
		button.BackgroundColor3 = selectedBuildingId and Color3.fromRGB(55, 115, 65) or Color3.fromRGB(82, 54, 34)
	end)
end

createBuildGui()
RunService.RenderStepped:Connect(updatePreview)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed or input.UserInputType ~= Enum.UserInputType.MouseButton1 then
		return
	end

	if selectedBuildingId and canPlacePreview then
		buildRequest:FireServer(selectedBuildingId, currentGridX, currentGridZ)
	end
end)
