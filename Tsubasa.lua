-- Tsuren Hub V3.2 FULL HUB CORE
-- Made by TsurenStudios

-- =========================
-- LOADING SCREEN
-- =========================
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,300,0,120)
Frame.Position = UDim2.new(0.5,-150,0.5,-60)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)

local Text = Instance.new("TextLabel", Frame)
Text.Size = UDim2.new(1,0,1,0)
Text.Text = "Tsuren Hub V3.2\nLoading..."
Text.TextColor3 = Color3.new(1,1,1)
Text.BackgroundTransparency = 1
wait(2)
ScreenGui:Destroy()

-- =========================
-- SERVICES
-- =========================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- =========================
-- SEA DETECT
-- =========================
local First_Sea = game.PlaceId == 2753915549
local Second_Sea = game.PlaceId == 4442272183
local Third_Sea  = game.PlaceId == 7449423635
-- =========================
-- AttackNoCD Fonksiyonu
-- =========================
-- Seçilen silah ile cooldown olmadan saldırı yapar
function AttackNoCD()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char then return end

    local tool = char:FindFirstChild(SelectWeapon)
    if not tool then
        -- Eğer seçilen silah yoksa backpack'ten silahı al
        local backpackTool = player.Backpack:FindFirstChild(SelectWeapon)
        if backpackTool then
            backpackTool.Parent = char
            tool = backpackTool
        else
            return
        end
    end

    -- Silah varsa attack fonksiyonunu tetikle
    if tool:IsA("Tool") then
        tool:Activate()
    end
end

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
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Tsuren Hub V3.2",
    SubTitle = "Blox Fruits",
    Size = UDim2.fromOffset(600,480),
    Theme = "Dark"
})

-- =========================
-- TABS
-- =========================
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

-- =========================
-- GLOBAL FARM SYSTEM
-- =========================
_G.Fast_Delay = 0.15
_G.FastAttackFaiFao = true
_G.BringMob = true
BypassTP = false
ChooseWeapon = "Melee"
SelectWeapon = nil
posX,posY,posZ = 0,20,0

-- =========================
-- WEAPON SELECT SYSTEM
-- =========================
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
 if LocalPlayer.Backpack:FindFirstChild(tool) then
  LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack[tool])
 end
end

-- =========================
-- TWEEN CORE
-- =========================
function Tween(cf)
 local dist = (HumanoidRootPart.Position - cf.Position).Magnitude
 local speed = dist/300
 local t = TweenService:Create(HumanoidRootPart,TweenInfo.new(speed,Enum.EasingStyle.Linear),{CFrame=cf})
 t:Play()
 return t
end

-- =========================
-- ATTACK CORE
-- =========================
function AttackNoCD()
 game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
end

function AutoHaki()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char then return end
    if not char:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
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
Options.ToggleAutoFarmBoss:SetValue(false)

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
    Options.ToggleFactory:SetValue(false)

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

-- Quest Tabı
local QuestTab = Tabs.Quest:AddSection("Quest System")

-- =========================
-- Toggle Auto Elite Hunter
-- =========================
local ToggleElite = Tabs.Quest:AddToggle("ToggleElite", {Title = "Auto Elite Hunter", Default = false})
ToggleElite:OnChanged(function(Value)
    _G.AutoElite = Value
end)
Options.ToggleElite:SetValue(false)

-- =========================
-- Toggle Auto Tushita
-- =========================
local ToggleTushita = Tabs.Quest:AddToggle("ToggleTushita", {Title = "Auto Tushita", Default = false})
ToggleTushita:OnChanged(function(Value)
    AutoTushita = Value
end)
Options.ToggleTushita:SetValue(false)

-- =========================
-- Toggle Auto Holy Torch
-- =========================
local ToggleHoly = Tabs.Quest:AddToggle("ToggleHoly", {Title = "Auto Holy Torch", Default = false})
ToggleHoly:OnChanged(function(Value)
    _G.Auto_Holy_Torch = Value
end)
Options.ToggleHoly:SetValue(false)

-- =========================
-- Toggle Auto Level
-- =========================
local ToggleLevel = Tabs.Quest:AddToggle("ToggleLevel", {Title = "Auto Level", Default = false})
ToggleLevel:OnChanged(function(Value)
    _G.AutoLevel = Value
end)
Options.ToggleLevel:SetValue(false)

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
-- Auto Holy Torch
local ToggleHoly = Tabs.Quest:AddToggle("ToggleHoly", {Title = "Auto Holy Torch", Default = false})
ToggleHoly:OnChanged(function(Value)
    _G.Auto_Holy_Torch = Value
end)
Options.ToggleHoly:SetValue(false)

