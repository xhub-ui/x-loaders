local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- checkpoint
local CheckPoints = {
    Spawn = {x = 237, y = -475, z = -2257},
    ["Pos - 1"] = {x = 121, y = -421, z = -1934},
    ["Pos - 2"] = {x = -244, y = -417, z = -1871},
    ["Pos - 3"] = {x = -161, y = -423, z = -1708},
    ["Pos - 4"] = {x = -372, y = -360, z = -1793},
    ["Pos - 5"] = {x = -113, y = -319, z = -1821},
    ["Pos - 6"] = {x = -451, y = -304, z = -1716},
    ["Pos - 7"] = {x = -485, y = -216, z = -1650},
    ["Pos - 8"] = {x = -376, y = -252, z = -1904},
    ["Pos - 9"] = {x = -158, y = -174, z = -1497},
    ["Pos - 10"] = {x = 217, y = -59, z = -1409},
    ["Pos - 11"] = {x = 350, y = 20, z = -1431},
    ["Pos - 12"] = {x = -2, y = 267, z = -1314},
    ["Pos - 13"] = {x = -106, y = 432, z = -1394},
    ["Pos - 14"] = {x = -38, y = 626, z = -797},
    ["Pos - 15"] = {x = -160, y = 712, z = -667},
    ["Pos - 16"] = {x = -23, y = 754, z = -797},
    ["Pos - 17"] = {x = 4, y = 885, z = -689},
    ["Pos - 18"] = {x = 117, y = 888, z = -393},
    ["Puncak"] = {x = 309, y = 1233, z = 89},
    BackToBaseCamp = {x = 353, y = 1232, z = 226}
}

local isAutoTeleporting = false
local isAutoRespawnEnabled = false
local currentDelay = 3
local teleportSequence = {"Spawn", "Pos - 1", "Pos - 2", "Pos - 3", "Pos - 4", "Pos - 5", "Pos - 6", "Pos - 7", "Pos - 8", "Pos - 9", "Pos - 10", "Pos - 11", "Pos - 12", "Pos - 13", "Pos - 14", "Pos - 15", "Pos - 16", "Pos - 17", "Pos - 18", "Puncak", "BackToBaseCamp"}

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

-- NEW: Function to kill player dengan berbagai metode
local function KillPlayer()
    local success, result = pcall(function()
        -- Method 1: Break torso connection (cara klasik)
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.Health = 0
        end
        
        -- Method 2: Fall damage
        if humanoidRootPart then
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, -500, 0)
        end
        
        -- Method 3: Remove respawn cooldown dan panggil respawn
        if character and character:FindFirstChild("Humanoid") then
            -- Force respawn dengan berbagai cara
            character:BreakJoints()
            
            -- Alternative: Gunakan teleport ke kill brick jika ada
            local killBrick = workspace:FindFirstChild("KillBrick") or workspace:FindFirstChild("DeathPart")
            if killBrick then
                humanoidRootPart.CFrame = killBrick.CFrame
            end
        end
        
        return true
    end)
    
    if not success then
        -- Alternative method yang lebih agresif
        pcall(function()
            game:GetService("Players").LocalPlayer.Character:BreakJoints()
        end)
    end
end

-- NEW: Function to set BasecampTeleport Active and Visible
local function SetBasecampTeleportState(active, visible)
    local success, result = pcall(function()
        local screenGui = player.PlayerGui:FindFirstChild("ScreenGui")
        if screenGui then
            local basecampFrame = screenGui:FindFirstChild("BasecampTeleport")
            if basecampFrame then
                basecampFrame.Active = active
                basecampFrame.Visible = visible
                return true
            end
        end
        return false
    end)
    
    if not success then
        -- Alternative method
        pcall(function()
            local basecampFrame = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.BasecampTeleport
            basecampFrame.Active = active
            basecampFrame.Visible = visible
        end)
    end
end

