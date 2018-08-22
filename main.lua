local NazunaCoords = {}

local hbd = LibStub("HereBeDragons-2.0")

function NazunaCoords_OnLoad(frame)	
	frame:SetMovable(true)
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:SetScript("OnUpdate", NazunaCoords_OnUpdate)
end

function NazunaCoords_OnEvent(self, event, ...)
	if(event == "PLAYER_ENTERING_WORLD") then
		-- Initialization code here; but nothing to initialize right now
	end
end

local updateThrottle = 0.25
local updateCounter = 0
function NazunaCoords_OnUpdate(self, elapsed)
	updateCounter = updateCounter + elapsed
	if( updateCounter >= updateThrottle ) then
		local x,y = hbd:GetPlayerZonePosition(true)
		
		if(x==nil or y==nil) then
			local zoneId = hbd:GetPlayerZone()
			local map = hbd:GetLocalizedMap(zoneId)
			updateUIText(map)
		else
			updateCoords(x,y)
		end
		updateCounter = 0
	end
end

function updateCoords(x, y)
	updateUIText(formatCoords(x, y, 2))
end

function updateUIText(msg)
	NazunaCoordsFrameText:SetText(msg)
end

local coord_fmt = "%%.%df, %%.%df"
function formatCoords(x,y,prec)
	local fmt = coord_fmt:format(prec, prec)
	return fmt:format(x*100, y*100)
end