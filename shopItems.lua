local shopItems = {}

local collectedInfo = {}

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
        
        print()
        print(theItem.Name)
        print("PRICE: ", price)
        print("CURRENCY: ", theCurrency)
    
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
                print()
                print(category.Name)
                collectedInfo[category.Name] = indexCategory(category)
            end
        end
    end
end


function shopItems.indexAllItems()
    getAllTypes()
end

return shopItems
