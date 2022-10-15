--Holy Island by Adne

n = tt_none 
tijdelijk = tt_flatland
heuvel = tt_hills
grond = tt_plains
vis = tt_lake_shallow_hill_fish
hogebomen = tt_impasse_trees_hills
bomen = tt_impasse_trees_plains_forest
kleinebomen = tt_impasse_trees_small_plains
relic = tt_relic_spawner
wolf = tt_wolf_spawner
vis = tt_ocean_deepwater_fish
nieuwvis = tt_ocean_deepwater_fish_single
waterdiep = tt_ocean_deep
waterkust = tt_ocean_shore
eilandheuvel = tt_hills_lowlands
eiland = tt_hills
bergen = tt_plains_cliff
bergen2= tt_mountains_small
bergramp = tt_hills


function transpose(m)
   local rotated = {}
   for c, m_1_c in ipairs(m[1]) do
      local col = {m_1_c}
      for r = 2, #m do
         col[r] = m[r][c]
      end
      table.insert(rotated, col)
   end
   return rotated
end

function rotate_CCW_90(m)
   local rotated = {}
   for c, m_1_c in ipairs(m[1]) do
      local col = {m_1_c}
      for r = 2, #m do
         col[r] = m[r][c]
      end
      table.insert(rotated, 1, col)
   end
   return rotated
end

function rotate_180(m)
   return rotate_CCW_90(rotate_CCW_90(m))
end

function rotate_CW_90(m)
   return rotate_CCW_90(rotate_CCW_90(rotate_CCW_90(m)))
end


gridHeight, gridWidth, gridSize = SetCustomCoarseGrid(20)
--[[gridSize = gridWidth
playerStarts = worldPlayerCount]]--

terrainLayoutResult = SetUpGrid(gridSize, n, terrainLayoutResult)
--[[startLocationPositions = {}]]--
rotatie = math.ceil(worldGetRandom() * 4)	
middenPunt =  math.ceil(gridSize/2)	

terrainLayoutResult[5][14].terrainType = tt_player_start_classic_plains_no_trees
terrainLayoutResult[5][14].playerIndex = 0  
terrainLayoutResult[gridSize-4][14].terrainType = tt_player_start_classic_plains_no_trees
terrainLayoutResult[gridSize-4][14].playerIndex = 1


function MirrorPlaatsing(xPos, yPos, ttType)
	if xPos <= gridSize and yPos <= gridSize and xPos >= 1 and yPos >= 1 then
		terrainLayoutResult[xPos][yPos].terrainType = ttType
	end
	if gridSize+1-xPos <= gridSize and gridSize+1-yPos <= gridSize and gridSize+1-xPos >= 1 and gridSize+1-yPos >= 1 then
		terrainLayoutResult[gridSize+1-xPos][yPos].terrainType = ttType
	end
end

function MirrorKansPlaatsing(xPos, yPos, ttType, kans)
	if xPos <= gridSize and yPos <= gridSize and xPos >= 1 and yPos >= 1 then
		if worldGetRandom() < kans then
			terrainLayoutResult[xPos][yPos].terrainType = ttType
		end
	end
	if gridSize+1-xPos <= gridSize and gridSize+1-yPos <= gridSize and gridSize+1-xPos >= 1 and gridSize+1-yPos >= 1 then
		if worldGetRandom() < kans then
			terrainLayoutResult[gridSize+1-xPos][yPos].terrainType = ttType
		end
	end
end


visspawns = 0
function visplaatsing()
	
	waterxStart1 = 2
	wateryStart1 = 2
	waterxStart2 = gridSize-1
	wateryStart2 = 2
	visrij = 0
	xPos1 = wateryStart1
	yPos1 = wateryStart1
	xPos2 = waterxStart2
	yPos2 = wateryStart2
	waterEinde = middenPunt - 4
	while yPos1 <= 5 do
		if xPos1 == 2 
			and (terrainLayoutResult[xPos1][yPos1-1].terrainType ~= vis) 
			and  (terrainLayoutResult[xPos2][yPos2-1].terrainType ~= vis)
			or
			xPos1 > 2 
			and (terrainLayoutResult[xPos1-1][yPos1].terrainType ~= vis) 
			and  (terrainLayoutResult[xPos2+1][yPos2].terrainType ~= vis)
			and (terrainLayoutResult[xPos1][yPos1-1].terrainType ~= vis)
			and  (terrainLayoutResult[xPos2][yPos2-1].terrainType ~= vis)			
			then
			if yPos1 <= gridSize-1 and (worldGetRandom() < 0.18) and visspawns <= 4 and visrij <= 2 
				and terrainLayoutResult[xPos1][yPos1].terrainType ~= vis 
				and terrainLayoutResult[xPos2][yPos2].terrainType ~= vis
				then
				terrainLayoutResult[xPos1][yPos1].terrainType = vis		
				terrainLayoutResult[xPos2][yPos2].terrainType = vis	
				visspawns = visspawns + 1
				visrij = visrij + 1
			end
		end
		if xPos1 < waterEinde then
			xPos1 = xPos1 + 1
			xPos2 = xPos2 - 1
		else 
			waterEinde = middenPunt - 3 - math.ceil(worldGetRandom() * 2)	
			visrij = 0
			xPos1 = waterxStart1 
			yPos1 = yPos1 + 1
			xPos2 = waterxStart2
			yPos2 = yPos2 + 1
		end
	end
