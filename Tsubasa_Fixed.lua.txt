-- GUI Loading
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,300,0,120)
Frame.Position = UDim2.new(0.5,-150,0.5,-60)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)

local Text = Instance.new("TextLabel", Frame)
Text.Size = UDim2.new(1,0,1,0)
Text.Text = "Tsuren Hub V3.3\nLoading..."
Text.TextColor3 = Color3.new(1,1,1)
Text.BackgroundTransparency = 1
wait(2)
ScreenGui:Destroy()

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

-- Player and Character
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart") or Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:FindFirstChild("Humanoid")

-- Anti-AFK
local VirtualUser = game:service('VirtualUser')
game:service('Players').LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Attack No Cooldown
function AttackNoCD()
    pcall(function()
        if VirtualUser then
            VirtualUser:Button1Down(Vector2.new(0,0))
            RunService.RenderStepped:Wait()
            VirtualUser:Button1Up(Vector2.new(0,0))
        end
    end)
end

-- Auto Haki
function AutoHaki()
    local player = Players.LocalPlayer
    local char = player.Character
    if not char then return end
    if not char:FindFirstChild("HasBuso") then
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes and remotes:FindFirstChild("CommF_") then
            pcall(function()
                remotes.CommF_:InvokeServer("Buso")
            end)
        end
    end
end

-- Equip Weapon
function EquipTool(ToolName)
    pcall(function()
        if not Humanoid then return end
        local tool = Player.Backpack:FindFirstChild(ToolName)
        if tool then
            Humanoid:EquipTool(tool)
        end
    end)
end

-- Tween Function
function Tween(CF)
    if not HumanoidRootPart then return end
    local distance = (HumanoidRootPart.Position - CF.Position).Magnitude
    local tweenInfo = TweenInfo.new(distance / 300, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = CF})
    tween:Play()
    return tween
end

-- Bypass Teleport
function BTP(CF)
    if HumanoidRootPart then
        HumanoidRootPart.CFrame = CF
    end
end

-- =========================
-- SEA DETECT
-- =========================
local First_Sea = game.PlaceId == 2753915549
local Second_Sea = game.PlaceId == 4442272183
local Third_Sea  = game.PlaceId == 7449423635
-- =========================

-- =========================
-- MONSTER + AREA LIST
-- =========================
if First_Sea then
tableMon = {"Bandit","Monkey","Gorilla","Pirate","Brute","Desert Bandit","Desert Officer","Snow Bandit","Snowman","Chief Petty Officer","Sky Bandit","Dark Master","Prisoner","Dangerous Prisoner","Toga Warrior","Gladiator","Military Soldier","Military Spy","Fishman Warrior","Fishman Commando","God's Guard","Shanda","Royal Squad","Royal Soldier","Galley Pirate","Galley Captain"}
AreaList = {'Jungle','Buggy','Desert','Snow','Marine','Sky','Prison','Colosseum','Magma','Fishman','Sky Island','Fountain'}

elseif Second_Sea then
tableMon = {"Raider","Mercenary","Swan Pirate","Factory Staff","Marine Lieutenant","Marine Captain","Zombie","Vampire","Snow Trooper","Winter Warrior","Lab Subordinate","Horned Warrior","Magma Ninja","Lava Pirate","Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer","Arctic Warrior","Snow Lurker","Sea Soldier","Water Fighter"}
AreaList = {'Area 1','Area 2','Zombie','Marine','Snow Mountain','Ice Fire','Ship','Frost','Forgotten'}

elseif Third_Sea then
tableMon = {"Pirate Millionaire","Dragon Crew Warrior","Dragon Crew Archer","Female Islander","Giant Islander","Marine Commodore","Marine Rear Admiral","Fishman Raider","Fishman Captain","Forest Pirate","Mythological Pirate","Jungle Pirate","Musketeer Pirate","Reborn Skeleton","Demonic Soul","Posessed Mummy","Peanut Scout","Peanut President","Ice Cream Chef","Ice Cream Commander","Cookie Crafter","Cake Guard","Baking Staff","Head Baker","Cocoa Warrior","Chocolate Bar Battler","Sweet Thief","Candy Rebel","Candy Pirate","Snow Demon","Isle Outlaw","Island Boy","Isle Champion"}
AreaList = {'Pirate Port','Amazon','Marine Tree','Deep Forest','Haunted Castle','Nut Island','Ice Cream Island','Cake Island','Choco Island','Candy Island','Tiki Outpost'}
end

-- =========================
-- UI LOAD
-- =========================
local Fluent = nil
local success, err = pcall(function()
    -- Try loading the new UI Framework requested
    Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"))()
end)

