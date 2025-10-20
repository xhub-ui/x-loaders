-- XuKrost Hub | By noirexe (Enhanced + Tabs + Search + Manual Tab Position + Mini Control Bar + Bubble Minimize + Dividers + Console + Teleport Manager + VIP System + Player Info + Key System)
-- LocalScript (StarterGui)

-- CONFIG
local HubName = "XuKrost Hub"
local CreatorText = "By noirexe"

-- VIP Configuration
local VIP_LIST_URL = "https://raw.githubusercontent.com/xhub-ui/x-loaders/refs/heads/main/loader/redirects/vip-system/vip-users.txt"
local KEY_LIST_URL = "https://raw.githubusercontent.com/xhub-ui/x-loaders/refs/heads/main/loader/redirects/free-keys/key.txt"
local playerUserId = game:GetService("Players").LocalPlayer.UserId

-- Scripts data dengan kategori Free dan VIP
local scripts = {
["Player Info"] = {}, 
["Main Scripts"] = {
["Free"] = {
["Mount Jawa"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsJawa.lua", 
["Expedition-Parvata"]  = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/ExParvata.lua", 
["Mount Ckptw"]  = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsCkptw.lua", 
["Mount Kawai"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsKawai.lua", 
["Mount Bohong"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsBohong.lua", 
["Mount Papua"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsPapua.lua", 
["Mount Bayii"]  = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsBayi.lua", 
["Mount Hts"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsHts.lua"
},
["VIP"] = {
["Mount Malang"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsMalang.lua",
["Fish it - Tested"] = "https://github.com/xhub-ui/neutral-efx/raw/refs/heads/main/loader.lua",
["Mount Mono"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsMono.lua",
["Mount Bingung"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsBingung.lua",
["Mount Imut"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsImut.lua",
["Mount Cow"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsCow.lua",
["Mount Lembayana"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsLembayana.lua",
["Mount Pengangguran"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsPengangguran.lua",
["Mount Darmandir"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsDarmandir.lua",
["Mount Sakahayang"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsSakahayang.lua",
["Mount Mulu"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsMulu.lua",
["Mount Malaikat"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsMalaikat.lua",
["Puncak Blonde"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsBlonde.lua",
["Mount Pedaunan"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsPedaunan.lua",
["Mount Akhirat"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsAkhirat.lua",
["Mount Yahayuk"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsYahayuk.lua",
["Mount Atin"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsAtin.lua",
["Indo Hangout Beta"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/other-scripts/inh.lua",
["Mount Sumbing"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsSumbing.lua",
["Mount Yareu"] = "https://github.com/xhub-ui/x-loaders/raw/refs/heads/main/loader/main-scripts/MountsYareu.lua"
}
},
["Extra Tools"] = {
["Movement Controls"] = "movement_controls_internal",
["Fly"] = "https://raw.githubusercontent.com/noirexe/GYkHTrZSc5W/refs/heads/main/sc-free-ko-dijual-awoakowk.lua",
["Remove Network Pause"] = "remove_network_pause_internal",
["Private Server"] = "https://paste.monster/Zptmb376pEA9/raw"
},
["Own Script"] = {},
["Console"] = {},
["Credits"] = {
["Copy Creator Info"] = "copy_creator_info",
["Join Discord"] = "https://discord.gg/RpYcMdzzwd",
["Copy Contributor Info"] = "copy_contributor_info"
}
}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- VIP System Variables
local isVIP = false
local vipList = {}
local vipCheckCompleted = false

-- Key System Variables
local keyAccepted = false
local keyChecked = false
local validKeys = {}
local keyGui = nil

-- Movement Controls Variables
local WalkSpeedValue = 16
local JumpPowerValue = 50
local infJump = false

-- Teleport Manager Variables
local teleportLocations = {}
local TELEPORT_DATA_KEY = "XuKrostHub_TeleportData"
local teleportPresets = {}
local currentPresetName = ""

-- FIX: Store original frame size
local ORIGINAL_FRAME_SIZE = UDim2.new(0, 500, 0, 305)

-- UTIL: notifications
local function notify(title, text, duration)
    duration = duration or 4
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title=title,Text=text,Duration=duration})
    end)
end

-- UTIL: HTTP + run
local function httpGet(url)
    local ok, res = pcall(function() return game:HttpGet(url, true) end)
    if ok and res then return true, res end
    return false, "HttpGet failed"
end

local function fetchAndRun(url)
    local ok, body = httpGet(url)
    if not ok then return false, body end
    local f, err = loadstring(body)
    if not f then return false, "Compile error: "..tostring(err) end
    local ok2, runErr = pcall(f)
    if not ok2 then return false, "Runtime error: "..tostring(runErr) end
    return true, "Executed"
end

-- UTIL: Copy to clipboard
local function copyToClipboard(text)
    local success, result = pcall(function()
        setclipboard(text)
    end)
    return success
end

-- VIP System Functions
local function loadVIPList()
    local success, data = httpGet(VIP_LIST_URL)
    if success then
        vipList = {}
        for line in data:gmatch("[^\r\n]+") do
            local userId = tonumber(line:match("^%s*(%d+)%s*$"))
            if userId then
                vipList[userId] = true
            end
        end
        return true
    end
    return false
end

local function checkVIPStatus()
    if vipCheckCompleted then return isVIP end
    
    local success = loadVIPList()
    if success then
        isVIP = vipList[playerUserId] or false
        vipCheckCompleted = true
        return isVIP
    else
        -- Jika gagal load VIP list, anggap bukan VIP
        isVIP = false
        vipCheckCompleted = true
        return false
    end
end

local function refreshVIPStatus(consoleOutput)
    vipCheckCompleted = false
    local wasVIP = isVIP
    checkVIPStatus()
    
    if consoleOutput then
        if isVIP then
            consoleOutput.Text = consoleOutput.Text .. ">> VIP Status: ACTIVE (User ID: " .. playerUserId .. ")\n"
            notify("VIP System", "VIP Status Verified!", 3)
        else
            consoleOutput.Text = consoleOutput.Text .. ">> VIP Status: INACTIVE (User ID: " .. playerUserId .. ")\n"
            if wasVIP then
                notify("VIP System", "VIP Status Expired!", 3)
            end
        end
    end
end

-- Key System Functions
local function loadValidKeys()
    local success, data = httpGet(KEY_LIST_URL)
    if success then
        validKeys = {}
        for line in data:gmatch("[^\r\n]+") do
            local key = line:match("^%s*(.-)%s*$")
            if key and key ~= "" then
                validKeys[key] = true
            end
        end
        return true
    end
    return false
end

local function validateKey(inputKey)
    -- Trim whitespace dari input
    local trimmedKey = inputKey:gsub("^%s*(.-)%s*$", "%1")
    
    -- Check jika key ada dalam daftar valid keys
    return validKeys[trimmedKey] == true
end

local function showKeyNotification(text)
    local notifGui = Instance.new("ScreenGui", game.CoreGui)
    notifGui.Name = "KeyNotifGui"
    local frame = Instance.new("Frame", notifGui)
    frame.Size = UDim2.fromOffset(200, 40)
    frame.Position = UDim2.new(1, -210, 1, -50)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.ZIndex = 10
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 8)
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -10, 1, -10)
    label.Position = UDim2.fromOffset(5, 5)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.new(1,1,1)
    label.Text = text
    label.TextWrapped = true
    label.ZIndex = 11

    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 0})
    tweenIn:Play()
    delay(2, function()
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 1})
        tweenOut:Play()
        tweenOut.Completed:Wait()
        notifGui:Destroy()
    end)
end

local function showKeySystem()
    -- Jika GUI key system sudah ada, hancurkan dulu
    if keyGui and keyGui.Parent then
        keyGui:Destroy()
        keyGui = nil
    end
    
    -- Load valid keys terlebih dahulu
    local keysLoaded = loadValidKeys()
    if not keysLoaded then
        showKeyNotification("Failed to load key list")
        return false
    end
    
    -- Buat GUI key system baru
    keyGui = Instance.new("ScreenGui", game.CoreGui)
    keyGui.Name = "KeyGui"
    keyGui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame", keyGui)
    frame.Size = UDim2.fromOffset(300, 140)
    frame.Position = UDim2.new(0.5, -150, 0.4, -70)
    frame.BackgroundColor3 = Color3.fromRGB(31,31,53)
    frame.BorderSizePixel = 0
    frame.ZIndex = 1
    
    local function corner(o) 
        local c = Instance.new("UICorner", o)
        c.CornerRadius = UDim.new(0,10)
        return c
    end
    corner(frame)
    
    local closeBtn = Instance.new("TextButton", frame)
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -28, 0, 4)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.BackgroundColor3 = Color3.fromRGB(170, 65, 65)
    closeBtn.BackgroundTransparency = 0.1
    corner(closeBtn)
    
    -- FIX: Reset keyChecked ketika tombol close ditekan
    closeBtn.MouseButton1Click:Connect(function()
        if keyGui then
            keyGui:Destroy()
            keyGui = nil
        end
        -- Reset keyChecked agar GUI bisa muncul lagi
        keyChecked = false
        appendToConsole(">> Key system closed. GUI will appear again on next click.\n")
    end)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -60, 0, 30)
    title.Position = UDim2.fromOffset(10, 10)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextColor3 = Color3.new(1,1,1)
    title.Text = "XuKrost Hub - Key System"
    
    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(1, -20, 0, 30)
    input.Position = UDim2.fromOffset(10, 50)
    input.PlaceholderText = "Enter your key"
    input.Text = ""
    input.TextSize = 16
    input.Font = Enum.Font.Gotham
    input.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    input.BackgroundTransparency = 0.2
    input.TextColor3 = Color3.new(1,1,1)
    corner(input)
    
    local submitBtn = Instance.new("TextButton", frame)
    submitBtn.Size = UDim2.new(0.5, -15, 0, 30)
    submitBtn.Position = UDim2.fromOffset(10, 90)
    submitBtn.Text = "Submit"
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 14
    submitBtn.BackgroundColor3 = Color3.fromRGB(65, 150, 80)
    submitBtn.BackgroundTransparency = 0.1
    submitBtn.TextColor3 = Color3.new(1,1,1)
    corner(submitBtn)
    
    local getKeyBtn = Instance.new("TextButton", frame)
    getKeyBtn.Size = UDim2.new(0.5, -15, 0, 30)
    getKeyBtn.Position = UDim2.new(0.5, 5, 0, 90)
    getKeyBtn.Text = "Get Key"
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.TextSize = 14
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(65, 120, 200)
    getKeyBtn.BackgroundTransparency = 0.1
    getKeyBtn.TextColor3 = Color3.new(1,1,1)
    corner(getKeyBtn)
    
    submitBtn.MouseButton1Click:Connect(function()
        if validateKey(input.Text) then
            keyAccepted = true
            keyChecked = true
            if keyGui then
                keyGui:Destroy()
                keyGui = nil
            end
            showKeyNotification("Key valid! Access granted.")
            appendToConsole(">> Key validated successfully!\n")
        else
            showKeyNotification("Invalid Key")
            appendToConsole(">> Invalid key entered: " .. input.Text .. "\n")
            -- FIX: Jangan set keyChecked ke true jika key invalid
            -- Biarkan keyChecked tetap false agar user bisa mencoba lagi
        end
    end)
    
    getKeyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("@snn2ndd_")
            showKeyNotification("Instagram link copied!")
            appendToConsole(">> Instagram link copied to clipboard\n")
        else
            showKeyNotification("Copy failed")
            appendToConsole(">> Failed to copy username ig\n")
        end
    end)
    
    -- Dragging functionality
    local drag, startPos, origPos
    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or
           i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            startPos = i.Position
            origPos = frame.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    drag = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or
                     i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - startPos
            frame.Position = UDim2.new(
                origPos.X.Scale, origPos.X.Offset + delta.X,
                origPos.Y.Scale, origPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Focus pada input box
    input:CaptureFocus()
    
    return true
end

local function checkKeyStatus()
    -- Jika user adalah VIP, otomatis skip key system
    if isVIP then
        keyAccepted = true
        keyChecked = true
        return true
    end
    
    -- Jika key sudah diterima, langsung return true
    if keyAccepted then
        return true
    end
    
    -- FIX: Selalu tampilkan key system jika key belum diterima
    -- Tidak perlu cek keyChecked lagi
    local success = showKeySystem()
    if not success then
        showKeyNotification("Failed to load key system")
        return false
    end
    
    return keyAccepted
end

-- Teleport Manager Functions
local function saveTeleportData()
    local dataToSave = {}
    for name, location in pairs(teleportLocations) do
        dataToSave[name] = {
            X = location.X,
            Y = location.Y,
            Z = location.Z
        }
    end
    
    local jsonData = HttpService:JSONEncode(dataToSave)
    writefile(TELEPORT_DATA_KEY .. ".json", jsonData)
    return true
end

local function loadTeleportData()
    local success, data = pcall(function()
        if isfile(TELEPORT_DATA_KEY .. ".json") then
            local jsonData = readfile(TELEPORT_DATA_KEY .. ".json")
            return HttpService:JSONDecode(jsonData)
        end
    end)
    
    if success and data then
        teleportLocations = {}
        for name, posData in pairs(data) do
            teleportLocations[name] = Vector3.new(posData.X, posData.Y, posData.Z)
        end
        return true
    end
    return false
end

-- NEW: Enhanced Teleport Preset System
local function saveTeleportPreset(presetName)
    if not presetName or presetName:gsub("%s+", "") == "" then
        return false, "Preset name cannot be empty!"
    end
    
    if not teleportLocations or next(teleportLocations) == nil then
        return false, "No teleport locations to save!"
    end
    
    local success, result = pcall(function()
        -- Load existing presets
        local allPresets = {}
        if isfile(TELEPORT_DATA_KEY .. "_presets.json") then
            local existingData = readfile(TELEPORT_DATA_KEY .. "_presets.json")
            allPresets = HttpService:JSONDecode(existingData)
        end
        
        -- Save current teleport locations to preset
        allPresets[presetName] = {}
        for name, location in pairs(teleportLocations) do
            allPresets[presetName][name] = {
                X = location.X,
                Y = location.Y,
                Z = location.Z
            }
        end
        
        -- Save to file
        local jsonData = HttpService:JSONEncode(allPresets)
        writefile(TELEPORT_DATA_KEY .. "_presets.json", jsonData)
        return true
    end)
    
    if success then
        teleportPresets = allPresets
        currentPresetName = presetName
        return true, "Preset '" .. presetName .. "' saved successfully!"
    else
        return false, "Failed to save preset: " .. tostring(result)
    end
end

local function loadTeleportPreset(presetName)
    if not presetName then
        return false, "No preset selected!"
    end
    
    local success, result = pcall(function()
        if not isfile(TELEPORT_DATA_KEY .. "_presets.json") then
            return false, "No presets found!"
        end
        
        local jsonData = readfile(TELEPORT_DATA_KEY .. "_presets.json")
        local allPresets = HttpService:JSONDecode(jsonData)
        
        if not allPresets[presetName] then
            return false, "Preset '" .. presetName .. "' not found!"
        end
        
        -- Load the selected preset
        teleportLocations = {}
        for name, posData in pairs(allPresets[presetName]) do
            teleportLocations[name] = Vector3.new(posData.X, posData.Y, posData.Z)
        end
        
        teleportPresets = allPresets
        currentPresetName = presetName
        return true
    end)
    
    if success then
        return true, "Preset '" .. presetName .. "' loaded successfully!"
    else
        return false, "Failed to load preset: " .. tostring(result)
    end
end

local function getAvailablePresets()
    local success, result = pcall(function()
        if not isfile(TELEPORT_DATA_KEY .. "_presets.json") then
            return {}
        end
        
        local jsonData = readfile(TELEPORT_DATA_KEY .. "_presets.json")
        local allPresets = HttpService:JSONDecode(jsonData)
        
        local presetNames = {}
        for name, _ in pairs(allPresets) do
            table.insert(presetNames, name)
        end
        table.sort(presetNames)
        return presetNames
    end)
    
    if success then
        return result
    else
        return {}
    end
end

local function deleteTeleportPreset(presetName)
    if not presetName then
        return false, "No preset selected!"
    end
    
    local success, result = pcall(function()
        if not isfile(TELEPORT_DATA_KEY .. "_presets.json") then
            return false, "No presets found!"
        end
        
        local jsonData = readfile(TELEPORT_DATA_KEY .. "_presets.json")
        local allPresets = HttpService:JSONDecode(jsonData)
        
        if not allPresets[presetName] then
            return false, "Preset '" .. presetName .. "' not found!"
        end
        
        -- Remove the preset
        allPresets[presetName] = nil
        teleportPresets = allPresets
        
        -- Save updated presets
        local updatedJsonData = HttpService:JSONEncode(allPresets)
        writefile(TELEPORT_DATA_KEY .. "_presets.json", updatedJsonData)
        
        -- If current preset was deleted, clear current locations
        if currentPresetName == presetName then
            teleportLocations = {}
            currentPresetName = ""
        end
        
        return true
    end)
    
    if success then
        return true, "Preset '" .. presetName .. "' deleted successfully!"
    else
        return false, "Failed to delete preset: " .. tostring(result)
    end
end

local function teleportToPosition(position)
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(position)
        return true
    end
    return false
end

local function getCurrentPosition()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        return character.HumanoidRootPart.Position
    end
    return nil
end

local function refreshTeleportList(scrollFrame, consoleOutput)
    -- Clear existing teleport entries
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") and child.Name == "TeleportEntry" then
            child:Destroy()
        end
    end
    
    -- Add saved locations
    local entryHeight = 35
    local padding = 5
    local totalHeight = 0
    
    for name, position in pairs(teleportLocations) do
        local entryFrame = Instance.new("Frame", scrollFrame)
        entryFrame.Size = UDim2.new(1, -10, 0, entryHeight)
        entryFrame.Position = UDim2.new(0, 5, 0, totalHeight)
        entryFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
        entryFrame.BorderSizePixel = 0
        entryFrame.Name = "TeleportEntry"
        Instance.new("UICorner", entryFrame).CornerRadius = UDim.new(0, 6)
        
        -- Name and Position Info
        local infoFrame = Instance.new("Frame", entryFrame)
        infoFrame.Size = UDim2.new(0.6, -5, 1, 0)
        infoFrame.Position = UDim2.new(0, 5, 0, 0)
        infoFrame.BackgroundTransparency = 1
        
        local nameLabel = Instance.new("TextLabel", infoFrame)
        nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.Text = name
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Font = Enum.Font.GothamSemibold
        nameLabel.TextSize = 12
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local posLabel = Instance.new("TextLabel", infoFrame)
        posLabel.Size = UDim2.new(1, 0, 0.4, 0)
        posLabel.Position = UDim2.new(0, 0, 0.6, 0)
        posLabel.Text = string.format("X:%.1f Y:%.1f Z:%.1f", position.X, position.Y, position.Z)
        posLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        posLabel.BackgroundTransparency = 1
        posLabel.Font = Enum.Font.Gotham
        posLabel.TextSize = 10
        posLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Action Buttons
        local buttonFrame = Instance.new("Frame", entryFrame)
        buttonFrame.Size = UDim2.new(0.4, -5, 1, 0)
        buttonFrame.Position = UDim2.new(0.6, 0, 0, 0)
        buttonFrame.BackgroundTransparency = 1
        
        local tpButton = Instance.new("TextButton", buttonFrame)
        tpButton.Size = UDim2.new(0.45, -2, 0.7, 0)
        tpButton.Position = UDim2.new(0, 0, 0.15, 0)
        tpButton.Text = "TP"
        tpButton.BackgroundColor3 = Color3.fromRGB(65, 120, 200)
        tpButton.BackgroundTransparency = 0.1
        tpButton.TextColor3 = Color3.new(1, 1, 1)
        tpButton.Font = Enum.Font.GothamSemibold
        tpButton.TextSize = 11
        Instance.new("UICorner", tpButton).CornerRadius = UDim.new(0, 4)
        
        local deleteButton = Instance.new("TextButton", buttonFrame)
        deleteButton.Size = UDim2.new(0.45, -2, 0.7, 0)
        deleteButton.Position = UDim2.new(0.55, 0, 0.15, 0)
        deleteButton.Text = "Delete"
        deleteButton.BackgroundColor3 = Color3.fromRGB(170, 65, 65)
        deleteButton.BackgroundTransparency = 0.1
        deleteButton.TextColor3 = Color3.new(1, 1, 1)
        deleteButton.Font = Enum.Font.GothamSemibold
        deleteButton.TextSize = 11
        Instance.new("UICorner", deleteButton).CornerRadius = UDim.new(0, 4)
        
        -- Button functionality
        tpButton.MouseButton1Click:Connect(function()
            if teleportToPosition(position) then
                consoleOutput.Text = consoleOutput.Text .. ">> Teleported to: " .. name .. "\n"
                notify("Teleport", "Teleported to " .. name, 2)
            else
                consoleOutput.Text = consoleOutput.Text .. ">> Teleport failed! No character found.\n"
                notify("Teleport", "Teleport failed!", 3)
            end
        end)
        
        deleteButton.MouseButton1Click:Connect(function()
            teleportLocations[name] = nil
            saveTeleportData()
            refreshTeleportList(scrollFrame, consoleOutput)
            consoleOutput.Text = consoleOutput.Text .. ">> Deleted location: " .. name .. "\n"
            notify("Teleport", "Deleted " .. name, 2)
        end)
        
        totalHeight = totalHeight + entryHeight + padding
    end
    
    -- Update scroll frame size
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

-- Movement Controls Functions
local function updateWalkSpeed(v)
    WalkSpeedValue = v
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = v end
end

local function updateJumpPower(v)
    JumpPowerValue = v
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = v
    end
end

-- Remove Network Pause Function
local function removeNetworkPause()
    local success, result = pcall(function()
        local networkPause = CoreGui.RobloxGui:FindFirstChild("CoreScripts/NetworkPause")
        if networkPause then
            networkPause:Destroy()
            return true, "Network Pause removed successfully!"
        else
            return false, "Network Pause not found!"
        end
    end)
    
    return success, result
end

-- NEW: Function to check VIP status for preset features
local function isUserVIP()
    return isVIP
end

-- NEW: VIP Only preset buttons
local function createVIPOnlyPresetButton(parent, text, color, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.1
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    -- Tambah badge VIP
    local vipBadge = Instance.new("TextLabel", btn)
    vipBadge.Size = UDim2.new(0, 25, 0, 15)
    vipBadge.Position = UDim2.new(1, -27, 0, 2)
    vipBadge.Text = "VIP"
    vipBadge.TextColor3 = Color3.fromRGB(255, 215, 80)
    vipBadge.BackgroundColor3 = Color3.fromRGB(60, 30, 90)
    vipBadge.BackgroundTransparency = 0.1
    vipBadge.Font = Enum.Font.GothamBold
    vipBadge.TextSize = 10
    vipBadge.BorderSizePixel = 0
    Instance.new("UICorner", vipBadge).CornerRadius = UDim.new(0, 3)

    btn.MouseButton1Click:Connect(function()
        if not isUserVIP() then
            appendToConsole(">> ACCESS DENIED: " .. text .. " is VIP only!\n")
            appendToConsole(">> Upgrade to VIP to access preset features\n")
            notify("VIP REQUIRED", "Preset features are for VIP members only!", 4)
            return
        end
        
        -- Jika user VIP, jalankan callback
        callback()
    end)
    
    return btn
end

-- Setup movement controls
UserInputService.JumpRequest:Connect(function()
    if infJump and player.Character then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    task.wait(0.1)
    hum.WalkSpeed = WalkSpeedValue
    hum.UseJumpPower = true
    hum.JumpPower = JumpPowerValue
end)

-- BUILD UI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "XuKrostHub"
screenGui.ResetOnSpawn = false

-- Create main background frame with gradient and transparency
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = ORIGINAL_FRAME_SIZE
mainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BackgroundTransparency = 0.15
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,12)

-- Add shadow effect
local shadow = Instance.new("ImageLabel", mainFrame)
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = -1

-- Add gradient background
local gradient = Instance.new("UIGradient", mainFrame)
gradient.Rotation = 45
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 20)),     -- Dark charcoal/black
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(80, 40, 120)), -- Bright purple
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(40, 80, 160)), -- Bright blue
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 220))  -- White/light blue
})
gradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.2),
    NumberSequenceKeypoint.new(0.5, 0.15),
    NumberSequenceKeypoint.new(1, 0.25)
})

-- Header tanpa status VIP (dipindahkan ke tab Player Info)
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Text = HubName
title.Font = Enum.Font.GothamBlack
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(245,245,245)
title.Position = UDim2.new(0, 12, 0, 0)
title.Size = UDim2.new(0.6, 0, 1, 0)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local creator = Instance.new("TextLabel", header)
creator.Text = CreatorText
creator.Font = Enum.Font.Gotham
creator.TextSize = 12
creator.TextColor3 = Color3.fromRGB(170,170,170)
creator.Size = UDim2.new(0.4, -12, 0, 20)
creator.Position = UDim2.new(0.6, -310, 0, 14)
creator.BackgroundTransparency = 1
creator.TextXAlignment = Enum.TextXAlignment.Right

-- Divider bawah header
local headerLine = Instance.new("Frame", mainFrame)
headerLine.Size = UDim2.new(1, -24, 0, 1)
headerLine.Position = UDim2.new(0, 12, 0, 47)
headerLine.BackgroundColor3 = Color3.fromRGB(70,70,80)
headerLine.BackgroundTransparency = 0.6
headerLine.BorderSizePixel = 0

-- Mini Control Bar
local controlBar = Instance.new("Frame", header)
controlBar.Size = UDim2.new(0, 80, 1, 0)
controlBar.Position = UDim2.new(1, -84, 0, 2)
controlBar.BackgroundTransparency = 1

local function makeControlButton(parent, text, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 29, 0, 21)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.1
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,5)
    return btn