end





--Waterstart
for xPos = 1, gridSize do
	for yPos = 1, 10 do
		terrainLayoutResult[xPos][yPos].terrainType = waterdiep
	end
end

--Kust
heuvelkans = 0
vlakkans = 1.6
for xPos = 1, middenPunt-3 do
	yPos = 6 + (math.ceil(worldGetRandom() * 2))
	if xPos ~= middenPunt-3 then
		if (worldGetRandom() < vlakkans) then 
			terrainLayoutResult[xPos][yPos].terrainType = grond
			terrainLayoutResult[gridSize-xPos+1][yPos].terrainType = grond
			vlakkans = vlakkans - 0.15
			heuvelkans = heuvelkans + 0.28 
		elseif (worldGetRandom() < heuvelkans) then
			vlakkans = vlakkans + 0.3
			heuvelkans = heuvelkans - 0.2
			terrainLayoutResult[xPos][yPos].terrainType = grond
			terrainLayoutResult[gridSize-xPos+1][yPos].terrainType = grond
			if yPos + 2 < gridSize then
				terrainLayoutResult[xPos][yPos+1].terrainType = heuvel
				terrainLayoutResult[gridSize-xPos+1][yPos+1].terrainType = heuvel
			end
		else
			terrainLayoutResult[xPos][yPos].terrainType = grond
			terrainLayoutResult[gridSize-xPos+1][yPos].terrainType = grond
			heuvelkans = heuvelkans + 0.3
		end
	
	elseif xPos == middenPunt-3 then
		terrainLayoutResult[xPos][yPos].terrainType = grond
		terrainLayoutResult[gridSize-xPos+1][yPos].terrainType = grond
	end
		
end

--Middenkust
heuvelkans = 0.5
vlakkans = 0.5
for xPos = middenPunt-3, middenPunt+3 do
	yPos = 7 + (math.ceil(worldGetRandom() * 2))
	if (worldGetRandom() < vlakkans) then 
		terrainLayoutResult[xPos][yPos].terrainType = grond
		vlakkans = vlakkans - 0.15
		heuvelkans = heuvelkans + 0.23 
	elseif (worldGetRandom() < heuvelkans) then
		vlakkans = vlakkans + 0.15
		heuvelkans = heuvelkans - 0.23
		terrainLayoutResult[xPos][yPos].terrainType = grond
		if yPos + 2 < gridSize then
			terrainLayoutResult[xPos][yPos+2].terrainType = heuvel
		end
	else
		terrainLayoutResult[xPos][yPos].terrainType = grond
		heuvelkans = heuvelkans + 0.3
	end
		
end


for xPos = 1, gridSize do
	for yPos = 1, 9 do 
		if terrainLayoutResult[xPos][yPos+1].terrainType ~= waterdiep and terrainLayoutResult[xPos][yPos].terrainType == waterdiep then
			terrainLayoutResult[xPos][yPos].terrainType = waterkust
		end
	end
end

for xPos = 1, gridSize do
	for yPos = 4, gridSize do 
		if terrainLayoutResult[xPos][yPos-1].terrainType ~= waterdiep 
			and terrainLayoutResult[xPos][yPos].terrainType == waterdiep then
			terrainLayoutResult[xPos][yPos].terrainType = grond
		end
	end
end


--Eiland
eilandX = middenPunt
eilandY = 1
terrainLayoutResult[eilandX][eilandY].terrainType = grond
terrainLayoutResult[eilandX][eilandY].terrainType = tt_relic_spawner
terrainLayoutResult[eilandX][eilandY+1].terrainType = eiland
terrainLayoutResult[eilandX][eilandY+2].terrainType = tt_holy_site
if worldGetRandom() < 0.5 then
	terrainLayoutResult[eilandX-1][eilandY].terrainType = eilandheuvel
	terrainLayoutResult[eilandX+1][eilandY].terrainType = tt_tactical_region_gold_plains_d