if not success or not Fluent or type(Fluent) ~= "table" or not Fluent.CreateWindow then
    warn("New UI failed to load or is incompatible. Loading fallback Fluent UI... Error: " .. tostring(err))
    Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/main.lua"))()
end

-- Fallback check if everything fails
if not Fluent then
    game.Players.LocalPlayer:Kick("Failed to load UI Library. Please check your internet connection.")
    return
end

local Window = Fluent:CreateWindow({
    Title = "TsurenHub (Fixed)",
    SubTitle = "Blox Fruits",
    Size = UDim2.fromOffset(600,480),
    Theme = "Dark"
})

local Tabs = {
 Main = Window:AddTab({Title="Main Farm",Icon="swords"}),
 Quest = Window:AddTab({Title="Quest",Icon="scroll"}),
 Fruit = Window:AddTab({Title="Fruit / Raid",Icon="apple"}),
 Chest = Window:AddTab({Title="Chest",Icon="box"}),
 Teleport = Window:AddTab({Title="Teleport",Icon="map"}),
 Stats = Window:AddTab({Title="Stats",Icon="bar-chart"}),
 Sea = Window:AddTab({Title="Sea",Icon="waves"}),
 Misc = Window:AddTab({Title="Misc",Icon="settings"}),
 Setting = Window:AddTab({Title="Settings",Icon="sliders"})
}


local LocalPlayer = game:GetService("Players").LocalPlayer

-- =========================
-- GLOBAL VARIABLES FIX
-- =========================
_G.AutoFarm = false
_G.AutoBoss = false
_G.AutoLevel = false
_G.AutoElite = false
_G.Factory = false
_G.Auto_Holy_Torch = false
_G.AutoTushita = false
_G.Fast_Delay = 0.15
_G.BringMob = true
BypassTP = false
SelectWeapon = nil
ChooseWeapon = "Melee"
posX,posY,posZ = 0,20,0

-- Quest ve Monster Fix
NameMon = ""       -- Auto Level / Quest için hedef canavar adı
NameQuest = ""     -- Quest adı
QuestLv = 1        -- Quest level
CFrameQ = CFrame.new(0,0,0) -- Quest noktasına tween pozisyonu
Ms = ""            -- Monster hedefi (AutoLevel)


task.spawn(function()
 while task.wait() do
  pcall(function()
   for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
    if ChooseWeapon=="Melee" and v.ToolTip=="Melee" then SelectWeapon=v.Name end
    if ChooseWeapon=="Sword" and v.ToolTip=="Sword" then SelectWeapon=v.Name end
    if ChooseWeapon=="Blox Fruit" and v.ToolTip=="Blox Fruit" then SelectWeapon=v.Name end
   end
  end)
 end
end)

function EquipTool(tool)
    if tool and LocalPlayer.Backpack:FindFirstChild(tool) then
        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack[tool])
    end
end


-- =========================
-- MAIN FARM TAB
-- =========================
local FarmSec = Tabs.Main:AddSection("Main Farming")

-- Auto Farm Toggle
Tabs.Main:AddToggle("AutoFarm",{Title="Auto Farm Monster"}):OnChanged(function(v)
 _G.AutoFarm = v
end)