spawn(function()
    while wait() do
        if _G.Auto_Holy_Torch then
            -- =========================
-- AUTO HOLY TORCH (FULL)
-- =========================

local QuestHoly = Tabs.Quest:AddSection("Holy Torch Quest")

local ToggleHoly = QuestHoly:AddToggle("ToggleHoly", {
    Title = "Auto Holy Torch",
    Description = "Auto complete Holy Torch puzzle",
    Default = false
})

ToggleHoly:OnChanged(function(Value)
    _G.Auto_Holy_Torch = Value

-- Auto Level
local ToggleLevel = Tabs.Quest:AddToggle("ToggleLevel", {Title = "Auto Level", Default = false})
ToggleLevel:OnChanged(function(Value)
    _G.AutoLevel = Value
end)
Options.ToggleLevel:SetValue(false)

spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            
local QuestSection = Tabs.Main:AddSection("Auto Level")

-- Auto Level Toggle
local ToggleAutoLevel = QuestSection:AddToggle("ToggleLevel", {
    Title = "Auto Level",
    Description = "Automatically complete quests to level up",
    Default = false
})
ToggleAutoLevel:OnChanged(function(Value)
    _G.AutoLevel = Value
end)
Options.ToggleLevel:SetValue(false)

-- Auto Level Loop
spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                -- Check current quest
                CheckLevel() -- bu fonksiyon quest/level kontrolü yapacak

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
end)
-- Auto Level
Tabs.Quest:AddToggle("AutoLevel",{Title="Auto Level"}):OnChanged(function(v)
 _G.AutoLevel = v
end)

-- =========================
-- AUTO LEVEL SCRIPT
-- =========================
local QuestSection = Tabs.Main:AddSection("Auto Level")

-- Auto Level Toggle
local ToggleAutoLevel = QuestSection:AddToggle("ToggleLevel", {
    Title = "Auto Level",
    Description = "Automatically complete quests to level up",
    Default = false
})
ToggleAutoLevel:OnChanged(function(Value)
    _G.AutoLevel = Value
end)
Options.ToggleLevel:SetValue(false)

-- Auto Level Loop
spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                -- Check current quest
                CheckLevel() -- bu fonksiyon quest/level kontrolü yapacak

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

-- Auto Elite
Tabs.Quest:AddToggle("AutoElite",{Title="Auto Elite Hunter"}):OnChanged(function(v)
 _G.AutoElite = v
end)

-- =========================
-- AUTO ELITE HUNTER
-- =========================

local QuestElite = Tabs.Quest:AddSection("Elite Hunter")

local ToggleElite = QuestElite:AddToggle("ToggleElite", {
    Title = "Auto Elite Hunter",
    Description = "Auto hunt Elite bosses (Third Sea)",
    Default = false
})

ToggleElite:OnChanged(function(Value)
    _G.AutoElite = Value
end)
Options.ToggleElite:SetValue(false)

-- Elite Quest Data
local EliteNPC = CFrame.new(-5419, 313, -2826) -- Elite Hunter NPC (Third Sea)
local EliteBossList = {"Diablo", "Deandre", "Urban"}

-- Function: Check Elite Quest
function GetEliteQuest()
    local QuestGui = game.Players.LocalPlayer.PlayerGui.Main.Quest
    if QuestGui.Visible then
        local title = QuestGui.Container.QuestTitle.Title.Text
        for _,boss in pairs(EliteBossList) do
            if string.find(title, boss) then
                return boss
            end
        end
    end
    return nil
end

-- Function: Take Elite Quest
function TakeEliteQuest()
    Tween(EliteNPC)
    wait(1)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
end

-- Auto Elite Loop
spawn(function()
    while task.wait() do
        if _G.AutoElite then
            pcall(function()
                if not Third_Sea then return end

                local player = game.Players.LocalPlayer
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                -- Quest yoksa al
                local BossTarget = GetEliteQuest()
                if not BossTarget then
                    TakeEliteQuest()
                    wait(2)
                    BossTarget = GetEliteQuest()
                end

                -- Elite boss spawn olmuş mu?
                if BossTarget then
                    if game.Workspace.Enemies:FindFirstChild(BossTarget) then
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == BossTarget and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                repeat
                                    wait(_G.Fast_Delay)

                                    -- Attack System
                                    AttackNoCD()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)

                                    -- Tween + Position
                                    Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))

                                    -- Lock Boss
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid.JumpPower = 0
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.CanCollide = false
                                    v.Humanoid:ChangeState(11)

                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name

                                until not _G.AutoElite 
                                    or not v.Parent 
                                    or v.Humanoid.Health <= 0
                            end
                        end
                    else
                        -- Boss henüz spawn değil → spawn noktalarına dolaş
                        for i,v in pairs(game.Workspace._WorldOrigin.EnemySpawns:GetChildren()) do
                            for _,boss in pairs(EliteBossList) do
                                if string.find(v.Name, boss) then
                                    Tween(v.CFrame)
                                    wait(0.5)
                                end
                            end
                        end
                    end
                else
                    -- Quest alınamadıysa tekrar NPC'ye dön
                    TakeEliteQuest()
                end
            end)
        end
    end