else
	terrainLayoutResult[eilandX-1][eilandY].terrainType = tt_tactical_region_gold_plains_d
	terrainLayoutResult[eilandX+1][eilandY].terrainType = eilandheuvel
end
terrainLayoutResult[eilandX-1][eilandY+1].terrainType = eilandheuvel
terrainLayoutResult[eilandX+1][eilandY+1].terrainType = eilandheuvel

eilandkans = 0.9
grondbonuskans = 1
eilandloop = (math.ceil(worldGetRandom() * 3))
for i = 1, eilandloop do
	eilandbonuskeuze = (math.ceil(worldGetRandom() * 4))
	if eilandbonuskeuze == 1 then
		eilandbonusposX = eilandX-2
		eilandbonusposY = eilandY+1
	elseif eilandbonuskeuze == 2 then
		eilandbonusposX = eilandX-2 
		eilandbonusposY = eilandY+2
	elseif eilandbonuskeuze == 3 then
		eilandbonusposX = eilandX+2 
		eilandbonusposY = eilandY+1
	else
		eilandbonusposX = eilandX+2 
		eilandbonusposY = eilandY+2
	end	

	if (worldGetRandom() < eilandkans) then 
		eilandkansT = (3 + (math.ceil(worldGetRandom() * 1.5))/10)
		eilandkans = eilandkans - eilandkansT
		terrainLayoutResult[eilandbonusposX][eilandbonusposY].terrainType = eiland
		terrainLayoutResult[eilandbonusposX][eilandbonusposY+2].terrainType = waterdiep
		if (worldGetRandom() < grondbonuskans) and
			terrainLayoutResult[eilandbonusposX][eilandbonusposY-1].terrainType ~= eiland 			
			then 			
			terrainLayoutResult[eilandbonusposX][eilandbonusposY-1].terrainType = grond
			grondbonuskansT = (2 + (math.ceil(worldGetRandom() * 3.1))/10)
			grondbonuskans = grondbonuskans - grondbonuskansT
		end
		if (worldGetRandom() < grondbonuskans) and
			terrainLayoutResult[eilandbonusposX][eilandbonusposY+1].terrainType ~= eiland
			then 
			terrainLayoutResult[eilandbonusposX][eilandbonusposY+1].terrainType = grond
			grondbonuskansT = (2 + (math.ceil(worldGetRandom() * 3.1))/10)
			grondbonuskans = grondbonuskans - grondbonuskansT
		end
		if (worldGetRandom() < grondbonuskans-0.15) and
			terrainLayoutResult[eilandbonusposX][eilandbonusposY-1].terrainType ~= eiland
			then 
			terrainLayoutResult[eilandbonusposX][eilandbonusposY-1].terrainType = eilandheuvel
			grondbonuskansT = (2 + (math.ceil(worldGetRandom() * 2.1))/10)
			grondbonuskans = grondbonuskans - grondbonuskansT
		end
	end
	
end

for xPos = eilandX-4, eilandX+4 do
	for yPos = 1, 6 do 
		if terrainLayoutResult[xPos][yPos].terrainType ~= waterdiep 
			and terrainLayoutResult[xPos-1][yPos].terrainType == waterdiep then
			terrainLayoutResult[xPos-1][yPos].terrainType = waterkust
		end
		if terrainLayoutResult[xPos][yPos].terrainType ~= waterdiep 
			and terrainLayoutResult[xPos+1][yPos].terrainType == waterdiep then
			terrainLayoutResult[xPos+1][yPos].terrainType = waterkust
		end
		if terrainLayoutResult[xPos][yPos].terrainType ~= waterdiep 
			and terrainLayoutResult[xPos][yPos+1].terrainType == waterdiep then
			terrainLayoutResult[xPos][yPos+1].terrainType = waterkust
		end
	end
end

--[[
visplaatsing()
if visspawns <= 4 then
	visplaatsing()
end
if visspawns <= 4 then
	visplaatsing()
end]]--


function mirrorDetectie(xPos, yPos, ttType)
	if terrainLayoutResult[xPos][yPos].terrainType == ttType and terrainLayoutResult[gridSize+1-xPos][yPos].terrainType == ttType then
		return 1
	else
		return 0
	end
end