-- =========================
-- AUTO FARM SCRIPT
-- =========================
spawn(function()
    while wait() do
        if _G.AutoFarm then
            pcall(function()
                -- Seviye kontrol
                if _G.AutoLevel then
                    for i,v in pairs(AreaList) do
                        -- Quest yoksa başlat
                        local QuestGui = LocalPlayer.PlayerGui.Main.Quest
if not QuestGui.Visible or not string.find(QuestGui.Container.QuestTitle.Title.Text, tableMon[i]) then
                            -- Abandon Quest
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                            -- Tween ile quest noktasına git
                            local CFrameQ = CFrame.new(0,0,0) -- burayı quest pozuna göre ayarlayacaksın
                            if BypassTP then
                                if (HumanoidRootPart.Position - CFrameQ.Position).Magnitude > 2500 then
                                    HumanoidRootPart.CFrame = CFrameQ
                                else
                                    Tween(CFrameQ)
                                end
                            else
                                Tween(CFrameQ)
                            end
                            wait(0.2)
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", tableMon[i], i)
                        end
                    end
                end

                -- Monster Farm
                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        for _,M in pairs(tableMon) do
                            if v.Name == M then
                                -- Tween + Attack + Haki
                                repeat
                                    wait(_G.Fast_Delay)
                                    AttackNoCD()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid.JumpPower = 0
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.CanCollide = false
                                until not _G.AutoFarm or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end
                end

                -- Spawn noktalarına tween (AreaList)
                for i,v in pairs(game.Workspace["_WorldOrigin"].EnemySpawns:GetChildren()) do
                    for _,M in pairs(tableMon) do
                        if string.find(v.Name,M) then
                            if (HumanoidRootPart.Position - v.Position).Magnitude >= 10 then
                                Tween(v.CFrame * CFrame.new(posX,posY,posZ))
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Auto Boss
Tabs.Main:AddToggle("AutoBoss",{Title="Auto Boss Farm"}):OnChanged(function(v)
 _G.AutoBoss = v
end)

-- =========================
-- AUTO BOSS SCRIPT
-- =========================
local BossSection = Tabs.Main:AddSection("Boss Farm")

-- Sea Detect & Boss List
local tableBoss = {}
if First_Sea then
    tableBoss = {"The Gorilla King","Bobby","Yeti","Mob Leader","Vice Admiral","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Saber Expert"}
elseif Second_Sea then
    tableBoss = {"Diamond","Jeremy","Fajita","Don Swan","Smoke Admiral","Cursed Captain","Darkbeard","Order","Awakened Ice Admiral","Tide Keeper"}
elseif Third_Sea then
    tableBoss = {"Stone","Island Empress","Kilo Admiral","Captain Elephant","Beautiful Pirate","rip_indra True Form","Longma","Soul Reaper","Cake Queen"}
end

-- Boss Dropdown
local DropdownBoss = Tabs.Main:AddDropdown("DropdownBoss", {
    Title = "Choose Boss",
    Description = "",
    Values = tableBoss,
    Multi = false,
    Default = 1,
})
DropdownBoss:SetValue(tableBoss[1])
DropdownBoss:OnChanged(function(Value)
    _G.SelectBoss = Value
end)

-- Auto Boss Toggle
local ToggleAutoBoss = Tabs.Main:AddToggle("ToggleAutoFarmBoss", {
    Title = "Auto Kill Boss",
    Description = "",
    Default = false
})
ToggleAutoBoss:OnChanged(function(Value)
    _G.AutoBoss = Value
end)

-- Boss Farm Loop
spawn(function()
    while wait() do
        if _G.AutoBoss then
            pcall(function()
                local boss = game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss)
                if boss then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == _G.SelectBoss and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat
                                wait(_G.Fast_Delay)
                                -- Attack + Haki + Weapon
                                AttackNoCD()
                                AutoHaki()
                                EquipTool(SelectWeapon)

                                -- Boss Tween
                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))

                                -- Boss ayarları
                                v.HumanoidRootPart.Size = Vector3.new(80,80,80)
                                v.HumanoidRootPart.CanCollide = false
                                v.Humanoid.WalkSpeed = 0

                                -- FarmPos + MonFarm global
                                FarmPos = v.HumanoidRootPart.CFrame
                                MonFarm = v.Name
                            until not _G.AutoBoss or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                else
                    -- Eğer boss spawn yoksa ReplicatedStorage üzerinden tween
                    local bossStorage = game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss)
                    if bossStorage then
                        Tween(bossStorage.HumanoidRootPart.CFrame * CFrame.new(5,10,7))
                    end
                end
            end)
        end
    end
end)


-- =========================
-- AUTO FACTORY SCRIPT
-- =========================
if Second_Sea then
    local ToggleFactory = Tabs.Main:AddToggle("ToggleFactory", {Title = "Auto Farm Factory", Default = false })
    ToggleFactory:OnChanged(function(Value)
        _G.Factory = Value
    end)

    spawn(function()
        while wait() do
            if _G.Factory then
                if game.Workspace.Enemies:FindFirstChild("Core") then
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == "Core" and v:FindFirstChild("Humanoid") and v:Humanoid.Health > 0 then
                            repeat
                                wait(_G.Fast_Delay)
                                -- Attack + Haki + Weapon
                                AttackNoCD()
                                EquipTool(SelectWeapon)
                                AutoHaki()
                                -- Tween Factory Pozisyonu
                                repeat Tween(CFrame.new(448.46756, 199.356781, -441.389252))
                                    wait()
                                until not _G.Factory or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(448.46756, 199.356781, -441.389252)).Magnitude <= 10
                                
                                -- Farm Pos ayarla
                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid.JumpPower = 0
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.CanCollide = false
                                FarmPos = v.HumanoidRootPart.CFrame
                                MonFarm = v.Name
                            until not v.Parent or v.Humanoid.Health <= 0 or _G.Factory == false
                        end
                    end
                elseif game.ReplicatedStorage:FindFirstChild("Core") then
                    -- Eğer spawn yoksa tween ile Factory pozisyonuna git
                    repeat Tween(CFrame.new(448.46756, 199.356781, -441.389252))
                        wait()
                    until not _G.Factory or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(448.46756, 199.356781, -441.389252)).Magnitude <= 10
                end
            end
        end
    end)
