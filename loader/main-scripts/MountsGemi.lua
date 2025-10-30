local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- checkpoint (TETAP SEMUA)
local CheckPoints = {
    Spawn = {x = 1265, y = 637, z = 1790},
    ["Pos - 1"] = {x = 849, y = 628, z = 1143},
    ["Pos - 2"] = {x = 646, y = 628, z = 1147},
    ["Pos - 3"] = {x = 556, y = 704, z = 1125},
    ["Pos - 4"] = {x = -200, y = 768, z = 1024},
    ["Pos - 5"] = {x = -196, y = 768, z = 275},
    ["Pos - 6"] = {x = -289, y = 636, z = 175},
    ["Pos - 7"] = {x = -640, y = 768, z = 9},
    ["Pos - 8"] = {x = -965, y = 772, z = 439},
    ["Pos - 9"] = {x = -1514, y = 940, z = 780},
    ["Pos - 10"] = {x = -1925, y = 940, z = 192},
    ["Pos - 11"] = {x = -2435, y = 776, z = -255},
    ["Pos - 12"] = {x = -2081, y = 1048, z = -384},
    ["Pos - 13"] = {x = -1756, y = 1216, z = -485},
    ["Pos - 14"] = {x = -1877, y = 1432, z = -692},
    ["Pos - 15"] = {x = -1436, y = 1432, z = -1357},
    ["Pos - 16"] = {x = -1375, y = 1532, z = -1570},
    ["Pos - 17"] = {x = -1306, y = 1704, z = -1660},
    ["Pos - 18"] = {x = -1880, y = 1704, z = -2036},
    ["Pos - 19"] = {x = -2176, y = 1708, z = -2045},
    ["Pos - 20"] = {x = -2591, y = 1868, z = -2401},
    ["Pos - 21"] = {x = -2917, y = 1732, z = -2157},
    ["Pos - 22"] = {x = -3268, y = 1736, z = -2412},
    ["Pos - 23"] = {x = -3400, y = 1932, z = -2506},
    ["Pos - 24"] = {x = -3896, y = 1940, z = -2222},
    ["Pos - 25"] = {x = -3970, y = 1752, z = -2300},
    ["Pos - 26"] = {x = -3919, y = 1752, z = -1712},
    ["Pos - 27"] = {x = -4143, y = 1940, z = -1474},
    ["Pos - 28"] = {x = -4307, y = 1940, z = -1103},
    ["Pos - 29"] = {x = -3711, y = 1940, z = -536},
    ["Pos - 30"] = {x = -3505, y = 1656, z = 73},
    ["Pos - 31"] = {x = -3718, y = 1657, z = 459},
    ["Pos - 32"] = {x = -4145, y = 1656, z = 494},
    ["Pos - 33"] = {x = -4225, y = 1656, z = 970},
    ["Pos - 34"] = {x = -4567, y = 1654, z = 645},
    ["Pos - 35"] = {x = -4465, y = 1656, z = 152},
    ["Pos - 36"] = {x = -4489, y = 2056, z = 55},
    ["Pos - 37"] = {x = -4890, y = 2056, z = 685},
    ["Pos - 38"] = {x = -5395, y = 2058, z = 537},
    ["Pos - 39"] = {x = -5427, y = 1884, z = 422},
    ["Pos - 40"] = {x = -5317, y = 1884, z = 155},
    ["Pos - 41"] = {x = -5265, y = 1884, z = -174},
    ["Pos - 42"] = {x = -4970, y = 1908, z = -426},
    ["Pos - 43"] = {x = -4836, y = 2056, z = -572},
    ["Pos - 44"] = {x = -5002, y = 2056, z = -1230},
    ["Pos - 45"] = {x = -4920, y = 2064, z = -1572},
    ["Pos - 46"] = {x = -5185, y = 2064, z = -1750},
    ["Pos - 47"] = {x = -5080, y = 2148, z = -1920},
    ["Pos - 48"] = {x = -5260, y = 2288, z = -2253},
    ["Pos - 49"] = {x = -5863, y = 2464, z = -1825},
    ["Pos - 50"] = {x = -5919, y = 2704, z = -829},
    Puncak = {x = -6623, y = 3146, z = -796}
}