end

local minimizeBtn = makeControlButton(controlBar,"–",Color3.fromRGB(65, 120, 200))
minimizeBtn.Position = UDim2.new(0,8,0.5,-12)

local closeBtn = makeControlButton(controlBar,"X",Color3.fromRGB(170, 65, 65))
closeBtn.Position = UDim2.new(0,44,0.5,-12)

-- Divider bawah status
local statusLine = Instance.new("Frame", mainFrame)
statusLine.Size = UDim2.new(1, -24, 0, 1)
statusLine.Position = UDim2.new(0, 12, 0, 53)
statusLine.BackgroundColor3 = Color3.fromRGB(70,70,80)
statusLine.BackgroundTransparency = 0.6
statusLine.BorderSizePixel = 0

-- Tabs container
local tabsFrame = Instance.new("Frame", mainFrame)
tabsFrame.Size = UDim2.new(1, -24, 0, 32)
tabsFrame.Position = UDim2.new(0, 20, 0, 60)
tabsFrame.BackgroundTransparency = 1

-- Divider vertikal (antara tabs dan content)
local verticalLine = Instance.new("Frame", mainFrame)
verticalLine.Size = UDim2.new(0, 1, 1, -100)
verticalLine.Position = UDim2.new(0, 145, 0, 54.3)
verticalLine.BackgroundColor3 = Color3.fromRGB(70,70,80)
verticalLine.BackgroundTransparency = 0.6
verticalLine.BorderSizePixel = 0