end

-- =========================
-- QUEST TAB
-- =========================
local QuestSec = Tabs.Quest:AddSection("Quest System")

-- =========================
-- Toggle Auto Elite Hunter
-- =========================
local ToggleElite = Tabs.Quest:AddToggle("ToggleElite", {Title = "Auto Elite Hunter", Default = false})
ToggleElite:OnChanged(function(Value)
    _G.AutoElite = Value
end)

-- =========================
-- Toggle Auto Tushita
-- =========================
local ToggleTushita = Tabs.Quest:AddToggle("ToggleTushita", {Title = "Auto Tushita", Default = false})
ToggleTushita:OnChanged(function(Value)
    AutoTushita = Value
end)

-- =========================
-- Toggle Auto Holy Torch
-- =========================
local ToggleHoly = Tabs.Quest:AddToggle("ToggleHoly", {Title = "Auto Holy Torch", Default = false})
ToggleHoly:OnChanged(function(Value)
    _G.Auto_Holy_Torch = Value
end)

-- =========================
-- Toggle Auto Level
-- =========================
local ToggleLevel = Tabs.Quest:AddToggle("ToggleLevel", {Title = "Auto Level", Default = false})
ToggleLevel:OnChanged(function(Value)
    _G.AutoLevel = Value
end)

-- =========================
-- forQuest() Fonksiyonu
-- =========================
function forQuest()
    pcall(function()
        -- Auto Elite Hunter Script burada çalışacak
        if _G.AutoElite then
            -- buraya Auto Elite Hunter script paste yerine kodlar çalışır
        end

        -- Auto Tushita Script
        if AutoTushita then
            -- buraya Auto Tushita script paste yerine kodlar çalışır
        end

        -- Auto Holy Torch Script
        if _G.Auto_Holy_Torch then
            -- buraya Auto Holy Torch script paste yerine kodlar çalışır
        end

        -- Auto Level Script
        if _G.AutoLevel then
            -- buraya Auto Level script paste yerine kodlar çalışır
        end
    end)
end

-- =========================
-- Quest Main Loop
-- =========================
spawn(function()
    while task.wait() do
        forQuest()
    end
end)         

spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                local questActive = player.PlayerGui.Main.Quest.Visible
                local questText = questActive and player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text or ""

                if not string.find(questText, NameMon) or not questActive then
                    -- Quest yoksa abandon ve yeniden al
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                    if BypassTP then
                        if (hrp.Position - CFrameQ.Position).Magnitude > 2500 then
                            BTP(CFrameQ)
                        else
                            Tween(CFrameQ)
                        end
                    else
                        Tween(CFrameQ)
                    end

                    if (CFrameQ.Position - hrp.Position).Magnitude <= 5 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                else
                    -- Quest varsa, monster farm
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            if v.Name == Ms then
                                repeat
                                    wait(_G.Fast_Delay)
                                    AttackNoCD()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid.JumpPower = 0
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.CanCollide = false
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                                until not _G.AutoLevel or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name) or not questActive
                            end
                        end
                    end

                    -- Spawn noktalarına gidip Tween ile farm
                    for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do
                        if string.find(v.Name, NameMon) then
                            if (hrp.Position - v.Position).Magnitude >= 10 then
                                Tween(v.CFrame * CFrame.new(posX,posY,posZ))
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- =========================
-- FRUIT / RAID TAB
-- =========================
local FruitSec = Tabs.Fruit:AddSection("Fruit System")

-- Auto Buy Fruit
Tabs.Fruit:AddToggle("AutoBuyFruit",{Title="Auto Buy Fruit (Sniper)"}):OnChanged(function(v)
 _G.AutoBuyFruit = v
end)

-- Auto Teleport Fruit
Tabs.Fruit:AddToggle("AutoFruitTeleport",{Title="Auto Teleport to Fruit"}):OnChanged(function(v)
 _G.AutoFruitTeleport = v
end)

-- Fruit Functions
function HasFruit()
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if string.find(v.Name, "Fruit") then
            return true
        end
    end
    return false
end

