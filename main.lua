local Spaggiarite = RegisterMod("Spaggiarite", 1)
local technology = Isaac.GetItemIdByName("Technology")
local technologytwo = Isaac.GetItemIdByName("Technology 2")
local technologyzero = Isaac.GetItemIdByName("Technology Zero")
local spaggiarite = Isaac.GetItemIdByName("Spaggiarite")
local rng = RNG()

local senza_neo = true

function Spaggiarite:Update()
    player = Game():GetPlayer(0)
    hasSpaggiarite = player:HasCollectible(spaggiarite)
    if hasSpaggiarite then
        if senza_neo then
            player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/costume_spaggia.anm2"))
            senza_neo = false
        end
        hasTechnology = player:HasCollectible(technology)
        hasTechnologyTwo = player:HasCollectible(technologytwo)
        hasTechnologyZero = player:HasCollectible(technologyzero)
        if (hasTechnology or hasTechnologyTwo or hasTechnologyZero) and (rng:RandomInt(3600) - player.Luck * 60) < 10 then
            local bomb = Isaac.Spawn(EntityType.ENTITY_BOMBDROP, 0, 0, player.Position, player.Velocity, player)
            bomb.Visible = false
            bomb:ToBomb():SetExplosionCountdown(1)
            bomb:ToBomb().Flags = player:GetBombFlags()
        end
    end
end

function Spaggiarite:Render()
    if hasSpaggiarite and (hasTechnology or hasTechnologyTwo or hasTechnologyZero) then
        Isaac.RenderText("CoD", 60 + rng:RandomInt(3), 15 + rng:RandomInt(3), 255, 255, 255, 255)
    end
end

Spaggiarite:AddCallback(ModCallbacks.MC_POST_UPDATE, Spaggiarite.Update)
Spaggiarite:AddCallback(ModCallbacks.MC_POST_RENDER, Spaggiarite.Render)