local isAutoTeleporting = false
local isAutoRespawnEnabled = false
local currentDelay = 3
-- Urutan teleport TETAP untuk manual, tapi auto teleport langsung ke Puncak
local teleportSequence = {"Spawn", "Pos - 1", "Pos - 2", "Pos - 3", "Pos - 4", "Pos - 5", "Pos - 6", "Pos - 7", "Pos - 8", "Pos - 9", "Pos - 10", "Pos - 11", "Pos - 12", "Pos - 13", "Pos - 14", "Pos - 15", "Pos - 16", "Pos - 17", "Pos - 18", "Pos - 19", "Pos - 20", "Pos - 21", "Pos - 22", "Pos - 23", "Pos - 24", "Pos - 25",  "Pos - 26", "Pos - 27", "Pos - 28", "Pos - 29", "Pos - 30", "Pos - 31", "Pos - 32", "Pos - 33", "Pos - 34", "Pos - 35", "Pos - 36", "Pos - 37", "Pos - 38", "Pos - 39", "Pos - 40", "Pos - 41", "Pos - 42", "Pos - 43", "Pos - 44", "Pos - 45", "Pos - 46", "Pos - 47", "Pos - 48", "Pos - 49", "Pos - 50", "Puncak"}

-- Color scheme
local Colors = {
    Background = Color3.fromRGB(30, 30, 40),
    Primary = Color3.fromRGB(80, 120, 220),
    Secondary = Color3.fromRGB(60, 180, 100),
    Danger = Color3.fromRGB(220, 80, 80),
    Warning = Color3.fromRGB(220, 160, 60),
    Text = Color3.fromRGB(240, 240, 240),
    DarkText = Color3.fromRGB(180, 180, 180)
}