end)

-- Auto Tushita
Tabs.Quest:AddToggle("AutoTushita",{Title="Auto Tushita"}):OnChanged(function(v)
 AutoTushita = v
end)

-- =========================
-- AUTO TUSHITA (FULL)
-- =========================

local QuestTushita = Tabs.Quest:AddSection("Tushita Quest")

local ToggleTushita = QuestTushita:AddToggle("ToggleTushita", {
    Title = "Auto Tushita",
    Description = "Auto kill Longma & complete Tushita quest",
    Default = false
})

ToggleTushita:OnChanged(function(Value)
    AutoTushita = Value
end)
Options.ToggleTushita:SetValue(false)

-- Longma Position (Third Sea)
local LongmaPos = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)

-- Main Loop
spawn(function()
    while task.wait() do
        if AutoTushita then
            pcall(function()
                if not Third_Sea then return end

                local player = game.Players.LocalPlayer
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                -- Longma Spawn Kontrol
                if game.Workspace.Enemies:FindFirstChild("Longma") then
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == "Longma" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat
                                wait(_G.Fast_Delay)

                                -- Attack System
                                AttackNoCD()
                                AutoHaki()

                                -- Weapon Select
                                if not char:FindFirstChild(SelectWeapon) then
                                    EquipTool(SelectWeapon)
                                end

                                -- Tween To Boss
                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))

                                -- Boss Lock System
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid.JumpPower = 0
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.CanCollide = false
                                v.Humanoid:ChangeState(11)

                                -- Bring Mob Support
                                FarmPos = v.HumanoidRootPart.CFrame
                                MonFarm = v.Name

                            until not AutoTushita 
                                or not v.Parent 
                                or v.Humanoid.Health <= 0
                        end
                    end
                else
                    -- Longma spawn değilse adaya git
                    repeat
                        Tween(LongmaPos)
                        wait()
                    until not AutoTushita 
                        or (hrp.Position - Vector3.new(-10238, 389, -9549)).Magnitude <= 15
                end
            end)
        end
    end
end)

-- Auto Holy Torch
Tabs.Quest:AddToggle("AutoHoly",{Title="Auto Holy Torch"}):OnChanged(function(v)
 _G.Auto_Holy_Torch = v
end)

-- =========================
-- AUTO HOLY TORCH (FULL)
-- =========================

local QuestHoly = Tabs.Quest:AddSection("Holy Torch Quest")

local ToggleHoly = QuestHoly:AddToggle("ToggleHoly", {
    Title = "Auto Holy Torch",
    Description = "Auto complete Holy Torch puzzle",
    Default = false
})

ToggleHoly:OnChanged(function(Value)
    _G.Auto_Holy_Torch = Value
end)
Options.ToggleHoly:SetValue(false)

-- Holy Torch Locations (Third Sea)
local HolyTorches = {
    Vector3.new(-10752, 417, -9366),
    Vector3.new(-11672, 334, -9474),
    Vector3.new(-12132, 521, -10655),
    Vector3.new(-13336, 486, -6985),
    Vector3.new(-13489, 332, -7925)
}

-- Main Loop
spawn(function()
    while task.wait() do
        if _G.Auto_Holy_Torch then
            pcall(function()
                if not Third_Sea then return end

                local player = game.Players.LocalPlayer
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                for i,pos in pairs(HolyTorches) do
                    if not _G.Auto_Holy_Torch then break end

                    -- Tween to torch position
                    repeat
                        Tween(CFrame.new(pos))
                        wait()
                    until not _G.Auto_Holy_Torch 
                        or (hrp.Position - pos).Magnitude <= 10

                    -- Small wait to trigger torch
                    wait(1)
                end
            end)
        end
    end
end)