-- Main Loop
spawn(function()
    while task.wait(1) do
        if _G.AutoFruitTeleport then
            pcall(function()

                local player = game.Players.LocalPlayer
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                -- Don't pick if already have fruit
                if HasFruit() then return end

                -- Search dropped fruits
                for i,v in pairs(workspace:GetChildren()) do
                    if not _G.AutoFruitTeleport then break end

                    if v:IsA("Tool") and string.find(v.Name, "Fruit") then
                        local handle = v:FindFirstChild("Handle")
                        if handle then

                            NotifyFruit(v.Name)

                            -- Tween to fruit
                            repeat
                                Tween(handle.CFrame * CFrame.new(0, 2, 0))
                                wait()
                            until not _G.AutoFruitTeleport
                                or (hrp.Position - handle.Position).Magnitude <= 8
                                or not v.Parent

                            -- Try pick up
                            wait(0.3)
                        end
                    end
                end

            end)
        end
    end
end)

-- =========================
-- AUTO RAID SYSTEM
-- =========================

local RaidSection = Tabs.Fruit:AddSection("Raid")

local ToggleAutoRaid = RaidSection:AddToggle("ToggleAutoRaid", {
    Title = "Auto Raid",
    Description = "Auto enter & clear raids",
    Default = false
})

ToggleAutoRaid:OnChanged(function(Value)
    _G.AutoRaid = Value
end)

local ToggleAutoNextRaid = RaidSection:AddToggle("ToggleAutoNextRaid", {
    Title = "Auto Next Raid",
    Default = true
})

ToggleAutoNextRaid:OnChanged(function(Value)
    _G.AutoNextRaid = Value
end)

-- Raid Door Position (Second Sea default)
local RaidDoorCFrame = CFrame.new(-6438.73, 250.645, -4501.506)

-- Check In Raid
local function IsInRaid()
    return game:GetService("Workspace"):FindFirstChild("_WorldOrigin")
       and game:GetService("Workspace")["_WorldOrigin"]:FindFirstChild("Raid")
end

-- Open Raid
local function OpenRaid()
    pcall(function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc","Select","Flame")
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc","Start")
    end)
end

-- Main Raid Loop
spawn(function()
    while task.wait(1) do
        if _G.AutoRaid then
            pcall(function()

                local player = game.Players.LocalPlayer
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                -- Not in raid → go open one
                if not IsInRaid() then
                    Tween(RaidDoorCFrame)
                    if (hrp.Position - RaidDoorCFrame.Position).Magnitude <= 8 then
                        OpenRaid()
                    end
                    return
                end

                -- In Raid → Farm All Enemies
                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if not _G.AutoRaid then break end

                    if v:FindFirstChild("Humanoid")
                    and v:FindFirstChild("HumanoidRootPart")
                    and v.Humanoid.Health > 0 then

                        repeat wait(_G.Fast_Delay)

                            AttackNoCD()
                            AutoHaki()

                            if not char:FindFirstChild(SelectWeapon) then
                                EquipTool(SelectWeapon)
                            end

                            Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))

                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                            v.HumanoidRootPart.Transparency = 1
                            v.Humanoid.JumpPower = 0
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.CanCollide = false

                            FarmPos = v.HumanoidRootPart.CFrame
                            MonFarm = v.Name

                        until not _G.AutoRaid
                            or not v.Parent
                            or v.Humanoid.Health <= 0
                    end
                end

                -- Raid Finished
                if _G.AutoNextRaid then
                    wait(5)
                else
                    _G.AutoRaid = false
                end

            end)
        end
    end
end)

-- =========================
-- FRUIT NOTIFICATION SYSTEM
-- =========================

local FruitNotify = Tabs.Fruit:AddSection("Fruit Notification")

local ToggleFruitNotify = FruitNotify:AddToggle("ToggleFruitNotify", {
    Title = "Fruit Notification",
    Description = "Notify when fruit spawned",
    Default = false
})

ToggleFruitNotify:OnChanged(function(Value)
    _G.FruitNotify = Value
end)

local ToggleAutoFruitTP = FruitNotify:AddToggle("ToggleAutoFruitTP", {
    Title = "Auto Teleport To Fruit",
    Default = false
})

ToggleAutoFruitTP:OnChanged(function(Value)
    _G.AutoFruitTP = Value
end)

local FruitTimerSlider = FruitNotify:AddSlider("FruitTimer", {
    Title = "Scan Delay (Seconds)",
    Min = 5,
    Max = 60,
    Default = 10,
    Rounding = 0
})

FruitTimerSlider:OnChanged(function(Value)
    _G.FruitScanDelay = Value
end)
_G.FruitScanDelay = 10

