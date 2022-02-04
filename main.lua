print("Main scipt loaded")

local Player = game.Players.LocalPlayer
local PcItems = Player:WaitForChild("PcItems")

local Remotes = game:GetService("ReplicatedStorage").Resources.Remotes.RemoteEvents
local Shop = workspace.Shop

local shopItemsModule = loadstring(game:HttpGet("https://github.com/Pixeluted/CustomPcTycconHack/raw/main/shopItems.lua"))
print(shopItemsModule)
shopItemsModule.indexAllItems()

local function placeCase(caseType)
    Remotes.PlaceItem:FireServer(caseType)
    Remotes.BuildPc:FireServer("finish editing component")
end

local function placeMotherboard(MotherboardObject)
    Remotes.PlacePart:FireServer("Motherboard", MotherboardObject)
    Remotes.BuildPc:FireServer("groupPart")
end

local function placePowerSuply(PowerSupplyObject)
    Remotes.PlacePart:FireServer("PowerSuply", PowerSupplyObject)
    Remotes.BuildPc:FireServer("groupPart")
end

local function placeCPU(CPUObject)
    Remotes.PlacePart:FireServer("Cpu", CPUObject)
    Remotes.BuildPc:FireServer("groupPart") 
end

local function placeGPU(GPUObject)
    Remotes.PlacePart:FireServer("Gpu", GPUObject)
    Remotes.BuildPc:FireServer("groupPart") 
end


local function placeRAM(RAMObject)
    Remotes.PlacePart:FireServer("Ram", RAMObject)
    Remotes.BuildPc:FireServer("groupPart") 
end

local function placeMemory(MemoryObject)
    Remotes.PlacePart:FireServer("Memory", MemoryObject)
    Remotes.BuildPc:FireServer("groupPart")   
end

local function placeFan(FanObject)
    Remotes.PlacePart:FireServer("Fan", FanObject)
    Remotes.BuildPc:FireServer("groupPart") 
end

local function placeOtherCooling(OtherObject)
    Remotes.PlacePart:FireServer("Air", OtherObject)
    Remotes.BuildPc:FireServer("groupPart") 
end
