local Player = game.Players.LocalPlayer
local PcItems = Player:WaitForChild("PcItems")

local Remotes = game:GetService("ReplicatedStorage").Resources.Remotes.RemoteEvents
local Shop = workspace.Shop

local shopItemsInfo = {}

--// Indexing all items

function getPriceAndCurrency(priceValue)
    local price = string.gsub(priceValue, "%D", "")
    local currency
    
    if string.find(priceValue, "Cash") then
        currency = "Cash"
    elseif string.find(priceValue, "Gold") then
        currency = "Gold"
    end
    
    return price, currency
end

function getNeededValue(theParent)
      for _,v in pairs(theParent:GetChildren()) do
            if v.Name == "BuyButton" then
                for _,ok in pairs(v:GetChildren()) do
                    if ok.Name == "Attachment" then
                        for _,oks in pairs(ok:GetChildren()) do
                            if oks.Name == "ProximityPrompt" then
                                for _,okse in pairs(oks:GetChildren()) do 
                                    if okse.Name == "Cost" then
                                        return okse.Value  
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
end

function indexCategory(theFolder)
    local gatheredInfo = {}
  
    for _,theItem in pairs(theFolder:GetChildren()) do
        local valueToConvert = getNeededValue(theItem)
        
        local price, theCurrency
        
        task.spawn(function()
            price, theCurrency = getPriceAndCurrency(valueToConvert)
        end)
        
    
        gatheredInfo[theItem.Name] = {
          ["Price"] = price,
          ["Currency"] = theCurrency
        }
    end
  
    return gatheredInfo
end


function getAllTypes()
    for _,category in pairs(Shop:GetChildren()) do
        if category:IsA("Folder") then
            if category.Name ~= "Buttons" then
                shopItemsInfo[category.Name] = indexCategory(category)
            end
        end
    end
end

getAllTypes()

--// PC Building Functions
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

print(shopItemsInfo.Cases["Plain Case"].Currency)

print("Main scipt loaded")
