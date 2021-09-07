local admins = {904988568} --Change with your Account ID and if are many admins Change with your Roblox Id Separated from a comma
 
local timeUnits = {d = 24*60*60, h = 60*60, m = 60, s = 1}
 
 
local dss = game:GetService("DataStoreService")
local banDS = dss:GetDataStore("BanData")
 
 
game.Players.PlayerAdded:Connect(function(plr)
    
    
    local result = nil
    local success, err = pcall(function()
        result = banDS:GetAsync(plr.UserId .. "-BanData")
    end)
    
    if result then
        
        local thenTime = result[1]
        local nowTime = os.time()
        local banTime = result[2]
        local reason = result[3]
        local timeDiff = nowTime - thenTime
        
        if timeDiff < banTime then
            
            local newTime = banTime - timeDiff
            
            plr:Kick(reason .. "\nBanned for " .. newTime .. "s")
            
            
        else
            
            pcall(function()
                banDS:SetAsync(plr.UserId .. "-BanData", nil)
            end)
        end
    end
    
    
    
    if table.find(admins, plr.UserId) then
        
        
        plr.Chatted:Connect(function(message)
            
            local splitMsg = string.split(message, " ")
            
            local banCmd = splitMsg[1]
            local plrName = splitMsg[2]
            local banTime = splitMsg[3]
            local reason = splitMsg[4] or "Reason unavailable."
            
            
            if banCmd == "!ban" and plrName and banTime then
                
                local timeUnit = string.sub(banTime, -1, -1)
                local timeAmount = string.sub(banTime, 1, #banTime-1)
                local seconds = timeUnits[timeUnit]
                
                
                if seconds then
                    
                    local plrId = game.Players:GetUserIdFromNameAsync(plrName)
                    
                    if plrId then
                        
                        local banTimeSeconds = seconds * timeAmount
                        
                        pcall(function()
                            banDS:SetAsync(plrId .. "-BanData", {os.time(), banTimeSeconds, reason})
                        end)
                        
                        if game.Players:FindFirstChild(plrName) then
                            
                            game.Players[plrName]:Kick(reason .. "\nBanned for " .. banTime)
                        end
                    end
                end
            end
        end)
    end
end)