-- Tabs + Search
local tabButtons = {}
local tabContentFrames = {}
local currentTab = nil
local searchBox = nil

-- Koordinat tab (manual) - Player Info ditambahkan di atas Main Scripts
local tabPositions = {
    ["Player Info"]   = UDim2.new(0, -3, 0, 0),
    ["Main Scripts"] = UDim2.new(0, -3, 0, 40),
    ["Extra Tools"] = UDim2.new(0, -3, 0, 80),
    ["Own Script"] = UDim2.new(0, -3, 0, 120),
    ["Console"]     = UDim2.new(0, -3, 0, 160),
    ["Credits"]     = UDim2.new(0, -3, 0, 200)
}

local function switchTab(name)
    for t,frame in pairs(tabContentFrames) do
        frame.Visible = (t == name)
    end
    currentTab = name
end

-- Buat Tab Buttons dengan tema baru
for tabName,_ in pairs(scripts) do
    local btn = Instance.new("TextButton", tabsFrame)
    btn.Size = UDim2.new(0, 120, 1, 3)
    btn.Position = tabPositions[tabName] or UDim2.new(0, 0, 0, 0)
    btn.Text = tabName
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,52)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    btn.MouseButton1Click:Connect(function() switchTab(tabName) end)
    tabButtons[tabName] = btn
end

-- Search bar
searchBox = Instance.new("TextBox", mainFrame)
searchBox.PlaceholderText = "search..."
searchBox.Size = UDim2.new(1, -357, 0, 20)
searchBox.Position = UDim2.new(0, 276, 0, 13)
searchBox.BackgroundTransparency = 1
searchBox.TextColor3 = Color3.new(1,1,1)
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 14
searchBox.Text = ""
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0,6)
searchBox.Visible = true

-- Tab contents
local consoleOutput
local consoleScrollingFrame
local movementDropdownOpen = false
local movementDropdownFrame

-- FIX: Fungsi untuk update console dengan auto-scroll
local function updateConsole(text)
    consoleOutput.Text = text
    task.wait(0.05)
    if consoleScrollingFrame then
        consoleScrollingFrame.CanvasPosition = Vector2.new(0, consoleOutput.TextBounds.Y + 100)
    end
end

local function appendToConsole(newText)
    consoleOutput.Text = consoleOutput.Text .. newText
    task.wait(0.05)
    if consoleScrollingFrame then
        consoleScrollingFrame.CanvasPosition = Vector2.new(0, consoleOutput.TextBounds.Y + 100)
    end
end

-- Fungsi untuk mendapatkan tanggal realtime
local function getCurrentDateTime()
    local currentTime = os.date("*t")
    return string.format("%02d/%02d/%04d", currentTime.day, currentTime.month, currentTime.year)
end

-- Fungsi untuk membuat button VIP Only di Extra Tools
local function createVIPOnlyButton(parent, name, url)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Text = name
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(80, 50, 120)
    btn.BackgroundTransparency = 0.1
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    
    -- Tambah badge VIP
    local vipBadge = Instance.new("TextLabel", btn)
    vipBadge.Size = UDim2.new(0, 25, 0, 15)
    vipBadge.Position = UDim2.new(1, -27, 0, 2)
    vipBadge.Text = "VIP"
    vipBadge.TextColor3 = Color3.fromRGB(255, 215, 80)
    vipBadge.BackgroundColor3 = Color3.fromRGB(60, 30, 90)
    vipBadge.BackgroundTransparency = 0.1
    vipBadge.Font = Enum.Font.GothamBold
    vipBadge.TextSize = 10
    vipBadge.BorderSizePixel = 0
    Instance.new("UICorner", vipBadge).CornerRadius = UDim.new(0,3)

    btn.MouseButton1Click:Connect(function()
        if not isVIP then
            appendToConsole(">> ACCESS DENIED: " .. name .. " is VIP only!\n")
            appendToConsole(">> Upgrade to VIP to access premium tools\n")
            notify("VIP REQUIRED", "This tool is for VIP members only!", 4)
            return
        end
        
        appendToConsole(">> Loading " .. name .. "\n")
        local ok, msg = fetchAndRun(url)
        if ok then
            appendToConsole(">> " .. name .. " loaded!\n")
            notify("XuKrost Hub", name .. " success", 3)
        else
            appendToConsole(">> " .. name .. " failed: " .. tostring(msg) .. "\n")
            notify("XuKrost Hub", name .. " failed: " .. tostring(msg), 5)
        end
    end)
    
    return btn
end

-- Fungsi untuk membuat button script dengan sistem VIP dan Key System
local function createScriptButton(parent, name, url, isVIPScript)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -12, 0, 35)
    btn.Text = name
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = isVIPScript and Color3.fromRGB(80, 50, 120) or Color3.fromRGB(45, 45, 60)
    btn.BackgroundTransparency = 0.1
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    
    -- Tambah badge VIP jika script VIP
    if isVIPScript then
        local vipBadge = Instance.new("TextLabel", btn)
        vipBadge.Size = UDim2.new(0, 25, 0, 15)
        vipBadge.Position = UDim2.new(1, -27, 0, 2)
        vipBadge.Text = "VIP"
        vipBadge.TextColor3 = Color3.fromRGB(255, 215, 80)
        vipBadge.BackgroundColor3 = Color3.fromRGB(60, 30, 90)
        vipBadge.BackgroundTransparency = 0.1
        vipBadge.Font = Enum.Font.GothamBold
        vipBadge.TextSize = 10
        vipBadge.BorderSizePixel = 0
        Instance.new("UICorner", vipBadge).CornerRadius = UDim.new(0,3)
    end

    btn.MouseButton1Click:Connect(function()
        -- Check untuk VIP scripts
        if isVIPScript and not isVIP then
            appendToConsole(">> ACCESS DENIED: " .. name .. " is VIP only!\n")
            appendToConsole(">> Upgrade to VIP to access premium scripts\n")
            notify("VIP REQUIRED", "This script is for VIP members only!", 4)
            return
        end
        
        -- Check untuk Free scripts (hanya jika bukan VIP)
        if not isVIPScript and not isVIP then
            -- Jika user bukan VIP dan mencoba menggunakan free script, check key
            if not keyAccepted then
                appendToConsole(">> KEY REQUIRED: Please enter key for free scripts\n")
                notify("KEY REQUIRED", "Please enter key to use free scripts", 3)
                
                -- FIX: Selalu panggil checkKeyStatus tanpa kondisi tambahan
                -- GUI akan selalu muncul jika key belum diterima
                local keyValid = checkKeyStatus()
                if not keyValid then
                    return  -- Jangan jalankan script jika key belum valid
                end
            end
        end
        
        -- Jika key sudah diterima atau user VIP, jalankan script
        appendToConsole(">> Loading " .. name .. "\n")
        local ok, msg = fetchAndRun(url)
        if ok then
            appendToConsole(">> " .. name .. " loaded!\n")
            notify("XuKrost Hub", name .. " success", 3)
        else
            appendToConsole(">> " .. name .. " failed: " .. tostring(msg) .. "\n")
            notify("XuKrost Hub", name .. " failed: " .. tostring(msg), 5)
        end
    end)
    
    return btn
end