-- NEW: Function to click BasecampTeleport button dengan pengaturan state dan auto kill
local function ClickBasecampTeleport()
    local clicked = false
    
    local success, result = pcall(function()
        -- Mencari BasecampTeleport GUI
        local screenGui = player.PlayerGui:FindFirstChild("ScreenGui")
        if screenGui then
            local basecampFrame = screenGui:FindFirstChild("BasecampTeleport")
            if basecampFrame then
                local yesButton = basecampFrame:FindFirstChild("YesButton")
                if yesButton then
                    -- Trigger the button click using firesignal
                    firesignal(yesButton.MouseButton1Click)
                    
                    -- Setelah berhasil klik, matikan Active dan Visible
                    SetBasecampTeleportState(false, false)
                    clicked = true
                    
                    -- NEW: Delay 3 detik kemudian kill player
                    task.delay(3, function()
                        if isAutoRespawnEnabled and isAutoTeleporting then
                            GUI.statusText.Text = "Status: Auto killing player..."
                            GUI.statusText.TextColor3 = Colors.Danger
                            KillPlayer()
                        end
                    end)
                    
                    return true
                end
            end
        end
        return false
    end)
    
    if success and result then
        return clicked
    else
        -- Alternative method if the first one fails
        local success2, result2 = pcall(function()
            local yesb = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.BasecampTeleport.YesButton
            firesignal(yesb.MouseButton1Click)
            
            -- Setelah berhasil klik, matikan Active dan Visible
            SetBasecampTeleportState(false, false)
            clicked = true
            
            -- NEW: Delay 3 detik kemudian kill player
            task.delay(3, function()
                if isAutoRespawnEnabled and isAutoTeleporting then
                    GUI.statusText.Text = "Status: Auto killing player..."
                    GUI.statusText.TextColor3 = Colors.Danger
                    KillPlayer()
                end
            end)
            
            return true
        end)
        return success2 and result2 and clicked
    end
end

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
    respawnToggleBtn.Text = "Auto Basecamp: OFF"
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

    -- manual teleport buttons dengan urutan yang benar
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

-- NEW: Infinite teleport loop function dengan BasecampTeleport dan auto kill
local function InfiniteTeleportLoop()
    local loopCount = 0
    
    while isAutoTeleporting do
        loopCount += 1
        GUI.statusText.Text = "Status: Loop " .. loopCount
        GUI.statusText.TextColor3 = Colors.Primary
        
        -- Teleport melalui semua checkpoint dalam satu loop
        for _, checkpoint in ipairs(teleportSequence) do
            if not isAutoTeleporting then break end
            
            GUI.statusText.Text = "Status: Teleport ke " .. checkpoint .. " (Loop " .. loopCount .. ")"
            GUI.statusText.TextColor3 = Colors.Warning
            
            local success = TeleportToCheckpoint(checkpoint)
            
            if not success then
                GUI.statusText.Text = "Status: Gagal teleport ke " .. checkpoint
                GUI.statusText.TextColor3 = Colors.Danger
                break
            end
            
            -- NEW: Jika sampai di BackToBaseCamp dan Auto Basecamp aktif
            if checkpoint == "BackToBaseCamp" and isAutoRespawnEnabled then
                GUI.statusText.Text = "Status: Summit Reached, Activating Basecamp GUI (Loop " .. loopCount .. ")"
                GUI.statusText.TextColor3 = Colors.Danger
                
                -- Tunggu sebentar sebelum BasecampTeleport muncul
                task.wait(1)
                
                -- NEW: Aktifkan BasecampTeleport GUI selama 2 detik
                SetBasecampTeleportState(true, true)
                GUI.statusText.Text = "Status: Basecamp GUI Activated (Loop " .. loopCount .. ")"
                GUI.statusText.TextColor3 = Colors.Warning
                
                -- Tunggu 2 detik untuk memastikan GUI muncul
                task.wait(2)
                
                -- Click BasecampTeleport button (fungsi ini akan otomatis mematikan GUI setelah berhasil dan kill player setelah 3 detik)
                local clickSuccess = ClickBasecampTeleport()
                
                if clickSuccess then
                    GUI.statusText.Text = "Status: Basecamp clicked! Auto kill in 3s (Loop " .. loopCount .. ")"
                    GUI.statusText.TextColor3 = Colors.Secondary
                    
                    -- Tunggu proses teleport selesai + delay kill
                    task.wait(6) -- 3 detik delay kill + 3 detik untuk respawn
                    
                    -- Pastikan karakter sudah respawn di spawn point
                    character = player.CharacterAdded:Wait()
                    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                    
                    GUI.statusText.Text = "Status: Respawned at spawn (Loop " .. loopCount .. ")"
                else
                    GUI.statusText.Text = "Status: Gagal click Basecamp, Hiding GUI (Loop " .. loopCount .. ")"
                    GUI.statusText.TextColor3 = Colors.Danger
                    
                    -- Jika gagal klik, tetap matikan GUI setelah 2 detik
                    SetBasecampTeleportState(false, false)
                end
            else
                -- Delay normal antar checkpoint (kecuali checkpoint terakhir dengan auto basecamp)
                if checkpoint ~= "BackToBaseCamp" or not isAutoRespawnEnabled then
                    for i = 1, currentDelay do
                        if not isAutoTeleporting then break end
                        GUI.statusText.Text = "Status: Delay " .. i .. "/" .. currentDelay .. "s (Loop " .. loopCount .. ")"
                        task.wait(1)
                    end
                end
            end
        end
        
        -- Jika masih aktif, loop akan berlanjut secara otomatis
        if isAutoTeleporting then
            GUI.statusText.Text = "Status: Loop " .. loopCount .. " selesai, memulai loop berikutnya..."
            GUI.statusText.TextColor3 = Colors.Secondary
            task.wait(1) -- Delay kecil sebelum memulai loop berikutnya
        end
    end
    
    -- Cleanup ketika loop dihentikan
    GUI.statusText.Text = "Status: Auto Teleport Berhenti"
    GUI.statusText.TextColor3 = Colors.Danger
    GUI.toggleBtn.Text = "Start Auto Teleport"
    GUI.toggleBtn.BackgroundColor3 = Colors.Secondary