-- frame
local function CreateGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AutoTeleportGUI"
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Main Frame dengan gradient background
    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 430, 0, 235)
    frame.Position = UDim2.new(0, 20, 0.5, -225)
    frame.BackgroundColor3 = Colors.Background
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
    })
    gradient.Rotation = 45
    gradient.Parent = frame
    
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 12)

    -- Header dengan efek glassmorphism
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 50)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    header.BackgroundTransparency = 0.9
    header.BorderSizePixel = 0
    header.Parent = frame
    
    local headerCorner = Instance.new("UICorner", header)
    headerCorner.CornerRadius = UDim.new(0, 12)
    
    local headerStroke = Instance.new("UIStroke", header)
    headerStroke.Color = Color3.fromRGB(255, 255, 255)
    headerStroke.Thickness = 0.5
    headerStroke.Transparency = 0.8

    -- title dengan ikon
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -100, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 2)
    title.BackgroundTransparency = 1
    title.Text = "🚀 XuKrost HUB"
    title.TextColor3 = Colors.Text
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    -- close button dengan hover effect
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 25)
    closeBtn.Position = UDim2.new(1, -38, 0, 14)
    closeBtn.Text = "✖"
    closeBtn.BackgroundColor3 = Colors.Danger
    closeBtn.TextColor3 = Colors.Text
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.Parent = header
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
    
    -- Hover effect untuk close button
    closeBtn.MouseEnter:Connect(function()
        closeBtn.BackgroundColor3 = Color3.fromRGB(240, 80, 80)
    end)
    closeBtn.MouseLeave:Connect(function()
        closeBtn.BackgroundColor3 = Colors.Danger
    end)

    -- minimize button dengan hover effect
    local miniBtn = Instance.new("TextButton")
    miniBtn.Size = UDim2.new(0, 30, 0, 25)
    miniBtn.Position = UDim2.new(0, 355, 0, 14)
    miniBtn.Text = "—"
    miniBtn.BackgroundColor3 = Colors.Primary
    miniBtn.TextColor3 = Colors.Text
    miniBtn.Font = Enum.Font.GothamBold
    miniBtn.TextSize = 16
    miniBtn.Parent = header
    Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 6)
    
    -- Hover effect untuk minimize button
    miniBtn.MouseEnter:Connect(function()
        miniBtn.BackgroundColor3 = Color3.fromRGB(100, 140, 240)
    end)
    miniBtn.MouseLeave:Connect(function()
        miniBtn.BackgroundColor3 = Colors.Primary
    end)

    -- bubble button dengan styling yang lebih baik
    local bubbleBtn = Instance.new("TextButton")
    bubbleBtn.Size = UDim2.new(0, 60, 0, 40)
    bubbleBtn.Position = UDim2.new(0, 20, 0.7, 0)
    bubbleBtn.Text = "🚀 XS"
    bubbleBtn.BackgroundColor3 = Colors.Primary
    bubbleBtn.TextColor3 = Colors.Text
    bubbleBtn.Font = Enum.Font.GothamBold
    bubbleBtn.TextSize = 14
    bubbleBtn.Visible = false
    bubbleBtn.Active = true
    bubbleBtn.Draggable = true
    bubbleBtn.Parent = screenGui
    Instance.new("UICorner", bubbleBtn).CornerRadius = UDim.new(0, 10)
    
    local bubbleStroke = Instance.new("UIStroke", bubbleBtn)
    bubbleStroke.Color = Color3.fromRGB(255, 255, 255)
    bubbleStroke.Thickness = 1.5

    -- Container untuk konten utama
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -100, 1, -70)
    contentFrame.Position = UDim2.new(0, 10, 0, 60)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = frame

    -- start/stop button dengan styling modern
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(1, -170, 0, 35)
    toggleBtn.Position = UDim2.new(0, 0, 0, 8)
    toggleBtn.Text = "Start Auto Teleport"
    toggleBtn.BackgroundColor3 = Colors.Secondary
    toggleBtn.TextColor3 = Colors.Text
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 16
    toggleBtn.Parent = contentFrame
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)
    
    local toggleStroke = Instance.new("UIStroke", toggleBtn)
    toggleStroke.Color = Color3.fromRGB(255, 255, 255)
    toggleStroke.Thickness = 1

    -- Auto Respawn toggle button dengan styling modern
    local respawnToggleBtn = Instance.new("TextButton")
    respawnToggleBtn.Size = UDim2.new(1, -170, 0, 35)
    respawnToggleBtn.Position = UDim2.new(0, 0, 0, 51)
    respawnToggleBtn.Text = "Auto Respawn: OFF"
    respawnToggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    respawnToggleBtn.TextColor3 = Colors.Text
    respawnToggleBtn.Font = Enum.Font.GothamBold
    respawnToggleBtn.TextSize = 14
    respawnToggleBtn.Parent = contentFrame
    Instance.new("UICorner", respawnToggleBtn).CornerRadius = UDim.new(0, 8)

    -- delay container dengan layout yang lebih baik
    local delayContainer = Instance.new("Frame")
    delayContainer.Size = UDim2.new(1, 0, 0, 40)
    delayContainer.Position = UDim2.new(0, 0, 0, 110)
    delayContainer.BackgroundTransparency = 1
    delayContainer.Parent = contentFrame

    local delayBox = Instance.new("TextBox")
    delayBox.Size = UDim2.new(0, 80, 1, -9.3)
    delayBox.Position = UDim2.new(0, 79, 0, -15)
    delayBox.PlaceholderText = "Delay"
    delayBox.Text = tostring(currentDelay)
    delayBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    delayBox.TextColor3 = Colors.Text
    delayBox.Font = Enum.Font.Gotham
    delayBox.TextSize = 14
    delayBox.Parent = delayContainer
    Instance.new("UICorner", delayBox).CornerRadius = UDim.new(0, 6)

    local delayLabel = Instance.new("TextLabel")
    delayLabel.Size = UDim2.new(1, -90, 1, 0)
    delayLabel.Position = UDim2.new(0, 20, 0, -19)
    delayLabel.BackgroundTransparency = 1
    delayLabel.Text = "Detik:"
    delayLabel.TextColor3 = Colors.DarkText
    delayLabel.Font = Enum.Font.Gotham
    delayLabel.TextSize = 13
    delayLabel.TextXAlignment = Enum.TextXAlignment.Left
    delayLabel.Parent = delayContainer

    -- scrolling frame untuk manual teleport dengan styling
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -90, 0, 130)
    scrollFrame.Position = UDim2.new(0, 172, 0, 0)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.ScrollBarImageColor3 = Colors.Primary
    scrollFrame.Parent = contentFrame
    Instance.new("UICorner", scrollFrame).CornerRadius = UDim.new(0, 8)

    local layout = Instance.new("UIListLayout", scrollFrame)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local padding = Instance.new("UIPadding", scrollFrame)
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)

    -- manual teleport buttons (SEMUA CHECKPOINT TETAP ADA)
    for _, checkpointName in ipairs(teleportSequence) do
        local checkpointData = CheckPoints[checkpointName]
        if checkpointData then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 35)
            
            -- Gunakan nama checkpoint langsung
            local displayText = checkpointName
            btn.Text = "" .. displayText
            btn.BackgroundColor3 = Colors.Primary
            btn.TextColor3 = Colors.Text
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 13
            btn.Parent = scrollFrame
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            
            -- Hover effect untuk tombol manual
            btn.MouseEnter:Connect(function()
                btn.BackgroundColor3 = Color3.fromRGB(100, 140, 240)
            end)
            btn.MouseLeave:Connect(function()
                btn.BackgroundColor3 = Colors.Primary
            end)

            btn.MouseButton1Click:Connect(function()
                local cp = CheckPoints[checkpointName]
                humanoidRootPart.CFrame = CFrame.new(cp.x, cp.y, cp.z)
            end)
        end
    end

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    -- Container untuk status dan Discord button
    local bottomContainer = Instance.new("Frame")
    bottomContainer.Size = UDim2.new(1, -106, 0, 30)
    bottomContainer.Position = UDim2.new(0, 180, 1, -29)
    bottomContainer.BackgroundTransparency = 1
    bottomContainer.Parent = contentFrame

    -- status script dengan styling yang lebih baik
    local statusContainer = Instance.new("Frame")
    statusContainer.Size = UDim2.new(0.6, -5, 1, 0)
    statusContainer.Position = UDim2.new(0, 0, 0, 0)
    statusContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    statusContainer.BorderSizePixel = 0
    statusContainer.Parent = bottomContainer
    Instance.new("UICorner", statusContainer).CornerRadius = UDim.new(0, 8)

    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, -10, 1, 0)
    statusText.Position = UDim2.new(0, 5, 0, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "Status: Ready"
    statusText.TextColor3 = Colors.Secondary
    statusText.TextSize = 13
    statusText.Font = Enum.Font.Gotham
    statusText.TextXAlignment = Enum.TextXAlignment.Left
    statusText.Parent = statusContainer

    -- Discord button di sebelah status
    local discordBtn = Instance.new("TextButton")
    discordBtn.Size = UDim2.new(0.4, -5, 1, 0)
    discordBtn.Position = UDim2.new(0.6, 5, 0, 0)
    discordBtn.Text = "Discord"
    discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- Warna Discord
    discordBtn.TextColor3 = Colors.Text
    discordBtn.Font = Enum.Font.GothamBold
    discordBtn.TextSize = 13
    discordBtn.Parent = bottomContainer
    Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0, 8)

    -- Hover effect untuk Discord button
    discordBtn.MouseEnter:Connect(function()
        discordBtn.BackgroundColor3 = Color3.fromRGB(108, 121, 262)
    end)
    discordBtn.MouseLeave:Connect(function()
        discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    end)

    -- Event handler untuk Discord button
    discordBtn.MouseButton1Click:Connect(function()
        local discordLink = "https://discord.gg/RpYcMdzzwd"
        
        -- Copy ke clipboard jika memungkinkan
        pcall(function()
            setclipboard(discordLink)
        end)
        
        -- Tampilkan notifikasi
        statusText.Text = "Discord link copied!"
        statusText.TextColor3 = Colors.Primary
        
        -- Reset status setelah beberapa detik
        task.wait(3)
        if isAutoTeleporting then
            statusText.Text = "Status: Running..."
            statusText.TextColor3 = Colors.Warning
        else
            statusText.Text = "Status: Ready"
            statusText.TextColor3 = Colors.Secondary
        end
    end)

    -- Event handler close & minimize
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        isAutoTeleporting = false
    end)

    miniBtn.MouseButton1Click:Connect(function()
        frame.Visible = false
        bubbleBtn.Visible = true
    end)

    bubbleBtn.MouseButton1Click:Connect(function()
        frame.Visible = true
        bubbleBtn.Visible = false
    end)

    -- Update delay ketika textbox berubah
    delayBox.FocusLost:Connect(function(enterPressed)
        local val = tonumber(delayBox.Text)
        if val and val > 0 then
            currentDelay = val
        else
            delayBox.Text = tostring(currentDelay)
        end
    end)

    return {
        toggleBtn = toggleBtn,
        respawnToggleBtn = respawnToggleBtn,
        statusText = statusText
    }