-- NEW: Function to show preset name input dialog
local function showPresetNameDialog(callback)
    local dialogGui = Instance.new("ScreenGui", game.CoreGui)
    dialogGui.Name = "PresetNameDialog"
    dialogGui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame", dialogGui)
    frame.Size = UDim2.fromOffset(300, 140)
    frame.Position = UDim2.new(0.5, -150, 0.5, -70)
    frame.BackgroundColor3 = Color3.fromRGB(31,31,53)
    frame.BorderSizePixel = 0
    frame.ZIndex = 1
    
    local function corner(o) 
        local c = Instance.new("UICorner", o)
        c.CornerRadius = UDim.new(0,10)
        return c
    end
    corner(frame)
    
    local closeBtn = Instance.new("TextButton", frame)
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -28, 0, 4)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.BackgroundColor3 = Color3.fromRGB(170, 65, 65)
    closeBtn.BackgroundTransparency = 0.1
    corner(closeBtn)
    
    closeBtn.MouseButton1Click:Connect(function()
        dialogGui:Destroy()
    end)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -60, 0, 30)
    title.Position = UDim2.fromOffset(10, 10)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = Color3.new(1,1,1)
    title.Text = "Enter Preset Name"
    
    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(1, -20, 0, 30)
    input.Position = UDim2.fromOffset(10, 50)
    input.PlaceholderText = "My Teleport Preset"
    input.Text = ""
    input.TextSize = 14
    input.Font = Enum.Font.Gotham
    input.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    input.BackgroundTransparency = 0.2
    input.TextColor3 = Color3.new(1,1,1)
    corner(input)
    
    local submitBtn = Instance.new("TextButton", frame)
    submitBtn.Size = UDim2.new(1, -20, 0, 30)
    submitBtn.Position = UDim2.fromOffset(10, 90)
    submitBtn.Text = "Save Preset"
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 14
    submitBtn.BackgroundColor3 = Color3.fromRGB(65, 150, 80)
    submitBtn.BackgroundTransparency = 0.1
    submitBtn.TextColor3 = Color3.new(1,1,1)
    corner(submitBtn)
    
    submitBtn.MouseButton1Click:Connect(function()
        local presetName = input.Text:gsub("^%s*(.-)%s*$", "%1")
        if presetName == "" then
            notify("Preset", "Please enter a preset name!", 2)
            return
        end
        
        callback(presetName)
        dialogGui:Destroy()
    end)
    
    -- Focus pada input box
    input:CaptureFocus()
    
    -- Enter key to submit
    input.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local presetName = input.Text:gsub("^%s*(.-)%s*$", "%1")
            if presetName ~= "" then
                callback(presetName)
                dialogGui:Destroy()
            end
        end
    end)
    
    -- Dragging functionality
    local drag, startPos, origPos
    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or
           i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            startPos = i.Position
            origPos = frame.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    drag = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or
                     i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - startPos
            frame.Position = UDim2.new(
                origPos.X.Scale, origPos.X.Offset + delta.X,
                origPos.Y.Scale, origPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- NEW: Function to show preset selection dialog
local function showPresetSelectionDialog(callback)
    local dialogGui = Instance.new("ScreenGui", game.CoreGui)
    dialogGui.Name = "PresetSelectionDialog"
    dialogGui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame", dialogGui)
    frame.Size = UDim2.fromOffset(300, 150)
    frame.Position = UDim2.new(0.5, -175, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(31,31,53)
    frame.BorderSizePixel = 0
    frame.ZIndex = 1
    
    local function corner(o) 
        local c = Instance.new("UICorner", o)
        c.CornerRadius = UDim.new(0,10)
        return c
    end
    corner(frame)
    
    local closeBtn = Instance.new("TextButton", frame)
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -28, 0, 4)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.BackgroundColor3 = Color3.fromRGB(170, 65, 65)
    closeBtn.BackgroundTransparency = 0.1
    corner(closeBtn)
    
    closeBtn.MouseButton1Click:Connect(function()
        dialogGui:Destroy()
    end)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -60, 0, 30)
    title.Position = UDim2.fromOffset(30, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = Color3.new(1,1,1)
    title.Text = "Select Preset"
    
    local scrollFrame = Instance.new("ScrollingFrame", frame)
    scrollFrame.Size = UDim2.new(1, -20, 0, 80)
    scrollFrame.Position = UDim2.fromOffset(10, 32)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    scrollFrame.BackgroundTransparency = 0.2
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    corner(scrollFrame)
    
    local listLayout = Instance.new("UIListLayout", scrollFrame)
    listLayout.Padding = UDim.new(0, 5)
    
    local presets = getAvailablePresets()
    
    if #presets == 0 then
        local noPresetsLabel = Instance.new("TextLabel", scrollFrame)
        noPresetsLabel.Size = UDim2.new(1, -10, 0, 30)
        noPresetsLabel.Position = UDim2.fromOffset(5, 5)
        noPresetsLabel.Text = "No presets found"
        noPresetsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        noPresetsLabel.BackgroundTransparency = 1
        noPresetsLabel.Font = Enum.Font.Gotham
        noPresetsLabel.TextSize = 14
        noPresetsLabel.TextXAlignment = Enum.TextXAlignment.Center
    else
        for i, presetName in ipairs(presets) do
            local presetBtn = Instance.new("TextButton", scrollFrame)
            presetBtn.Size = UDim2.new(1, -15, 0, 30)
            presetBtn.Position = UDim2.new(0, 0, 0, 10)
            presetBtn.Text = presetName
            presetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            presetBtn.BackgroundTransparency = 0.1
            presetBtn.TextColor3 = Color3.new(1, 1, 1)
            presetBtn.Font = Enum.Font.Gotham
            presetBtn.TextSize = 12
            corner(presetBtn)
            
            presetBtn.MouseButton1Click:Connect(function()
                callback(presetName)
                dialogGui:Destroy()
            end)
        end
    end
    
    local deleteBtn = Instance.new("TextButton", frame)
    deleteBtn.Size = UDim2.new(0.5, -15, 0, 25)
    deleteBtn.Position = UDim2.fromOffset(10, 118)
    deleteBtn.Text = "Delete Preset"
    deleteBtn.BackgroundColor3 = Color3.fromRGB(170, 65, 65)
    deleteBtn.BackgroundTransparency = 0.1
    deleteBtn.TextColor3 = Color3.new(1, 1, 1)
    deleteBtn.Font = Enum.Font.GothamBold
    deleteBtn.TextSize = 12
    corner(deleteBtn)
    
    deleteBtn.MouseButton1Click:Connect(function()
        if #presets > 0 then
            showPresetSelectionDialog(function(presetName)
                local success, message = deleteTeleportPreset(presetName)
                if success then
                    notify("Preset", message, 3)
                    appendToConsole(">> " .. message .. "\n")
                    dialogGui:Destroy()
                    showPresetSelectionDialog(callback)
                else
                    notify("Preset", message, 3)
                    appendToConsole(">> " .. message .. "\n")
                end
            end)
        else
            notify("Preset", "No presets to delete!", 2)
        end
    end)
    
    local cancelBtn = Instance.new("TextButton", frame)
    cancelBtn.Size = UDim2.new(0.5, -15, 0, 25)
    cancelBtn.Position = UDim2.new(0.5, 5, 0, 118)
    cancelBtn.Text = "Cancel"
    cancelBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    cancelBtn.BackgroundTransparency = 0.1
    cancelBtn.TextColor3 = Color3.new(1, 1, 1)
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.TextSize = 12
    corner(cancelBtn)
    
    cancelBtn.MouseButton1Click:Connect(function()
        dialogGui:Destroy()
    end)
    
    -- Dragging functionality
    local drag, startPos, origPos
    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or
           i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            startPos = i.Position
            origPos = frame.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    drag = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or
                     i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - startPos
            frame.Position = UDim2.new(
                origPos.X.Scale, origPos.X.Offset + delta.X,
                origPos.Y.Scale, origPos.Y.Offset + delta.Y
            )
        end
    end)
end