end

-- start stop - menggunakan infinite loop sekarang
GUI.toggleBtn.MouseButton1Click:Connect(function()
    if not isAutoTeleporting then
        isAutoTeleporting = true
        GUI.toggleBtn.Text = "Stop Auto Teleport"
        GUI.toggleBtn.BackgroundColor3 = Colors.Danger
        GUI.statusText.Text = "Status: Memulai infinite loop..."
        GUI.statusText.TextColor3 = Colors.Warning
        
        -- Start the infinite loop
        task.spawn(InfiniteTeleportLoop)
    else
        isAutoTeleporting = false
        GUI.toggleBtn.Text = "Start Auto Teleport"
        GUI.toggleBtn.BackgroundColor3 = Colors.Secondary
        GUI.statusText.Text = "Status: Menghentikan loop..."
        GUI.statusText.TextColor3 = Colors.Danger
    end
end)

-- Auto Basecamp toggle (menggantikan Auto Respawn)
GUI.respawnToggleBtn.MouseButton1Click:Connect(function()
    isAutoRespawnEnabled = not isAutoRespawnEnabled
    if isAutoRespawnEnabled then
        GUI.respawnToggleBtn.Text = "Auto Basecamp: ON"
        GUI.respawnToggleBtn.BackgroundColor3 = Colors.Secondary
        GUI.statusText.Text = "Status: Auto Basecamp diaktifkan"
        GUI.statusText.TextColor3 = Colors.Secondary
    else
        GUI.respawnToggleBtn.Text = "Auto Basecamp: OFF"
        GUI.respawnToggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
        GUI.statusText.Text = "Status: Auto Basecamp dimatikan"
        GUI.statusText.TextColor3 = Colors.Danger
    end
    
    -- Reset status setelah beberapa detik
    task.wait(2)
    if isAutoTeleporting then
        GUI.statusText.Text = "Status: Running infinite loop..."
        GUI.statusText.TextColor3 = Colors.Warning
    else
        GUI.statusText.Text = "Status: Ready"
        GUI.statusText.TextColor3 = Colors.Secondary
    end
end)

-- Respawn event handler
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    
    if isAutoTeleporting then
        GUI.statusText.Text = "Status: Respawn terdeteksi, melanjutkan loop..."
        GUI.statusText.TextColor3 = Colors.Primary
    else
        GUI.statusText.Text = "Status: Respawn terdeteksi"
        GUI.statusText.TextColor3 = Colors.Primary
    end
end)

print("✅ XuKrost Hub Successfully loaded! have fun")