visTabel = {}
for xPos = 1, 5 do
	for yPos = 5, 7 do
		if mirrorDetectie(xPos, yPos, waterkust) == 1 and mirrorDetectie(xPos, yPos-1, waterdiep) == 1 then
			table.insert(visTabel, #visTabel+1, {xPos, yPos-1})
			print ("Visvoer")
			print (xPos, yPos-1)
		end
	end
end

for i = 1, 3 do
	local viskeuze = math.ceil(worldGetRandom() * #visTabel)
	MirrorPlaatsing(visTabel[viskeuze][1], visTabel[viskeuze][2], nieuwvis)	
	table.remove(visTabel, viskeuze)
end
	

for yPos = gridSize, 5, -1 do
	for xPos =  middenPunt-4, middenPunt do
		if terrainLayoutResult[xPos][yPos].terrainType == waterkust and terrainLayoutResult[xPos][yPos-1].terrainType == waterdiep then
			yStrandEinde = yPos
		end
	end
end	

for yPos = 1, 5, 1 do
	for xPos = 1, gridSize do
		if terrainLayoutResult[xPos][yPos].terrainType == waterkust and terrainLayoutResult[xPos][yPos+1].terrainType == waterdiep then
			yEilandEinde = yPos
		end
	end
end	

if yStrandEinde == nil then
	yStrandEinde = 7
end
if yEilandEinde == nil then
	yEilandEinde = 5
end
--[[
--Middenvis
for yPos = yEilandEinde, yStrandEinde do
	for xPos = middenPunt-3, middenPunt do
		if terrainLayoutResult[xPos][yPos].terrainType == waterdiep or
			terrainLayoutResult[xPos][yPos].terrainType == waterkust and
			(worldGetRandom() < 0.32) and
			terrainLayoutResult[xPos-1][yPos].terrainType ~= vis and
			terrainLayoutResult[xPos][yPos+1].terrainType ~= vis and
			terrainLayoutResult[xPos][yPos-1].terrainType ~= vis then
			terrainLayoutResult[xPos][yPos].terrainType = vis
			terrainLayoutResult[gridSize+1-xPos][yPos].terrainType = vis
		end
	end
end]]--
	
boomsoort = math.ceil(worldGetRandom() * 3)	

--Bomen
for xPos = 1, gridSize do
	for yPos = 10, gridSize do 
		if xPos == 1 or xPos == gridSize then
			if yPos >= 10 and yPos <= 12  then
				terrainLayoutResult[xPos][yPos].terrainType = hogebomen
			else
				terrainLayoutResult[xPos][yPos].terrainType = bomen
			end
		elseif xPos == 2 or xPos == gridSize-1 then
			if boomsoort <= 2 then
				if yPos >= 14 and  yPos <= gridSize-6 then
					terrainLayoutResult[xPos][yPos].terrainType = bomen
				end
			end
		end
	end
end



if boomsoort == 3 then
	if worldGetRandom() < 0.333 then
		MirrorPlaatsing(8, 13, bomen)
	elseif worldGetRandom() < 0.5 then
		MirrorPlaatsing(8, 15, bomen)
	else	
		MirrorPlaatsing(8, 14, bomen)
	end
	MirrorPlaatsing(6, 21, bomen)
end
	

--Bergen
berglijnL = middenPunt-4
berglijnR = middenPunt+4
for xPos = berglijnL, berglijnR do
	for yPos = gridSize-4, gridSize do 
		terrainLayoutResult[xPos][yPos].terrainType = bergen
	end
end

for yPos = gridSize-3, gridSize do 
	terrainLayoutResult[berglijnL][yPos].terrainType = bergramp
	terrainLayoutResult[berglijnR][yPos].terrainType = bergramp
end

rampkans = 0.23
for xPos = berglijnL+1, berglijnR-1 do
	if worldGetRandom() < rampkans and 
		terrainLayoutResult[xPos][gridSize-4].terrainType ~= hogebomen and
		terrainLayoutResult[gridSize+1-xPos][gridSize-4].terrainType ~= hogebomen and
		boomsoort ~= 3 then
		terrainLayoutResult[xPos][gridSize-4].terrainType = kleinebomen
		terrainLayoutResult[gridSize+1-xPos][gridSize-4].terrainType = kleinebomen		
		terrainLayoutResult[xPos][gridSize-3].terrainType = kleinebomen
		terrainLayoutResult[gridSize+1-xPos][gridSize-3].terrainType = kleinebomen		
		rampkans = rampkans - 0.21
	else 
		rampkans = rampkans + 0.179 
	end
	if xPos >= middenPunt-1 or xPos <= middenPunt+1 then
		terrainLayoutResult[xPos][gridSize-4].terrainType = bergramp
	end
end

for xPos = berglijnL+1, berglijnR-1 do
	for yPos = gridSize-3, gridSize do 
		if terrainLayoutResult[xPos][yPos].terrainType == bergen and worldGetRandom() < 0.37 then
			terrainLayoutResult[xPos][yPos].terrainType = bergramp
		end
	end
end




--Relic
for yPos = 1, gridSize do
	xPos = middenPunt
	if terrainLayoutResult[xPos][yPos].terrainType == waterkust and terrainLayoutResult[xPos][yPos-1].terrainType == waterdiep then
		yRelicMid1 = yPos+3
		break
	end
	if terrainLayoutResult[xPos][yPos].terrainType == waterkust and terrainLayoutResult[xPos][yPos-1].terrainType == waterkust then
		yRelicMid1 = yPos+3
		break
	end
end
if yRelicMid1 == nil then
	yRelicMid1 = middenPunt - 2
end
if yRelicMid1 + 7 < gridSize then
	yRelicMid2 = yRelicMid1 + 7
elseif middenPunt + 3 ~= yRelicMid1 then
	yRelicMid2 = middenPunt + 3
else
	yRelicMid2 = middenPunt - 2
end

holyY = yRelicMid1 + math.ceil((yRelicMid2-yRelicMid1)/2)
terrainLayoutResult[middenPunt][yRelicMid1].terrainType = tt_relic_spawner
terrainLayoutResult[middenPunt][yRelicMid2].terrainType = tt_relic_spawner
terrainLayoutResult[4][gridSize-2].terrainType = tt_relic_spawner
terrainLayoutResult[gridSize-3][gridSize-2].terrainType = tt_relic_spawner
terrainLayoutResult[middenPunt][gridSize-2].terrainType = tt_relic_spawner
terrainLayoutResult[middenPunt][holyY].terrainType = tt_holy_site


terrainLayoutResult[middenPunt][gridSize].terrainType = tt_settlement_plains


for xPos = 1, 3 do
	for yPos = 1, 3 do 
		if yPos >= 2 then
			terrainLayoutResult[xPos][yPos].terrainType = grond
		else
			terrainLayoutResult[xPos][yPos].terrainType = heuvel
		end
	end
end

for xPos = gridSize-2, gridSize do
	for yPos = 1, 3 do 
		if yPos >= 2 then
			terrainLayoutResult[xPos][yPos].terrainType = grond
		else
			terrainLayoutResult[xPos][yPos].terrainType = heuvel
		end
			
	end
end


terrainLayoutResult[2][2].terrainType = tt_settlement_naval
terrainLayoutResult[gridSize-1][2].terrainType = tt_settlement_naval

--Bonusvis
for xPos = 15, 16 do
	for yPos = 1, 5 do 
		if terrainLayoutResult[xPos][yPos].terrainType == waterkust then
			terrainLayoutResult[xPos][yPos].terrainType = waterdiep
		end
	end
end
--[[
if worldGetRandom() < 0.5 then
	visSpawn = 4
else
	visSpawn = 5
end

for xPos = 8, 14 do 
	if visSpawn == 5 then
		if xPos%2 == 0 then
			terrainLayoutResult[xPos][5].terrainType = nieuwvis
		end
	elseif visSpawn == 4 then
		if xPos%2 ~= 0 then
			terrainLayoutResult[xPos][5].terrainType = nieuwvis
		end
	end
end]]--

MirrorPlaatsing(1, 2, heuvel)
MirrorPlaatsing(4, 1, grond)
MirrorPlaatsing(4, 2, grond)
MirrorPlaatsing(3, 1, grond)
MirrorPlaatsing(5, 1, waterkust)
MirrorPlaatsing(5, 1, waterkust)
MirrorPlaatsing(1, 4, waterkust)

visTabel = {}
for xPos = 4, 7 do 
	for yPos = 1, 5 do
		if mirrorDetectie(xPos, yPos, waterdiep) == 1 then
			table.insert(visTabel, #visTabel+1, {xPos, yPos})
			print ("Visvoer2")
			print (xPos, yPos)
		end
	end
end

for i = 1, 4 do
	if #visTabel >= 1 then
		local viskeuze = math.ceil(worldGetRandom() * #visTabel)
		MirrorPlaatsing(visTabel[viskeuze][1], visTabel[viskeuze][2], nieuwvis)	
		table.remove(visTabel, viskeuze)
	end
end
	
			
			
	


if rotatie == 1 then
	terrainLayoutResult = rotate_CCW_90(terrainLayoutResult)
elseif rotatie == 2 then
	terrainLayoutResult = rotate_CW_90(terrainLayoutResult)
elseif rotatie == 3 then
	terrainLayoutResult = rotate_180(terrainLayoutResult)
end