local function createTabContent(tabName, data)
    local offsetY = (tabName == "Player Info" or tabName == "Main Scripts" or tabName == "Extra Tools" or tabName == "Own Script" or tabName == "Console") and 65 or 120
    local contentFrame = Instance.new("Frame", mainFrame)
    contentFrame.Size = UDim2.new(1, -170, 1, -offsetY)
    contentFrame.Position = UDim2.new(0, 148, 0, offsetY)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = false
    tabContentFrames[tabName] = contentFrame

    if tabName == "Console" then  
        consoleScrollingFrame = Instance.new("ScrollingFrame", contentFrame)
        consoleScrollingFrame.Size = UDim2.new(1, -40, 1, -90)
        consoleScrollingFrame.Position = UDim2.new(0, 5, 0, 5)
        consoleScrollingFrame.BackgroundColor3 = Color3.fromRGB(20,20,25)
        consoleScrollingFrame.BackgroundTransparency = 0.3
        consoleScrollingFrame.BorderSizePixel = 0
        consoleScrollingFrame.ScrollBarThickness = 8
        consoleScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Instance.new("UICorner", consoleScrollingFrame).CornerRadius = UDim.new(0,6)
        
        consoleOutput = Instance.new("TextLabel", consoleScrollingFrame)
        consoleOutput.Size = UDim2.new(1, -10, 0, 0)
        consoleOutput.Position = UDim2.new(0, 5, 0, 5)
        consoleOutput.BackgroundTransparency = 1
        consoleOutput.TextColor3 = Color3.new(1,1,1)
        consoleOutput.Font = Enum.Font.Code
        consoleOutput.TextSize = 14
        consoleOutput.TextXAlignment = Enum.TextXAlignment.Left
        consoleOutput.TextYAlignment = Enum.TextYAlignment.Top
        consoleOutput.TextWrapped = true
        consoleOutput.Text = ">> Console ready...\n>> Checking VIP status...\n"
        consoleOutput.TextStrokeTransparency = 0.8
        consoleOutput.AutomaticSize = Enum.AutomaticSize.Y
        
        -- Check VIP status saat console pertama kali dibuka
        task.spawn(function()
            refreshVIPStatus(consoleOutput)
        end)
        
    elseif tabName == "Player Info" then
        -- Player Info Tab Content
        
        -- Player Basic Info Section
        local basicInfoSection = Instance.new("Frame", contentFrame)
        basicInfoSection.Size = UDim2.new(1, 0, 0, 120)
        basicInfoSection.Position = UDim2.new(0, 5, 0, -3)
        basicInfoSection.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        basicInfoSection.BackgroundTransparency = 0.3
        basicInfoSection.BorderSizePixel = 0
        Instance.new("UICorner", basicInfoSection).CornerRadius = UDim.new(0, 8)
        
        local basicInfoHeader = Instance.new("TextLabel", basicInfoSection)
        basicInfoHeader.Size = UDim2.new(1, -10, 0, 25)
        basicInfoHeader.Position = UDim2.new(0, 5, 0, 5)
        basicInfoHeader.Text = "PLAYER INFORMATION"
        basicInfoHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
        basicInfoHeader.BackgroundTransparency = 1
        basicInfoHeader.Font = Enum.Font.GothamBold
        basicInfoHeader.TextSize = 16
        basicInfoHeader.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Username
        local usernameFrame = Instance.new("Frame", basicInfoSection)
        usernameFrame.Size = UDim2.new(1, -10, 0, 20)
        usernameFrame.Position = UDim2.new(0, 5, 0, 35)
        usernameFrame.BackgroundTransparency = 1
        
        local usernameLabel = Instance.new("TextLabel", usernameFrame)
        usernameLabel.Size = UDim2.new(0.4, 0, 1, 0)
        usernameLabel.Text = "Username:"
        usernameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        usernameLabel.BackgroundTransparency = 1
        usernameLabel.Font = Enum.Font.GothamSemibold
        usernameLabel.TextSize = 12
        usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local usernameValue = Instance.new("TextLabel", usernameFrame)
        usernameValue.Size = UDim2.new(0.6, 0, 1, 0)
        usernameValue.Position = UDim2.new(0.4, 0, 0, 0)
        usernameValue.Text = player.Name
        usernameValue.TextColor3 = Color3.fromRGB(100, 200, 255)
        usernameValue.BackgroundTransparency = 1
        usernameValue.Font = Enum.Font.Gotham
        usernameValue.TextSize = 12
        usernameValue.TextXAlignment = Enum.TextXAlignment.Left
        
        -- User ID
        local userIdFrame = Instance.new("Frame", basicInfoSection)
        userIdFrame.Size = UDim2.new(1, -10, 0, 20)
        userIdFrame.Position = UDim2.new(0, 5, 0, 55)
        userIdFrame.BackgroundTransparency = 1
        
        local userIdLabel = Instance.new("TextLabel", userIdFrame)
        userIdLabel.Size = UDim2.new(0.4, 0, 1, 0)
        userIdLabel.Text = "User ID:"
        userIdLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        userIdLabel.BackgroundTransparency = 1
        userIdLabel.Font = Enum.Font.GothamSemibold
        userIdLabel.TextSize = 12
        userIdLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local userIdValue = Instance.new("TextLabel", userIdFrame)
        userIdValue.Size = UDim2.new(0.4, 0, 1, 0) -- Diubah dari 0.6 menjadi 0.4 untuk memberi ruang button
        userIdValue.Position = UDim2.new(0.4, 0, 0, 0)
        userIdValue.Text = tostring(player.UserId)
        userIdValue.TextColor3 = Color3.fromRGB(100, 200, 255)
        userIdValue.BackgroundTransparency = 1
        userIdValue.Font = Enum.Font.Gotham
        userIdValue.TextSize = 12
        userIdValue.TextXAlignment = Enum.TextXAlignment.Left
        
        -- COPY USER ID BUTTON (TAMBAHAN BARU)
        local copyUserIdBtn = Instance.new("TextButton", userIdFrame)
        copyUserIdBtn.Size = UDim2.new(0.2, -5, 0.7, 0)
        copyUserIdBtn.Position = UDim2.new(0.8, 0, 0.15, 0)
        copyUserIdBtn.Text = "Copy"
        copyUserIdBtn.BackgroundColor3 = Color3.fromRGB(65, 120, 200)
        copyUserIdBtn.BackgroundTransparency = 0.1
        copyUserIdBtn.TextColor3 = Color3.new(1, 1, 1)
        copyUserIdBtn.Font = Enum.Font.GothamSemibold
        copyUserIdBtn.TextSize = 10
        Instance.new("UICorner", copyUserIdBtn).CornerRadius = UDim.new(0, 4)
        
        copyUserIdBtn.MouseButton1Click:Connect(function()
            if copyToClipboard(tostring(player.UserId)) then
                appendToConsole(">> User ID copied to clipboard: " .. player.UserId .. "\n")
                notify("User ID", "Copied to clipboard!", 2)
            else
                appendToConsole(">> Failed to copy User ID!\n")
                notify("Error", "Failed to copy User ID", 2)
            end
        end)
        
        -- Status VIP
        local statusFrame = Instance.new("Frame", basicInfoSection)
        statusFrame.Size = UDim2.new(1, -10, 0, 20)
        statusFrame.Position = UDim2.new(0, 5, 0, 75)
        statusFrame.BackgroundTransparency = 1
        
        local statusLabel = Instance.new("TextLabel", statusFrame)
        statusLabel.Size = UDim2.new(0.4, 0, 1, 0)
        statusLabel.Text = "Status:"
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        statusLabel.BackgroundTransparency = 1
        statusLabel.Font = Enum.Font.GothamSemibold
        statusLabel.TextSize = 12
        statusLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local statusValue = Instance.new("TextLabel", statusFrame)
        statusValue.Size = UDim2.new(0.6, 0, 1, 0)
        statusValue.Position = UDim2.new(0.4, 0, 0, 0)
        statusValue.Text = "Checking..."
        statusValue.TextColor3 = Color3.fromRGB(255, 170, 0)
        statusValue.BackgroundTransparency = 1
        statusValue.Font = Enum.Font.GothamBold
        statusValue.TextSize = 12
        statusValue.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Calendar (Tanggal/Bulan/Tahun Realtime)
        local calendarFrame = Instance.new("Frame", basicInfoSection)
        calendarFrame.Size = UDim2.new(1, -10, 0, 20)
        calendarFrame.Position = UDim2.new(0, 5, 0, 95)
        calendarFrame.BackgroundTransparency = 1
        
        local calendarLabel = Instance.new("TextLabel", calendarFrame)
        calendarLabel.Size = UDim2.new(0.4, 0, 1, 0)
        calendarLabel.Text = "Calendar:"
        calendarLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        calendarLabel.BackgroundTransparency = 1
        calendarLabel.Font = Enum.Font.GothamSemibold
        calendarLabel.TextSize = 12
        calendarLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local calendarValue = Instance.new("TextLabel", calendarFrame)
        calendarValue.Size = UDim2.new(0.6, 0, 1, 0)
        calendarValue.Position = UDim2.new(0.4, 0, 0, 0)
        calendarValue.Text = getCurrentDateTime()
        calendarValue.TextColor3 = Color3.fromRGB(100, 255, 100)
        calendarValue.BackgroundTransparency = 1
        calendarValue.Font = Enum.Font.Gotham
        calendarValue.TextSize = 12
        calendarValue.TextXAlignment = Enum.TextXAlignment.Left
        
        -- VIP Info Section (dipindahkan dari Credits)
        local vipInfoSection = Instance.new("Frame", contentFrame)
        vipInfoSection.Size = UDim2.new(1, 0, 0, 90)
        vipInfoSection.Position = UDim2.new(0, 5, 0, 125)
        vipInfoSection.BackgroundColor3 = Color3.fromRGB(50, 30, 50)
        vipInfoSection.BackgroundTransparency = 0.3
        vipInfoSection.BorderSizePixel = 0
        Instance.new("UICorner", vipInfoSection).CornerRadius = UDim.new(0, 8)
        
        local vipInfoHeader = Instance.new("TextLabel", vipInfoSection)
        vipInfoHeader.Size = UDim2.new(1, -10, 0, 25)
        vipInfoHeader.Position = UDim2.new(0, 5, 0, 5)
        vipInfoHeader.Text = "VIP SYSTEM"
        vipInfoHeader.TextColor3 = Color3.fromRGB(255, 215, 80)
        vipInfoHeader.BackgroundTransparency = 1
        vipInfoHeader.Font = Enum.Font.GothamBold
        vipInfoHeader.TextSize = 16
        vipInfoHeader.TextXAlignment = Enum.TextXAlignment.Left
        
        local vipInfoText = Instance.new("TextLabel", vipInfoSection)
        vipInfoText.Size = UDim2.new(1, -10, 0, 40)
        vipInfoText.Position = UDim2.new(0, 5, 0, 30)
        vipInfoText.Text = "Upgrade to VIP for exclusive scripts!\nContact creator for more info."
        vipInfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
        vipInfoText.BackgroundTransparency = 1
        vipInfoText.Font = Enum.Font.Gotham
        vipInfoText.TextSize = 11
        vipInfoText.TextXAlignment = Enum.TextXAlignment.Left
        vipInfoText.TextYAlignment = Enum.TextYAlignment.Top
        vipInfoText.TextWrapped = true
        
        local refreshVIPBtn = Instance.new("TextButton", vipInfoSection)
        refreshVIPBtn.Size = UDim2.new(1, -10, 0, 25)
        refreshVIPBtn.Position = UDim2.new(0, 5, 1, -30)
        refreshVIPBtn.Text = "Refresh VIP Status"
        refreshVIPBtn.BackgroundColor3 = Color3.fromRGB(90, 60, 130)
        refreshVIPBtn.BackgroundTransparency = 0.1
        refreshVIPBtn.TextColor3 = Color3.new(1, 1, 1)
        refreshVIPBtn.Font = Enum.Font.GothamSemibold
        refreshVIPBtn.TextSize = 12
        Instance.new("UICorner", refreshVIPBtn).CornerRadius = UDim.new(0, 6)
        
        refreshVIPBtn.MouseButton1Click:Connect(function()
            appendToConsole(">> Refreshing VIP status...\n")
            refreshVIPStatus(consoleOutput)
            
            -- Update status di Player Info tab
            if isVIP then
                statusValue.Text = "VIP"
                statusValue.TextColor3 = Color3.fromRGB(100, 255, 100)
            else
                statusValue.Text = "Free"
                statusValue.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        end)
        
        -- Update calendar setiap detik
        local calendarUpdateConnection
        calendarUpdateConnection = RunService.Heartbeat:Connect(function()
            calendarValue.Text = getCurrentDateTime()
        end)
        
        -- Update VIP status saat tab pertama kali dibuka
        task.spawn(function()
            if isVIP then
                statusValue.Text = "VIP"
                statusValue.TextColor3 = Color3.fromRGB(100, 255, 100)
            else
                statusValue.Text = "Free"
                statusValue.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        end)
        
    elseif tabName == "Extra Tools" then  
        local listLayout = Instance.new("UIListLayout", contentFrame)  
        listLayout.Padding = UDim.new(0,6)  
          
        -- Movement Controls Dropdown Button  
        local movementDropdownBtn = Instance.new("TextButton", contentFrame)  
        movementDropdownBtn.Size = UDim2.new(1, 0, 0, 36)  
        movementDropdownBtn.Text = "Movement Controls"  
        movementDropdownBtn.Font = Enum.Font.GothamSemibold  
        movementDropdownBtn.TextSize = 14  
        movementDropdownBtn.TextColor3 = Color3.new(1,1,1)  
        movementDropdownBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        movementDropdownBtn.BackgroundTransparency = 0.1
        movementDropdownBtn.BorderSizePixel = 0  
        Instance.new("UICorner", movementDropdownBtn).CornerRadius = UDim.new(0,6)  
          
        -- Movement Controls Dropdown Content  
        movementDropdownFrame = Instance.new("Frame", contentFrame)  
        movementDropdownFrame.Size = UDim2.new(1, 0, 0, 0)  
        movementDropdownFrame.Position = UDim2.new(0, 0, 0, 42)  
        movementDropdownFrame.BackgroundColor3 = Color3.fromRGB(40,40,45)  
        movementDropdownFrame.BackgroundTransparency = 0.3
        movementDropdownFrame.BorderSizePixel = 0  
        movementDropdownFrame.ClipsDescendants = true  
        Instance.new("UICorner", movementDropdownFrame).CornerRadius = UDim.new(0,6)  
        movementDropdownFrame.Visible = false  
          
        -- WalkSpeed Control  
        local walkSpeedFrame = Instance.new("Frame", movementDropdownFrame)  
        walkSpeedFrame.Size = UDim2.new(1, -10, 0, 30)  
        walkSpeedFrame.Position = UDim2.new(0, 5, 0, 5)  
        walkSpeedFrame.BackgroundTransparency = 1  
          
        local walkSpeedLabel = Instance.new("TextLabel", walkSpeedFrame)  
        walkSpeedLabel.Size = UDim2.new(0.4, 0, 1, 0)  
        walkSpeedLabel.Position = UDim2.new(0.4, -87, 0, 0)  
        walkSpeedLabel.Text = "WalkSpeed:"  
        walkSpeedLabel.TextColor3 = Color3.new(1,1,1)  
        walkSpeedLabel.BackgroundTransparency = 1  
        walkSpeedLabel.Font = Enum.Font.Gotham  
        walkSpeedLabel.TextSize = 12  
        walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left  
          
        local walkSpeedBox = Instance.new("TextBox", walkSpeedFrame)  
        walkSpeedBox.Size = UDim2.new(0.3, 0, 1, 0)  
        walkSpeedBox.Position = UDim2.new(0.4, 5, 0, 0)  
        walkSpeedBox.Text = tostring(WalkSpeedValue)  
        walkSpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        walkSpeedBox.BackgroundTransparency = 0.2
        walkSpeedBox.TextColor3 = Color3.new(1,1,1)  
        walkSpeedBox.Font = Enum.Font.Gotham  
        walkSpeedBox.TextSize = 12  
        Instance.new("UICorner", walkSpeedBox).CornerRadius = UDim.new(0,4)  
          
        local walkSpeedBtn = Instance.new("TextButton", walkSpeedFrame)  
        walkSpeedBtn.Size = UDim2.new(0.25, -5, 1, 0)  
        walkSpeedBtn.Position = UDim2.new(0.75, 5, 0, 0)  
        walkSpeedBtn.Text = "Apply"  
        walkSpeedBtn.BackgroundColor3 = Color3.fromRGB(65, 120, 200)
        walkSpeedBtn.BackgroundTransparency = 0.1
        walkSpeedBtn.TextColor3 = Color3.new(1,1,1)  
        walkSpeedBtn.Font = Enum.Font.GothamSemibold  
        walkSpeedBtn.TextSize = 12  
        Instance.new("UICorner", walkSpeedBtn).CornerRadius = UDim.new(0,4)  
          
        walkSpeedBtn.MouseButton1Click:Connect(function()  
            local ws = tonumber(walkSpeedBox.Text)  
            if ws then  
                updateWalkSpeed(ws)  
                appendToConsole(">> WalkSpeed set to "..ws.."\n")  
                notify("Movement", "WalkSpeed: "..ws, 2)  
            end  
        end)  
          
        -- JumpPower Control  
        local jumpPowerFrame = Instance.new("Frame", movementDropdownFrame)  
        jumpPowerFrame.Size = UDim2.new(1, -10, 0, 30)  
        jumpPowerFrame.Position = UDim2.new(0, 5, 0, 40)  
        jumpPowerFrame.BackgroundTransparency = 1  
          
        local jumpPowerLabel = Instance.new("TextLabel", jumpPowerFrame)  
        jumpPowerLabel.Size = UDim2.new(0.4, 0, 1, 0)  
        jumpPowerLabel.Position = UDim2.new(0.4, -90, 0, 0)  
        jumpPowerLabel.Text = "JumpPower:"  
        jumpPowerLabel.TextColor3 = Color3.new(1,1,1)  
        jumpPowerLabel.BackgroundTransparency = 1  
        jumpPowerLabel.Font = Enum.Font.Gotham  
        jumpPowerLabel.TextSize = 12  
        jumpPowerLabel.TextXAlignment = Enum.TextXAlignment.Left  
          
        local jumpPowerBox = Instance.new("TextBox", jumpPowerFrame)  
        jumpPowerBox.Size = UDim2.new(0.3, 0, 1, 0)  
        jumpPowerBox.Position = UDim2.new(0.4, 5, 0, 0)  
        jumpPowerBox.Text = tostring(JumpPowerValue)  
        jumpPowerBox.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        jumpPowerBox.BackgroundTransparency = 0.2
        jumpPowerBox.TextColor3 = Color3.new(1,1,1)  
        jumpPowerBox.Font = Enum.Font.Gotham  
        jumpPowerBox.TextSize = 12  
        Instance.new("UICorner", jumpPowerBox).CornerRadius = UDim.new(0,4)  
          
        local jumpPowerBtn = Instance.new("TextButton", jumpPowerFrame)  
        jumpPowerBtn.Size = UDim2.new(0.25, -5, 1, 0)  
        jumpPowerBtn.Position = UDim2.new(0.75, 5, 0, 0)  
        jumpPowerBtn.Text = "Apply"  
        jumpPowerBtn.BackgroundColor3 = Color3.fromRGB(65, 120, 200)
        jumpPowerBtn.BackgroundTransparency = 0.1
        jumpPowerBtn.TextColor3 = Color3.new(1,1,1)  
        jumpPowerBtn.Font = Enum.Font.GothamSemibold  
        jumpPowerBtn.TextSize = 12  
        Instance.new("UICorner", jumpPowerBtn).CornerRadius = UDim.new(0,4)  
          
        jumpPowerBtn.MouseButton1Click:Connect(function()  
            local jp = tonumber(jumpPowerBox.Text)  
            if jp then  
                updateJumpPower(jp)  
                appendToConsole(">> JumpPower set to "..jp.."\n")  
                notify("Movement", "JumpPower: "..jp, 2)  
            end  
        end)  
          
        -- Infinity Jump Toggle  
        local infJumpBtn = Instance.new("TextButton", movementDropdownFrame)  
        infJumpBtn.Size = UDim2.new(1, -10, 0, 30)  
        infJumpBtn.Position = UDim2.new(0, 5, 0, 75)  
        infJumpBtn.Text = "Infinity Jump: OFF"  
        infJumpBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
        infJumpBtn.BackgroundTransparency = 0.1
        infJumpBtn.TextColor3 = Color3.new(1,1,1)  
        infJumpBtn.Font = Enum.Font.GothamSemibold  
        infJumpBtn.TextSize = 12  
        Instance.new("UICorner", infJumpBtn).CornerRadius = UDim.new(0,6)  
          
        infJumpBtn.MouseButton1Click:Connect(function()  
            infJump = not infJump  
            infJumpBtn.Text = "Infinity Jump: " .. (infJump and "ON" or "OFF")  
            infJumpBtn.BackgroundColor3 = infJump and Color3.fromRGB(65, 170, 80) or Color3.fromRGB(70, 70, 90)
            infJumpBtn.BackgroundTransparency = 0.1
            appendToConsole(">> Infinity Jump: "..(infJump and "ON" or "OFF").."\n")  
            notify("Movement", "Infinity Jump "..(infJump and "ON" or "OFF"), 2)  
        end)  
          
        -- Presets  
        local preset1Btn = Instance.new("TextButton", movementDropdownFrame)  
        preset1Btn.Size = UDim2.new(1, -178, 0, 28)  
        preset1Btn.Position = UDim2.new(0, 5, 0, 110)  
        preset1Btn.Text = "Default"  
        preset1Btn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
        preset1Btn.BackgroundTransparency = 0.1
        preset1Btn.TextColor3 = Color3.new(1,1,1)  
        preset1Btn.Font = Enum.Font.Gotham  
        preset1Btn.TextSize = 13  
        Instance.new("UICorner", preset1Btn).CornerRadius = UDim.new(0,4)  
          
        preset1Btn.MouseButton1Click:Connect(function()  
            updateWalkSpeed(16)  
            updateJumpPower(50)  
            infJump = false  
            walkSpeedBox.Text = "16"  
            jumpPowerBox.Text = "50"  
            infJumpBtn.Text = "Infinity Jump: OFF"  
            infJumpBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
            infJumpBtn.BackgroundTransparency = 0.1
            appendToConsole(">> Movement preset: Default\n")  
            notify("Movement", "Default preset applied", 2)  
        end)  
          
        local preset2Btn = Instance.new("TextButton", movementDropdownFrame)  
        preset2Btn.Size = UDim2.new(1, -178, 0, 28)  
        preset2Btn.Position = UDim2.new(0, 173, 0, 110)  
        preset2Btn.Text = "Ngibrits"  
        preset2Btn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
        preset2Btn.BackgroundTransparency = 0.1
        preset2Btn.TextColor3 = Color3.new(1,1,1)  
        preset2Btn.Font = Enum.Font.Gotham  
        preset2Btn.TextSize = 13  
        Instance.new("UICorner", preset2Btn).CornerRadius = UDim.new(0,4)  
          
        preset2Btn.MouseButton1Click:Connect(function()  
            updateWalkSpeed(50)  
            updateJumpPower(75)  
            infJump = true  
            walkSpeedBox.Text = "50"  
            jumpPowerBox.Text = "75"  
            infJumpBtn.Text = "Infinity Jump: ON"  
            infJumpBtn.BackgroundColor3 = Color3.fromRGB(65, 170, 80)
            infJumpBtn.BackgroundTransparency = 0.1
            appendToConsole(">> Movement preset: Ngibrits\n")  
            notify("Movement", "Ngibrits preset applied", 2)  
        end)  
          
        -- Dropdown toggle functionality  
        movementDropdownBtn.MouseButton1Click:Connect(function()  
            movementDropdownOpen = not movementDropdownOpen  
              
            if movementDropdownOpen then  
                movementDropdownBtn.Text = "Movement Controls"  
                movementDropdownFrame.Size = UDim2.new(1, 0, 0, 170)  
                movementDropdownFrame.Visible = true  
            else  
                movementDropdownBtn.Text = "Movement Controls"  
                movementDropdownFrame.Size = UDim2.new(1, 0, 0, 0)  
                movementDropdownFrame.Visible = false  
            end  
        end)  
          
        -- Fly Button (VIP Only)
        local flyBtn = createVIPOnlyButton(contentFrame, "Fly", "https://raw.githubusercontent.com/noirexe/GYkHTrZSc5W/refs/heads/main/sc-free-ko-dijual-awoakowk.lua")
          
        -- Remove Network Pause Button (VIP Only)
        local removeNetworkPauseBtn = createVIPOnlyButton(contentFrame, "Remove Network Pause", "remove_network_pause_internal")
        
        -- Private Server Button (VIP Only) - TAMBAHAN BARU
        local privateServerBtn = createVIPOnlyButton(contentFrame, "Private Server", "https://paste.monster/Zptmb376pEA9/raw")
        
        -- Override click function untuk Remove Network Pause karena ini internal function
        removeNetworkPauseBtn.MouseButton1Click:Connect(function()
            if not isVIP then
                appendToConsole(">> ACCESS DENIED: Remove Network Pause is VIP only!\n")
                appendToConsole(">> Upgrade to VIP to access premium tools\n")
                notify("VIP REQUIRED", "This tool is for VIP members only!", 4)
                return
            end
            
            appendToConsole(">> Removing Network Pause...\n")
            
            local success, result = removeNetworkPause()
            
            if success then
                appendToConsole(">> " .. result .. "\n")  
                notify("Network Pause", "Removed successfully!", 3)  
            else
                appendToConsole(">> Failed: " .. tostring(result) .. "\n")  
                notify("Network Pause", "Failed to remove!", 3)  
            end
        end)
          
    elseif tabName == "Own Script" then
        -- Enhanced Teleport Manager UI with ScrollingFrame
        
        -- Create main scrolling frame for the entire tab content
        local mainScrollFrame = Instance.new("ScrollingFrame", contentFrame)
        mainScrollFrame.Size = UDim2.new(1, 0, 1, 0)
        mainScrollFrame.Position = UDim2.new(0, 0, 0, 0)
        mainScrollFrame.BackgroundTransparency = 1
        mainScrollFrame.BorderSizePixel = 0
        mainScrollFrame.ScrollBarThickness = 8
        mainScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        mainScrollFrame.Name = "MainTeleportScrollFrame"
        
        -- Save Position Section
        local saveSection = Instance.new("Frame", mainScrollFrame)
        saveSection.Size = UDim2.new(1, -10, 0, 80)
        saveSection.Position = UDim2.new(0, 5, 0, 5)
        saveSection.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        saveSection.BackgroundTransparency = 0.3
        saveSection.BorderSizePixel = 0
        Instance.new("UICorner", saveSection).CornerRadius = UDim.new(0, 6)
        
        local saveLabel = Instance.new("TextLabel", saveSection)
        saveLabel.Size = UDim2.new(1, -10, 0, 20)
        saveLabel.Position = UDim2.new(0, 5, 0, 4)
        saveLabel.Text = "Save Current Position"
        saveLabel.TextColor3 = Color3.new(1, 1, 1)
        saveLabel.BackgroundTransparency = 1
        saveLabel.Font = Enum.Font.GothamSemibold
        saveLabel.TextSize = 14
        saveLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local nameInput = Instance.new("TextBox", saveSection)
        nameInput.Size = UDim2.new(0.6, -30, 0, 30)
        nameInput.Position = UDim2.new(0, 7, 0, 30)
        nameInput.PlaceholderText = "Location Name"
        nameInput.Text = ""
        nameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        nameInput.BackgroundTransparency = 0.2
        nameInput.TextColor3 = Color3.new(1, 1, 1)
        nameInput.Font = Enum.Font.Gotham
        nameInput.TextSize = 12
        Instance.new("UICorner", nameInput).CornerRadius = UDim.new(0, 4)
        
        local saveButton = Instance.new("TextButton", saveSection)
        saveButton.Size = UDim2.new(0.4, -8, 0, 30)
        saveButton.Position = UDim2.new(0.6, -3, 0, 29.5)
        saveButton.Text = "Save Pos"
        saveButton.BackgroundColor3 = Color3.fromRGB(65, 150, 80)
        saveButton.BackgroundTransparency = 0.1
        saveButton.TextColor3 = Color3.new(1, 1, 1)
        saveButton.Font = Enum.Font.GothamSemibold
        saveButton.TextSize = 12
        Instance.new("UICorner", saveButton).CornerRadius = UDim.new(0, 4)
        
        saveButton.MouseButton1Click:Connect(function()
            local locationName = nameInput.Text:gsub("^%s*(.-)%s*$", "%1")
            if locationName == "" then
                appendToConsole(">> Please enter a location name!\n")
                notify("Teleport", "Enter location name!", 2)
                return
            end
            
            if teleportLocations[locationName] then
                appendToConsole(">> Location name already exists!\n")
                notify("Teleport", "Name already exists!", 2)
                return
            end
            
            local currentPos = getCurrentPosition()
            if not currentPos then
                appendToConsole(">> Cannot get current position!\n")
                notify("Teleport", "Cannot get position!", 2)
                return
            end
            
            teleportLocations[locationName] = currentPos
            saveTeleportData()
            
            -- Refresh the teleport list in the scroll frame
            for _, child in ipairs(mainScrollFrame:GetChildren()) do
                if child.Name == "LocationsScrollFrame" then
                    refreshTeleportList(child, consoleOutput)
                    break
                end
            end
            
            nameInput.Text = ""
            appendToConsole(">> Saved location: " .. locationName .. "\n")
            notify("Teleport", "Saved " .. locationName, 2)
        end)
        
        -- File Management Section
        local fileSection = Instance.new("Frame", mainScrollFrame)
        fileSection.Size = UDim2.new(1, -10, 0, 110) -- Diperbesar dari 80 menjadi 110
        fileSection.Position = UDim2.new(0, 5, 0, 90)
        fileSection.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        fileSection.BackgroundTransparency = 0.3
        fileSection.BorderSizePixel = 0
        Instance.new("UICorner", fileSection).CornerRadius = UDim.new(0, 6)
        
        -- NEW: Save Preset Button (VIP Only)
        local savePresetBtn = createVIPOnlyPresetButton(fileSection, "Save Current as Preset", Color3.fromRGB(80, 50, 120), function()
            if not teleportLocations or next(teleportLocations) == nil then
                appendToConsole(">> No locations to save as preset!\n")
                notify("Preset", "No locations to save!", 2)
                return
            end
            
            showPresetNameDialog(function(presetName)
                local success, message = saveTeleportPreset(presetName)
                if success then
                    appendToConsole(">> " .. message .. "\n")
                    notify("Preset", message, 3)
                else
                    appendToConsole(">> " .. message .. "\n")
                    notify("Preset", message, 3)
                end
            end)
        end)
        savePresetBtn.Position = UDim2.new(0, 5, 0, 5) -- Posisi atas untuk Save Preset

        -- NEW: Load Preset Button (VIP Only)
        local loadPresetBtn = createVIPOnlyPresetButton(fileSection, "Load Preset", Color3.fromRGB(65, 120, 200), function()
            showPresetSelectionDialog(function(presetName)
                local success, message = loadTeleportPreset(presetName)
                if success then
                    -- Refresh the teleport list in the scroll frame
                    for _, child in ipairs(mainScrollFrame:GetChildren()) do
                        if child.Name == "LocationsScrollFrame" then
                            refreshTeleportList(child, consoleOutput)
                            break
                        end
                    end
                    appendToConsole(">> " .. message .. "\n")
                    notify("Preset", message, 3)
                else
                    appendToConsole(">> " .. message .. "\n")
                    notify("Preset", message, 3)
                end
            end)
        end)
        loadPresetBtn.Position = UDim2.new(0, 5, 0, 40) -- Posisi bawah untuk Load Preset
        
        -- Clear All Button (tetap free)
        local clearButton = Instance.new("TextButton", fileSection)
        clearButton.Size = UDim2.new(1, -10, 0, 30)
        clearButton.Position = UDim2.new(0, 5, 0, 75) -- Posisi disesuaikan
        clearButton.Text = "Clear All"
        clearButton.BackgroundColor3 = Color3.fromRGB(170, 65, 65)
        clearButton.BackgroundTransparency = 0.1
        clearButton.TextColor3 = Color3.new(1, 1, 1)
        clearButton.Font = Enum.Font.GothamSemibold
        clearButton.TextSize = 12
        Instance.new("UICorner", clearButton).CornerRadius = UDim.new(0, 4)
        
        clearButton.MouseButton1Click:Connect(function()
            teleportLocations = {}
            saveTeleportData()
            -- Refresh the teleport list in the scroll frame
            for _, child in ipairs(mainScrollFrame:GetChildren()) do
                if child.Name == "LocationsScrollFrame" then
                    refreshTeleportList(child, consoleOutput)
                    break
                end
            end
            appendToConsole(">> All locations cleared!\n")
            notify("Teleport", "All locations cleared", 2)
        end)
        
        -- Saved Locations Label
        local locationsLabel = Instance.new("TextLabel", mainScrollFrame)
        locationsLabel.Size = UDim2.new(1, -10, 0, 20)
        locationsLabel.Position = UDim2.new(0, 5, 0, 205)
        locationsLabel.Text = "Saved Locations:"
        locationsLabel.TextColor3 = Color3.new(1, 1, 1)
        locationsLabel.BackgroundTransparency = 1
        locationsLabel.Font = Enum.Font.GothamSemibold
        locationsLabel.TextSize = 14
        locationsLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Scroll frame for teleport locations (nested inside main scroll frame)
        local locationsScrollFrame = Instance.new("ScrollingFrame", mainScrollFrame)
        locationsScrollFrame.Size = UDim2.new(1, -10, 0, 200) -- Fixed height for locations list
        locationsScrollFrame.Position = UDim2.new(0, 5, 0, 230)
        locationsScrollFrame.BackgroundTransparency = 1
        locationsScrollFrame.BorderSizePixel = 0
        locationsScrollFrame.ScrollBarThickness = 6
        locationsScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        locationsScrollFrame.Name = "LocationsScrollFrame"
        
        -- Update main scroll frame canvas size when locations are added
        local function updateMainScrollSize()
            local locationsHeight = locationsScrollFrame.CanvasSize.Y.Offset
            local totalHeight = 230 + math.max(200, locationsHeight) -- Minimum 200px for locations section
            mainScrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 20)
        end
        
        -- Override refreshTeleportList to update main scroll size
        local originalRefreshTeleportList = refreshTeleportList
        refreshTeleportList = function(scrollFrame, consoleOutput)
            originalRefreshTeleportList(scrollFrame, consoleOutput)
            if scrollFrame.Name == "LocationsScrollFrame" then
                updateMainScrollSize()
            end
        end
        
        loadTeleportData()
        refreshTeleportList(locationsScrollFrame, consoleOutput)
        updateMainScrollSize()
        
    elseif tabName == "Main Scripts" then
        -- Create ScrollingFrame for Main Scripts dengan sistem Free/VIP
        local scrollFrame = Instance.new("ScrollingFrame", contentFrame)
        scrollFrame.Size = UDim2.new(1, 13, 1, 0)
        scrollFrame.Position = UDim2.new(0, 6, 0, -5)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel = 0
        scrollFrame.ScrollBarThickness = 8
        scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scrollFrame.Name = "MainScriptsScrollFrame"
        
        local buttons = {}
        local buttonHeight = 36
        local padding = 6
        local totalHeight = 0
        
        -- Section Label: FREE
        local freeLabel = Instance.new("TextLabel", scrollFrame)
        freeLabel.Size = UDim2.new(1, 0, 0, 25)
        freeLabel.Position = UDim2.new(0, 0, 0, totalHeight)
        freeLabel.Text = "FREE SCRIPTS"
        freeLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
        freeLabel.BackgroundTransparency = 1
        freeLabel.Font = Enum.Font.GothamBold
        freeLabel.TextSize = 14
        freeLabel.TextXAlignment = Enum.TextXAlignment.Left
        totalHeight = totalHeight + 25
        
        -- Free Scripts
        for name, url in pairs(data["Free"]) do
            local btn = createScriptButton(scrollFrame, name, url, false)
            btn.Position = UDim2.new(0, 0, 0, totalHeight)
            buttons[name] = btn
            totalHeight = totalHeight + buttonHeight + padding
        end
        
        -- Spacer antara Free dan VIP
        totalHeight = totalHeight + 10
        
        -- Section Label: VIP
        local vipLabel = Instance.new("TextLabel", scrollFrame)
        vipLabel.Size = UDim2.new(1, 0, 0, 25)
        vipLabel.Position = UDim2.new(0, 0, 0, totalHeight)
        vipLabel.Text = "VIP SCRIPTS"
        vipLabel.TextColor3 = Color3.fromRGB(255, 215, 80)
        vipLabel.BackgroundTransparency = 1
        vipLabel.Font = Enum.Font.GothamBold
        vipLabel.TextSize = 14
        vipLabel.TextXAlignment = Enum.TextXAlignment.Left
        totalHeight = totalHeight + 25
        
        -- VIP Scripts
        for name, url in pairs(data["VIP"]) do
            local btn = createScriptButton(scrollFrame, name, url, true)
            btn.Position = UDim2.new(0, 0, 0, totalHeight)
            buttons[name] = btn
            totalHeight = totalHeight + buttonHeight + padding
        end
        
        local function refreshFilter()
            local filter = searchBox.Text:lower()
            local currentY = 0
            
            -- Free section label
            freeLabel.Visible = false
            vipLabel.Visible = false
            
            local freeVisible = false
            local vipVisible = false
            
            -- Filter free scripts
            for name, btn in pairs(buttons) do
                if data["Free"][name] then
                    if filter == "" or name:lower():find(filter) then
                        if not freeVisible then
                            freeLabel.Visible = true
                            freeLabel.Position = UDim2.new(0, 0, 0, currentY)
                            currentY = currentY + 25
                            freeVisible = true
                        end
                        btn.Visible = true
                        btn.Position = UDim2.new(0, 0, 0, currentY)
                        currentY = currentY + buttonHeight + padding
                    else
                        btn.Visible = false
                    end
                end
            end
            
            -- Spacer jika ada free scripts yang visible
            if freeVisible then
                currentY = currentY + 10
            end
            
            -- Filter VIP scripts
            for name, btn in pairs(buttons) do
                if data["VIP"][name] then
                    if filter == "" or name:lower():find(filter) then
                        if not vipVisible then
                            vipLabel.Visible = true
                            vipLabel.Position = UDim2.new(0, 0, 0, currentY)
                            currentY = currentY + 25
                            vipVisible = true
                        end
                        btn.Visible = true
                        btn.Position = UDim2.new(0, 0, 0, currentY)
                        currentY = currentY + buttonHeight + padding
                    else
                        btn.Visible = false
                    end
                end
            end
            
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, currentY)
        end
        
        searchBox:GetPropertyChangedSignal("Text"):Connect(refreshFilter)
        refreshFilter()
        
    elseif tabName == "Credits" then
        -- Credits Tab Content (tanpa VIP Info section)
        
        -- Creator Section
        local creatorSection = Instance.new("Frame", contentFrame)
        creatorSection.Size = UDim2.new(1, 0, 0, 105)
        creatorSection.Position = UDim2.new(0, 5, 0, -55)
        creatorSection.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        creatorSection.BackgroundTransparency = 0.3
        creatorSection.BorderSizePixel = 0
        Instance.new("UICorner", creatorSection).CornerRadius = UDim.new(0, 8)
        
        local creatorHeader = Instance.new("TextLabel", creatorSection)
        creatorHeader.Size = UDim2.new(1, -10, 0, 25)
        creatorHeader.Position = UDim2.new(0, 5, 0, 5)
        creatorHeader.Text = "CREATOR"
        creatorHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
        creatorHeader.BackgroundTransparency = 1
        creatorHeader.Font = Enum.Font.GothamBold
        creatorHeader.TextSize = 16
        creatorHeader.TextXAlignment = Enum.TextXAlignment.Left
        
        local creatorInfo = Instance.new("TextLabel", creatorSection)
        creatorInfo.Size = UDim2.new(1, -10, 0, 60)
        creatorInfo.Position = UDim2.new(0, 5, 0, 30)
        creatorInfo.Text = "YouTube: XuKrost OFC\nTikTok: noiree\nInstagram: @snn2ndd_"
        creatorInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
        creatorInfo.BackgroundTransparency = 1
        creatorInfo.Font = Enum.Font.Gotham
        creatorInfo.TextSize = 12
        creatorInfo.TextXAlignment = Enum.TextXAlignment.Left
        creatorInfo.TextYAlignment = Enum.TextYAlignment.Top
        creatorInfo.TextWrapped = true
        
        local copyCreatorBtn = Instance.new("TextButton", creatorSection)
        copyCreatorBtn.Size = UDim2.new(1, -10, 0, 25)
        copyCreatorBtn.Position = UDim2.new(0, 5, 1, -30)
        copyCreatorBtn.Text = "Copy Creator Info"
        copyCreatorBtn.BackgroundColor3 = Color3.fromRGB(65, 120, 200)
        copyCreatorBtn.BackgroundTransparency = 0.1
        copyCreatorBtn.TextColor3 = Color3.new(1, 1, 1)
        copyCreatorBtn.Font = Enum.Font.GothamSemibold
        copyCreatorBtn.TextSize = 12
        Instance.new("UICorner", copyCreatorBtn).CornerRadius = UDim.new(0, 6)
        
        copyCreatorBtn.MouseButton1Click:Connect(function()
            local creatorText = "YouTube: XuKrost OFC\nTikTok: noiree\nInstagram: @snn2ndd_"
            if copyToClipboard(creatorText) then
                appendToConsole(">> Creator info copied to clipboard!\n")
                notify("Creator Info", "Info creator telah disalin ke clipboard", 2)
            else
                appendToConsole(">> Failed to copy creator info!\n")
                notify("Error", "Failed to copy creator info", 2)
            end
        end)
        
        -- Discord Section
        local discordSection = Instance.new("Frame", contentFrame)
        discordSection.Size = UDim2.new(1, 0, 0, 60)
        discordSection.Position = UDim2.new(0, 5, 0, 55)
        discordSection.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        discordSection.BackgroundTransparency = 0.3
        discordSection.BorderSizePixel = 0
        Instance.new("UICorner", discordSection).CornerRadius = UDim.new(0, 8)
        
        local discordHeader = Instance.new("TextLabel", discordSection)
        discordHeader.Size = UDim2.new(1, -10, 0, 25)
        discordHeader.Position = UDim2.new(0, 5, 0, 5)
        discordHeader.Text = "DISCORD"
        discordHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
        discordHeader.BackgroundTransparency = 1
        discordHeader.Font = Enum.Font.GothamBold
        discordHeader.TextSize = 16
        discordHeader.TextXAlignment = Enum.TextXAlignment.Left
        
        local discordBtn = Instance.new("TextButton", discordSection)
        discordBtn.Size = UDim2.new(1, -10, 0, 25)
        discordBtn.Position = UDim2.new(0, 5, 1, -30)
        discordBtn.Text = "Join Discord Server"
        discordBtn.BackgroundColor3 = Color3.fromRGB(90, 100, 230)
        discordBtn.BackgroundTransparency = 0.1
        discordBtn.TextColor3 = Color3.new(1, 1, 1)
        discordBtn.Font = Enum.Font.GothamSemibold
        discordBtn.TextSize = 12
        Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0, 6)
        
        discordBtn.MouseButton1Click:Connect(function()
            appendToConsole(">> Opening Discord invite...\n")
            if copyToClipboard("https://discord.gg/RpYcMdzzwd") then
                notify("Discord", "Discord link copied to clipboard!", 3)
                appendToConsole(">> Discord link copied to clipboard!\n")
            else
                notify("Discord", "Failed to copy Discord link", 3)
                appendToConsole(">> Failed to copy Discord link!\n")
            end
        end)
        
        -- Contributor Section
        local contributorSection = Instance.new("Frame", contentFrame)
        contributorSection.Size = UDim2.new(1, 0, 0, 57)
        contributorSection.Position = UDim2.new(0, 5, 0, 120)
        contributorSection.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        contributorSection.BackgroundTransparency = 0.3
        contributorSection.BorderSizePixel = 0
        Instance.new("UICorner", contributorSection).CornerRadius = UDim.new(0, 8)
        
        local contributorHeader = Instance.new("TextLabel", contributorSection)
        contributorHeader.Size = UDim2.new(1, -10, 0, 25)
        contributorHeader.Position = UDim2.new(0, 5, 0, -0)
        contributorHeader.Text = "CONTRIBUTOR :"
        contributorHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
        contributorHeader.BackgroundTransparency = 1
        contributorHeader.Font = Enum.Font.GothamBold
        contributorHeader.TextSize = 16
        contributorHeader.TextXAlignment = Enum.TextXAlignment.Left
        
        local contributorName = Instance.new("TextLabel", contributorSection)
        contributorName.Size = UDim2.new(1, -10, 0, 20)
        contributorName.Position = UDim2.new(0, 125, 0, 2)
        contributorName.Text = "Natsyn"
        contributorName.TextColor3 = Color3.fromRGB(200, 200, 200)
        contributorName.BackgroundTransparency = 1
        contributorName.Font = Enum.Font.Gotham
        contributorName.TextSize = 14
        contributorName.TextXAlignment = Enum.TextXAlignment.Left
        
        local copyContributorBtn = Instance.new("TextButton", contributorSection)
        copyContributorBtn.Size = UDim2.new(1, -10, 0, 25)
        copyContributorBtn.Position = UDim2.new(0, 5, 1, -30)
        copyContributorBtn.Text = "Copy Instagram Link"
        copyContributorBtn.BackgroundColor3 = Color3.fromRGB(170, 65, 120)
        copyContributorBtn.BackgroundTransparency = 0.1
        copyContributorBtn.TextColor3 = Color3.new(1, 1, 1)
        copyContributorBtn.Font = Enum.Font.GothamSemibold
        copyContributorBtn.TextSize = 12
        Instance.new("UICorner", copyContributorBtn).CornerRadius = UDim.new(0, 6)
        
        copyContributorBtn.MouseButton1Click:Connect(function()
            local instagramLink = "https://www.instagram.com/env.example?igsh=bThpNWM3dXJjc2hr"
            if copyToClipboard(instagramLink) then
                appendToConsole(">> Contributor Instagram link copied!\n")
                notify("Contributor", "Link Instagram telah disalin ke clipboard", 3)
            else
                appendToConsole(">> Failed to copy contributor link!\n")
                notify("Error", "Failed to copy Instagram link", 2)
            end
        end)
        
    else  
        local listLayout = Instance.new("UIListLayout", contentFrame)  
        listLayout.Padding = UDim.new(0,6)  

        local buttons = {}  
        local function refreshFilter()  
            local filter = searchBox.Text:lower()  
            for name,btn in pairs(buttons) do  
                btn.Visible = (filter == "" or name:lower():find(filter))  
            end  
        end  

        for name,url in pairs(data) do  
            local btn = Instance.new("TextButton", contentFrame)  
            btn.Size = UDim2.new(1, 0, 0, 36)  
            btn.Text = name  
            btn.Font = Enum.Font.GothamSemibold  
            btn.TextSize = 14  
            btn.TextColor3 = Color3.new(1,1,1)  
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
            btn.BackgroundTransparency = 0.1
            btn.BorderSizePixel = 0  
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)  

            btn.MouseButton1Click:Connect(function()  
                appendToConsole(">> Loading "..name.."\n")  
                local ok,msg = fetchAndRun(url)      
                if ok then      
                    appendToConsole(">> "..name.." loaded!\n")      
                    notify("XuKrost Hub", name.." success",3)      
                else      
                    appendToConsole(">> "..name.." failed: "..tostring(msg).."\n")      
                    notify("XuKrost Hub", name.." failed: "..tostring(msg),5)      
                end      
            end)  

            buttons[name] = btn  
        end  

        if tabName == "Main Scripts" then  
            searchBox:GetPropertyChangedSignal("Text"):Connect(refreshFilter)  
            refreshFilter()  
        end  
    end