-- Cache
local DetectedFruits = {}

-- Notify Function
local function NotifyFruit(FruitName, Distance)
    game.StarterGui:SetCore("SendNotification", {
        Title = "🍍 Fruit Spawned!",
        Text = FruitName.." | Distance: "..math.floor(Distance),
        Duration = 8
    })
end

-- Main Scan Loop
spawn(function()
    while task.wait(1) do
        if _G.FruitNotify then
            pcall(function()

                local player = game.Players.LocalPlayer
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                    if v:IsA("Tool") and string.find(v.Name,"Fruit") then

                        -- New fruit detected
                        if not DetectedFruits[v] then
                            DetectedFruits[v] = true

                            local dist = (hrp.Position - v.Handle.Position).Magnitude

                            -- Notification
                            NotifyFruit(v.Name, dist)

                            -- Auto Teleport
                            if _G.AutoFruitTP then
                                Tween(v.Handle.CFrame * CFrame.new(0,3,0))
                            end
                        end
                    end
                end

            end)

            wait(_G.FruitScanDelay)
        end
    end
end)
-- =========================
-- CHEST TAB
-- =========================
local ChestSec = Tabs.Chest:AddSection("Chest System")

Tabs.Chest:AddToggle("AutoChest",{Title="Auto Chest (Tween)"}):OnChanged(function(v)
 _G.AutoChest = v
end)

-- =========================
-- AUTO CHEST FARM SYSTEM
-- =========================

local ChestSection = Tabs.Chest:AddSection("Auto Chest Farm")

local ToggleAutoChest = ChestSection:AddToggle("ToggleAutoChest", {
    Title = "Auto Chest Farm",
    Description = "Auto collect all chests (Tween Only)",
    Default = false
})

ToggleAutoChest:OnChanged(function(Value)
    _G.AutoChest = Value
end)

local ChestDelaySlider = ChestSection:AddSlider("ChestDelay", {
    Title = "Chest Delay",
    Min = 0.2,
    Max = 3,
    Default = 0.5,
    Rounding = 2
})

ChestDelaySlider:OnChanged(function(Value)
    _G.ChestDelay = Value
end)
_G.ChestDelay = 0.5

-- Cache
local CollectedChest = {}

-- Get All Chests
local function GetAllChests()
    local chestTable = {}

    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v.Name == "Chest1" or v.Name == "Chest2" or v.Name == "Chest3" then
            if v:IsA("Model") and v:FindFirstChild("TouchInterest", true) then
                table.insert(chestTable, v)
            end
        end
    end

    return chestTable
end

-- Find Nearest Chest
local function GetNearestChest()
    local player = game.Players.LocalPlayer
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local nearest, dist = nil, math.huge

    for i,v in pairs(GetAllChests()) do
        if v:FindFirstChild("Part") and not CollectedChest[v] then
            local d = (hrp.Position - v.Part.Position).Magnitude
            if d < dist then
                dist = d
                nearest = v
            end
        end
    end

    return nearest
end