end

local GUI = CreateGUI()

-- teleport function 
local function EnsureCharacterReady()
    character = player.Character or player.CharacterAdded:Wait()
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    return humanoidRootPart
end

local function TeleportToCheckpoint(name)
    local checkpoint = CheckPoints[name]
    if not checkpoint then return false end
    local rootPart = EnsureCharacterReady()
    rootPart.CFrame = CFrame.new(checkpoint.x, checkpoint.y, checkpoint.z)
    return true
end

-- teleport loop YANG DIUBAH: langsung ke Puncak dari Spawn
local function AutoTeleport()
    while isAutoTeleporting and RunService.Heartbeat:Wait() do
        -- Teleport langsung dari Spawn ke Puncak (tidak melalui semua checkpoint)
        GUI.statusText.Text = "Status: Teleport langsung ke Puncak"
        GUI.statusText.TextColor3 = Colors.Warning
        
        -- Pastikan di Spawn dulu
        TeleportToCheckpoint("Pos - 50")
        task.wait(1) -- Tunggu sebentar sebelum teleport ke Puncak
        
        -- Teleport langsung ke Puncak
        TeleportToCheckpoint("Puncak")
        
        -- Cek jika sampai di Puncak dan Auto Respawn aktif
        if isAutoRespawnEnabled then
            GUI.statusText.Text = "Status: Summit Reached, Auto respawn 2s"
            GUI.statusText.TextColor3 = Colors.Danger
            task.wait(2)
            
            -- Respawn karakter
            character:BreakJoints()
            GUI.statusText.Text = "Status: Respawn success, restarting loop..."
            task.wait(1)
            
            -- Tunggu karakter respawn
            character = player.CharacterAdded:Wait()
            humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            task.wait(1)
        else
            -- Jika auto respawn tidak aktif, tunggu delay dan stop loop
            for _ = 1, currentDelay do
                if not isAutoTeleporting then break end
                task.wait(1)
            end
            break -- Keluar dari loop jika auto respawn tidak aktif
        end
    end
    
    if not isAutoTeleporting then
        GUI.statusText.Text = "Status: Auto Teleport Berhenti"
        GUI.statusText.TextColor3 = Colors.Danger
        GUI.toggleBtn.Text = "Start Auto Teleport"
        GUI.toggleBtn.BackgroundColor3 = Colors.Secondary
    end
