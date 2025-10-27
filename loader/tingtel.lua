-- Script: Name Animation System
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local activeConnection = nil

-- Fungsi untuk hapus nama asli dari karakter lokal
local function removeOriginalNameTags(character)
	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BillboardGui") and descendant.Name ~= "CustomBillboard" then
			descendant:Destroy()
		end
	end
end

-- Fungsi untuk reset nama (hapus fake name)
local function resetName()
	if activeConnection then
		activeConnection:Disconnect()
		activeConnection = nil
	end
	
	if LocalPlayer.Character then
		local head = LocalPlayer.Character:FindFirstChild("Head")
		if head then
			local customBillboard = head:FindFirstChild("CustomBillboard")
			if customBillboard then
				customBillboard:Destroy()
			end
		end
		
		local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
			humanoid.NameDisplayDistance = 100
			humanoid.DisplayName = LocalPlayer.DisplayName
		end
	end
end

-- Fungsi untuk membuat title animasi
local function createTitle(character)
	local head = character:WaitForChild("Head", 5)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not (head and humanoid) then return end

	-- Sembunyikan nama default
	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	humanoid.NameDisplayDistance = 0
	humanoid.DisplayName = ""

	-- Tunggu sedikit untuk memastikan semua GUI original sudah ter-load
	task.wait(0.1)
	
	-- Hapus GUI nama asli
	removeOriginalNameTags(character)

	-- Hapus title lama jika ada
	local existingTitle = head:FindFirstChild("CustomBillboard")
	if existingTitle then
		existingTitle:Destroy()
	end

	-- Create BillboardGui dengan nama yang konsisten
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "CustomBillboard"
	billboard.Adornee = head
	billboard.Size = UDim2.new(0, 400, 0, 80)
	billboard.StudsOffset = Vector3.new(0, 3.5, 0)
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = 150
	billboard.Enabled = true
	billboard.Parent = head
	
	-- Create UIGradient for animated gradient
	local gradient = Instance.new("UIGradient")
	gradient.Name = "AnimatedGradient"
	gradient.Rotation = 0
	
	-- Create TextLabel
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, -70) 
	textLabel.Position = UDim2.new(0, -3, 0, 75)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = "dsc.gg/xukrost-hub"
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.TextScaled = true
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextStrokeTransparency = 0.5
	textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	textLabel.ZIndex = 2
	textLabel.Parent = billboard
	
	-- Apply gradient to text
	gradient.Parent = textLabel
	
	-- Animation variables
	local time = 0
	local animationSpeed = 1.7
	
	-- Color sequence for gradient
	local colorSequence = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(0.3, Color3.fromRGB(148, 0, 211)),
		ColorSequenceKeypoint.new(0.7, Color3.fromRGB(30, 144, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	})
	
	-- Connection for animation
	local connection
	connection = RunService.Heartbeat:Connect(function(deltaTime)
		if not billboard or not billboard.Parent then
			connection:Disconnect()
			return
		end
		
		time = time + deltaTime * animationSpeed
		gradient.Offset = Vector2.new(math.cos(time) * 0.5, math.sin(time) * 0.3)
		gradient.Rotation = math.sin(time * 0.5) * 15
		gradient.Color = colorSequence
		textLabel.TextScaled = true
	end)
	
	-- Clean up connection when billboard is destroyed
	billboard.Destroying:Connect(function()
		if connection then
			connection:Disconnect()
		end
	end)
end

-- Fungsi untuk mengubah display name
local function changeDisplayName()
	local success, error = pcall(function()
		LocalPlayer.DisplayName = "dsc.gg/xukrost-hub"
	end)
	
	if not success then
		warn("Failed to change display name: " .. error)
	end
end

-- Fungsi untuk menghapus ScreenGui
local function removeScreenGui()
	local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
	if playerGui then
		local nameChangerGUI = playerGui:FindFirstChild("NameChangerGUI")
		if nameChangerGUI then
			nameChangerGUI:Destroy()
		end
	end
end

-- Main execution function
local function executeScript()
    -- Check if script should run
    if not _G["Setting"] or not _G["Setting"]["Tittle Exs"] then
        print("Script execution disabled in settings")
        return
    end
    
    -- Panggil fungsi untuk menghapus ScreenGui
    removeScreenGui()

    -- Ubah display name
    changeDisplayName()

    -- Auto apply to character
    LocalPlayer.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        createTitle(char)
    end)

    -- Handle respawning
    LocalPlayer.CharacterAppearanceLoaded:Connect(function(character)
        task.wait(0.5)
        createTitle(character)
    end)

    if LocalPlayer.Character then
        createTitle(LocalPlayer.Character)
    end

    print("Script successfully loaded and executed!")
end

-- Run the script
executeScript()