-- Touch Chest
local function CollectChest(chest)
    pcall(function()
        for i,v in pairs(chest:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
            end
        end
    end)
end

-- Main Loop
spawn(function()
    while task.wait() do
        if _G.AutoChest then
            pcall(function()

                local player = game.Players.LocalPlayer
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                local chest = GetNearestChest()

                if chest and chest:FindFirstChild("Part") then
                    local targetCF = chest.Part.CFrame * CFrame.new(0,3,0)

                    -- Tween to chest
                    Tween(targetCF)

                    repeat task.wait()
                    until not _G.AutoChest 
                    or (hrp.Position - chest.Part.Position).Magnitude <= 6
                    or not chest.Parent

                    if chest and chest.Parent then
                        -- Collect
                        CollectChest(chest)
                        CollectedChest[chest] = true
                        task.wait(_G.ChestDelay)
                    end
                else
                    -- No more chest
                    wait(3)
                end

            end)
        end
    end
end)

-- =========================
-- TELEPORT TAB
-- =========================
local TpSec = Tabs.Teleport:AddSection("Teleport")

-- =========================
-- ISLAND TELEPORT SYSTEM
-- =========================

local TeleportSection = Tabs.Teleport:AddSection("Island Teleport")

-- Area List (Sea Detect ile)
local AreaList = {}

if First_Sea then
    AreaList = {
      'Jungle','Buggy','Desert','Snow','Marine','Sky','Prison','Colosseum','Magma','Fishman','Sky Island','Fountain'
    }
elseif Second_Sea then
    AreaList = {
      'Area 1','Area 2','Zombie','Marine','Snow Mountain','Ice fire','Ship','Frost','Forgotten'
    }
elseif Third_Sea then
    AreaList = {
      'Pirate Port','Amazon','Marine Tree','Deep Forest','Haunted Castle','Nut Island',
      'Ice Cream Island','Cake Island','Choco Island','Candy Island','Tiki Outpost'
    }
end

-- Dropdown Island
local DropdownIsland = Tabs.Teleport:AddDropdown("DropdownIsland", {
    Title = "Select Island",
    Description = "",
    Values = AreaList,
    Multi = false,
    Default = 1,
})

DropdownIsland:SetValue(AreaList[1])

DropdownIsland:OnChanged(function(Value)
    _G.SelectIsland = Value
end)

-- Teleport Button
Tabs.Teleport:AddButton({
    Title = "Teleport To Island",
    Description = "Tween Teleport",
    Callback = function()
        pcall(function()
            local IslandFolder = game:GetService("Workspace")["_WorldOrigin"].Locations
            for i,v in pairs(IslandFolder:GetChildren()) do
                if v.Name == _G.SelectIsland then
                    Tween(v.CFrame * CFrame.new(0,5,0))
                end
            end
        end)
    end
})

-- =========================
-- TELEPORT SEA SYSTEM
-- =========================

local SeaSection = Tabs.Teleport:AddSection("Teleport Sea")

-- Sea 1
Tabs.Teleport:AddButton({
    Title = "Teleport Sea 1",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end
})

-- Sea 2
Tabs.Teleport:AddButton({
    Title = "Teleport Sea 2",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})

-- Sea 3
Tabs.Teleport:AddButton({
    Title = "Teleport Sea 3",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end
})

-- =========================
-- STATS TAB
-- =========================
local StatSec = Tabs.Stats:AddSection("Auto Stats")

-- =========================
-- STATS SYSTEM
-- =========================

local StatsSection = Tabs.Stats:AddSection("Player Stats")

-- Stat Options
local StatsOptions = {"Melee","Defense","Sword","Gun","Blox Fruit"}

local DropdownStat = Tabs.Stats:AddDropdown("DropdownStat", {
    Title = "Select Stat",
    Values = StatsOptions,
    Multi = false,
    Default = 1,
})

DropdownStat:SetValue(StatsOptions[1])

DropdownStat:OnChanged(function(Value)
    _G.SelectStat = Value
end)

-- Stat Amount Slider
local SliderStatAmount = Tabs.Stats:AddSlider("SliderStatAmount", {
    Title = "Stat Amount",
    Min = 15,
    Max = 300,
    Default = 15,
    Color = Color3.fromRGB(255, 170, 0),
    Increment = 1
})

SliderStatAmount:OnChanged(function(Value)
    _G.StatAmount = Value
end)

-- Apply Stat Button
Tabs.Stats:AddButton({
    Title = "Set Stat",
    Description = "Apply selected stat amount",
    Callback = function()
        pcall(function()
            local player = game.Players.LocalPlayer
            local args = {
                [1] = "AddPoint",
                [2] = _G.SelectStat,
                [3] = _G.StatAmount
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end)
    end
})

-- Auto Stat Toggle
local ToggleAutoStat = Tabs.Stats:AddToggle("ToggleAutoStat", {
    Title = "Auto Stat",
    Default = false
})

ToggleAutoStat:OnChanged(function(Value)
    _G.AutoStat = Value
end)

spawn(function()
    while task.wait() do
        if _G.AutoStat then
            pcall(function()
                local player = game.Players.LocalPlayer
                if player:FindFirstChild("Points") and player.Points.Value > 0 then
                    local args = {
                        [1] = "AddPoint",
                        [2] = _G.SelectStat,
                        [3] = math.min(_G.StatAmount, player.Points.Value)
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end
            end)
        end
    end
end)

-- =========================
-- SEA TAB
-- =========================
local SeaSec = Tabs.Sea:AddSection("Sea System")

-- Auto Sea Beast
Tabs.Sea:AddToggle("AutoSeaBeast",{Title="Auto Sea Beast"}):OnChanged(function(v)
 _G.AutoSeaBeast = v
end)

-- =========================
-- SEA BEAST SYSTEM (Third Sea)
-- =========================

if Third_Sea then
    local SeaSection = Tabs.Sea:AddSection("Sea Beast")

    -- Toggle Auto Sea Beast
    local ToggleSeaBeast = Tabs.Sea:AddToggle("ToggleSeaBeast", {
        Title = "Auto Sea Beast",
        Default = false
    })

    ToggleSeaBeast:OnChanged(function(Value)
        _G.AutoSeaBeast = Value
    end)

    -- Skill toggles
    _G.SkillZ = true
    _G.SkillX = true
    _G.SkillC = true
    _G.SkillV = true
    _G.AutoSkill = false
    _G.SkillAimBot = false
    _G.AimBotTarget = nil

    -- Auto Skill Handler
    spawn(function()
        while wait() do
            if _G.AutoSkill then
                if _G.SkillZ then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                end
                if _G.SkillX then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
                end
                if _G.SkillC then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "C", false, game)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, "C", false, game)
                end
                if _G.SkillV then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "V", false, game)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, "V", false, game)
                end
            end
        end
    end)

    -- Auto Sea Beast Farming
    spawn(function()
        while wait() do
            pcall(function()
                if _G.AutoSeaBeast then
                    local seaBeasts = game:GetService("Workspace").SeaBeasts:GetChildren()
                    local boats = game:GetService("Workspace").Boats:GetChildren()
                    
                    -- Check if no SeaBeast spawned
                    if #seaBeasts == 0 then
                        -- Tween to Pirate Boat if exists
                        local targetBoat = nil
                        for _, b in pairs(boats) do
                            if b.Name == "PirateGrandBrigade" or b.Name == "PirateBasic" then
                                targetBoat = b
                                break
                            end
                        end
                        if targetBoat then
                            TweenBoat(targetBoat.VehicleSeat.CFrame * CFrame.new(0,1,0))
                        else
                            -- Buy Boat if none exists
                            TweenBoat(CFrame.new(-4513.9, 16.76, -2658.82))
                            local args = {"BuyBoat","PirateGrandBrigade"}
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                    end

                    -- Sea Beast exists
                    for _, v in pairs(seaBeasts) do
                        if v:FindFirstChild("HumanoidRootPart") then
                            repeat
                                -- Ensure player is sitting false
                                local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                                local hum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
                                hum.Sit = false

                                -- Tween to Sea Beast
                                TweenBoat(v.HumanoidRootPart.CFrame * CFrame.new(0,500,0))

                                -- Equip all weapons
                                EquipAllWeapon()
                                _G.AutoSkill = true
                                _G.SkillAimBot = true
                                _G.AimBotTarget = v.HumanoidRootPart
                            until not v:FindFirstChild("HumanoidRootPart") or _G.AutoSeaBeast == false

                            _G.AutoSkill = false
                            _G.SkillAimBot = false
                        end
                    end
                end
            end)
        end
    end)