end

for tabName,data in pairs(scripts) do
    createTabContent(tabName,data)
end

-- Default tab
switchTab("Player Info")

-- Bubble button (hidden by default)
local bubbleButton = Instance.new("TextButton", screenGui)
bubbleButton.Size = UDim2.new(0, 50, 0, 40)
bubbleButton.Position = UDim2.new(0.05, 0, 0.1, 0)
bubbleButton.BackgroundColor3 = Color3.fromRGB(65, 120, 200)
bubbleButton.BackgroundTransparency = 0.1
bubbleButton.Text = "XHUB"
bubbleButton.Font = Enum.Font.GothamBlack
bubbleButton.TextSize = 14
bubbleButton.TextColor3 = Color3.new(1,1,1)
bubbleButton.Draggable = true
bubbleButton.Visible = false
bubbleButton.BorderSizePixel = 0
Instance.new("UICorner", bubbleButton).CornerRadius = UDim.new(0,6)

-- FIX: Minimize/Close actions dengan ukuran frame yang konsisten
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    if minimized then return end
    minimized = true
    TweenService:Create(mainFrame,TweenInfo.new(0.3),{Size=UDim2.new(0,0,0,0)}):Play()
    task.delay(0.35,function()
        mainFrame.Visible = false
        bubbleButton.Visible = true
    end)
end)

bubbleButton.MouseButton1Click:Connect(function()
    bubbleButton.Visible = false
    mainFrame.Visible = true
    TweenService:Create(mainFrame,TweenInfo.new(0.3),{Size=ORIGINAL_FRAME_SIZE}):Play()
    minimized = false
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Initialize VIP status dan Key System
task.spawn(function()
    refreshVIPStatus(consoleOutput)
    
    -- Jika user adalah VIP, otomatis skip key system
    if isVIP then
        keyAccepted = true
        keyChecked = true
        appendToConsole(">> VIP User detected, skipping key system\n")
    else
        appendToConsole(">> Free user detected, key system will activate when using free scripts\n")
    end
end)

notify(HubName,"XuKrost Hub Successfully loaded! have fun!",4)