end

-- start stop
GUI.toggleBtn.MouseButton1Click:Connect(function()
    if not isAutoTeleporting then
        isAutoTeleporting = true
        GUI.toggleBtn.Text = "Stop Auto Teleport"
        GUI.toggleBtn.BackgroundColor3 = Colors.Danger
        task.spawn(AutoTeleport)
    else
        isAutoTeleporting = false
        GUI.toggleBtn.Text = "Start Auto Teleport"
        GUI.toggleBtn.BackgroundColor3 = Colors.Secondary
    end
end)

-- Auto Respawn toggle
GUI.respawnToggleBtn.MouseButton1Click:Connect(function()
    isAutoRespawnEnabled = not isAutoRespawnEnabled
    if isAutoRespawnEnabled then
        GUI.respawnToggleBtn.Text = "Auto Respawn: ON"
        GUI.respawnToggleBtn.BackgroundColor3 = Colors.Secondary
    else
        GUI.respawnToggleBtn.Text = "Auto Respawn: OFF"
        GUI.respawnToggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    end
end)

-- Respawn event - restart auto teleport jika sedang aktif
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    
    if isAutoTeleporting and isAutoRespawnEnabled then
        GUI.statusText.Text = "Status: Respawn terdeteksi, melanjutkan loop..."
        GUI.statusText.TextColor3 = Colors.Primary
        task.wait(1)
        -- Auto teleport akan melanjutkan loop secara otomatis
    else
        GUI.statusText.Text = "Status: Respawn terdeteksi"
        GUI.statusText.TextColor3 = Colors.Primary
        isAutoTeleporting = false
        GUI.toggleBtn.Text = "Start Auto Teleport"
        GUI.toggleBtn.BackgroundColor3 = Colors.Secondary
    end
end)

print("✅ XuKrost Hub Successfully loaded! have fun!")