end

-- =========================
-- MISC TAB
-- =========================
local MiscSec = Tabs.Misc:AddSection("Misc/ESP")

-- Noclip Toggle (FIX)
Tabs.Misc:AddToggle("Noclip",{Title="Noclip (Fixed)"}):OnChanged(function(v)
    _G.Noclip = v
end)

-- Noclip Loop
spawn(function()
    while task.wait() do
        if _G.Noclip then
            pcall(function()
                if game.Players.LocalPlayer.Character then
                    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        end
    end
end)

-- Island ESP Toggle
_G.IslandESP = false

Tabs.Misc:AddToggle("IslandESP", {
    Title = "Island ESP",
    Default = false
}):OnChanged(function(v)
    _G.IslandESP = v
end)

-- =========================
-- ISLAND ESP SYSTEM
-- =========================
IslandESP = true -- Toggle için default
local function round(n)
return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)

function UpdateIslandESP()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local LocationsFolder = workspace:WaitForChild("_WorldOrigin"):WaitForChild("Locations")

    for i, v in pairs(LocationsFolder:GetChildren()) do
        pcall(function()
            if IslandESP then
                if v.Name ~= "Sea" then
                    if not v:FindFirstChild('NameEsp') then
                        -- Billboard GUI oluştur
                        local bill = Instance.new('BillboardGui')
                        bill.Name = 'NameEsp'
                        bill.ExtentsOffset = Vector3.new(0, 5, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        bill.Parent = v

                        local name = Instance.new('TextLabel')
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = Enum.FontSize.Size14
                        name.TextWrapped = true
                        name.Text = v.Name
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = Enum.TextYAlignment.Top
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(255, 255, 255)
                        name.Parent = bill
                    else
                        v.NameEsp.Enabled = true
                    end
                end
            else
                if v:FindFirstChild('NameEsp') then
                    v.NameEsp.Enabled = false
                end
            end
        end)
    end
end

spawn(function()
    while wait(1) do
        UpdateIslandESP()
    end
end)