-- =========================
-- FRUIT / RAID TAB
-- =========================
local FruitSec = Tabs.Fruit:AddSection("Fruit & Raid")

-- =========================
-- FRUIT TELEPORT SYSTEM
-- =========================

local FruitSection = Tabs.Fruit:AddSection("Fruit Teleport")

local ToggleFruitTP = FruitSection:AddToggle("ToggleFruitTP", {
    Title = "Fruit Teleport",
    Description = "Auto teleport to dropped fruits",
    Default = false
})

ToggleFruitTP:OnChanged(function(Value)
    _G.AutoFruitTeleport = Value
end)
Options.ToggleFruitTP:SetValue(false)

local ToggleFruitNotify = FruitSection:AddToggle("ToggleFruitNotify", {
    Title = "Fruit Notification",
    Default = true
})

ToggleFruitNotify:OnChanged(function(Value)
    _G.FruitNotify = Value
end)
Options.ToggleFruitNotify:SetValue(true)

-- Fruit Detection Folder
local FruitFolder = workspace:FindFirstChild("Fruit") or workspace:FindFirstChild("Fruits")

-- Notification Function
local function NotifyFruit(name)
    if _G.FruitNotify then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "🍍 Fruit Detected",
            Text = "Found: "..name,
            Duration = 5
        })
    end
end

-- Check Backpack
local function HasFruit()
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
Options.ToggleAutoRaid:SetValue(false)

local ToggleAutoNextRaid = RaidSection:AddToggle("ToggleAutoNextRaid", {
    Title = "Auto Next Raid",
    Default = true
})

ToggleAutoNextRaid:OnChanged(function(Value)
    _G.AutoNextRaid = Value
end)
Options.ToggleAutoNextRaid:SetValue(true)

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
Options.ToggleFruitNotify:SetValue(false)

local ToggleAutoFruitTP = FruitNotify:AddToggle("ToggleAutoFruitTP", {
    Title = "Auto Teleport To Fruit",
    Default = false
})

ToggleAutoFruitTP:OnChanged(function(Value)
    _G.AutoFruitTP = Value
end)
Options.ToggleAutoFruitTP:SetValue(false)

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
Options.ToggleAutoChest:SetValue(false)

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

    Options.ToggleSeaBeast:SetValue(false)

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
local MiscSec = Tabs.Misc:AddSection("Misc + ESP")

-- Island ESP Toggle
Tabs.Misc:AddToggle("IslandESP",{Title="Island ESP"}):OnChanged(function(v)
 IslandESP = v
end)

-- =========================
-- ISLAND ESP SYSTEM
-- =========================
IslandESP = true -- Toggle için default

function round(num)
    return math.floor(num + 0.5)
end

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
                        name.Name = "TextLabel"
                        name.Parent = bill
                        name.Font = Enum.Font.GothamBold
                        name.FontSize = Enum.FontSize.Size14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = Enum.TextYAlignment.Top
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(255, 255, 255)
                        name.Text = v.Name
                    else
                        local distance = round((LocalPlayer.Character.Head.Position - v.Position).Magnitude/3)
                        v['NameEsp'].TextLabel.Text = v.Name .. "   \n" .. distance .. " Distance"
                    end
                end
            else
                if v:FindFirstChild('NameEsp') then
                    v:FindFirstChild('NameEsp'):Destroy()
                end
            end
        end)
    end
end

-- RenderStepped ile sürekli güncelle
game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        UpdateIslandESP()
    end)
end)

-- =========================
-- MISC: TEAM + SHOP + UI OPEN
-- =========================

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plr = game:GetService("Players").LocalPlayer

-- TEAM SECTION
Misc:Section({Title="Team"})

Misc:Button({Title="Join Pirates Team",Callback=function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam","Pirates")
end})

Misc:Button({Title="Join Marines Team",Callback=function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam","Marines")
end})

-- OPEN UI SECTION
Misc:Section({Title="Open UI"})

Misc:Button({Title="Devil Shop Menu",Callback=function()
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("GetFruits")
        plr.PlayerGui.Main.FruitShop.Visible = true
    end)
end})

Misc:Button({Title="Color Haki Menu",Callback=function()
    pcall(function()
        plr.PlayerGui.Main.Colors.Visible = true
    end)
end})

Misc:Button({Title="Title Name Menu",Callback=function()
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("getTitles")
        plr.PlayerGui.Main.Titles.Visible = true
    end)
end})

Misc:Button({Title="Awakening Menu",Callback=function()
    pcall(function()
        plr.PlayerGui.Main.AwakeningToggler.Visible = true
    end)
end})

-- =========================
-- SETTINGS TAB
-- =========================
local SetSec = Tabs.Setting:AddSection("Farm Settings")

-- Fast Attack
Tabs.Setting:AddToggle("FastAttack",{Title="Fast Attack",Default=true}):OnChanged(function(v)
 _G.FastAttackFaiFao = v
end)

-- Bring Mob
Tabs.Setting:AddToggle("BringMob",{Title="Bring Mob",Default=true}):OnChanged(function(v)
 _G.BringMob = v
end)

-- Bypass TP
Tabs.Setting:AddToggle("BypassTP",{Title="Bypass TP"}):OnChanged(function(v)
 BypassTP = v
end)

-- Remove Damage Text
Tabs.Setting:AddToggle("RemoveText",{Title="Remove Damage Text"}):OnChanged(function(v)
 FaiFaoRemovetext = v
end)

-- Delay Setting
Tabs.Setting:AddSlider("Delay",{Title="Attack Delay",Min=0.03,Max=0.3,Default=0.15}):OnChanged(function(v)
 _G.Fast_Delay = v
end)

-- =========================
-- Fly Setting (Full & Extra)
-- =========================
local FlySettings = {}
FlySettings.Enabled = false
FlySettings.Speed = 100          -- Fly speed ayarı
FlySettings.UpKey = Enum.KeyCode.E
FlySettings.DownKey = Enum.KeyCode.Q
FlySettings.StopOnTeleport = true
FlySettings.NoClip = true
FlySettings.HoverHeight = 5       -- Uçarken sabit yükseklik
FlySettings.GravityFix = true

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local FlyVelocity = Vector3.new(0,0,0)
local FlyDirection = Vector3.new(0,0,0)
local UpDown = 0

local function EnableFly()
    if FlySettings.Enabled then return end
    FlySettings.Enabled = true
    HumanoidRootPart.Anchored = false
    if FlySettings.NoClip then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

local function DisableFly()
    FlySettings.Enabled = false
    if FlySettings.NoClip then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Key input
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == FlySettings.UpKey then
        UpDown = 1
    elseif input.KeyCode == FlySettings.DownKey then
        UpDown = -1
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == FlySettings.UpKey or input.KeyCode == FlySettings.DownKey then
        UpDown = 0
    end
end)

-- Fly loop
RunService.RenderStepped:Connect(function(delta)
    if FlySettings.Enabled then
        local cam = workspace.CurrentCamera
        local forward = cam.CFrame.LookVector
        local right = cam.CFrame.RightVector

        FlyDirection = Vector3.new(0,UpDown,0)

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            FlyDirection = FlyDirection + forward
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            FlyDirection = FlyDirection - forward
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            FlyDirection = FlyDirection - right
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            FlyDirection = FlyDirection + right
        end

        FlyVelocity = FlyDirection.Unit * FlySettings.Speed
        if FlyDirection.Magnitude == 0 then FlyVelocity = Vector3.new(0,UpDown*FlySettings.Speed,0) end

        HumanoidRootPart.Velocity = FlyVelocity
        if FlySettings.GravityFix then
            HumanoidRootPart.AssemblyLinearVelocity = FlyVelocity
        end
    else
        HumanoidRootPart.Velocity = Vector3.new(0,0,0)
    end
end)

-- Teleport safety
Player.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    if FlySettings.StopOnTeleport then
        DisableFly()
    end
end)

-- Toggle function
function ToggleFly(enable)
    if enable then
        EnableFly()
    else
        DisableFly()
    end
end

-- Kullanım örneği:
-- ToggleFly(true)  -- Fly aç
-- ToggleFly(false) -- Fly kapat
-- FlySettings.Speed = 200 -- Fly hızı değiştir

-- =========================
-- ANTI BAN (SECURITY)
-- =========================
function AntiBan()
 for i,v in pairs(LocalPlayer.Character:GetDescendants()) do
  if v:IsA("LocalScript") then
   if v.Name=="General" or v.Name=="Shiftlock" or v.Name=="FallDamage" or v.Name=="CamBob" then
    v:Destroy()
   end
  end
 end
 for i,v in pairs(LocalPlayer.PlayerScripts:GetDescendants()) do
  if v:IsA("LocalScript") then
   if v.Name=="Codes" or v.Name=="PlayerList" or v.Name=="MenuBloodSp" then
    v:Destroy()
   end
  end
 end
end
AntiBan()
