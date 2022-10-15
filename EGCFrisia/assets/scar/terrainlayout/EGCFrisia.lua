--Frisia created by Adne of the DR.

n = tt_none 
tijdelijk = tt_flatland
heuvel = tt_hills
grond = tt_plains
vis = tt_lake_shallow_hill_fish
--bomen = tt_impasse_trees_hills
bomen = tt_impasse_trees_plains_forest
relic = tt_relic_spawner
wolf = tt_wolf_spawner

h1 = tt_plateau_low
h2 = tt_plateau_med
h1ramp = tt_hills



gridHeight, gridWidth, gridSize = SetCustomCoarseGrid(20)

terrainLayoutResult = SetUpGrid(gridSize, n, terrainLayoutResult)


--tt_player_start_nomad_plains



waterxStart1 = 3
wateryStart1 = 8
waterxStart2 = gridSize-2
wateryStart2 = 8
xPos1 = waterxStart1
yPos1 = wateryStart1
xPos2 = waterxStart2
yPos2 = wateryStart2
waterEinde = 8
middenPunt =  math.ceil(gridSize/2)	
rotatie = math.ceil(worldGetRandom() * 4)	
heuvelyStart = math.ceil(worldGetRandom() * 3)	
yHoly1 = 5 + math.ceil(worldGetRandom() * 5)
yHoly2 = yHoly1 + 5 + math.ceil(worldGetRandom() * 2)
yRelicMid = 6 + math.ceil(worldGetRandom() * 7)
xRelic1 = 2 + math.ceil(worldGetRandom() * 2)
yRelic1 = 7 + math.ceil(worldGetRandom() * 4)
xRelic2 = 4 + math.ceil(worldGetRandom() * 3)
yRelic2 = middenPunt + 2 + math.ceil(worldGetRandom() * 6)


function MirrorPlaatsing(xPos, yPos, ttType)
	if xPos <= gridSize and yPos <= gridSize and xPos >= 1 and yPos >= 1 then
		terrainLayoutResult[xPos][yPos].terrainType = ttType
	end
	if gridSize+1-xPos <= gridSize and yPos <= gridSize and gridSize+1-xPos >= 1 and gridSize+1-yPos >= 1 then
		terrainLayoutResult[gridSize+1-xPos][yPos].terrainType = ttType
	end
end


if yHoly2 > gridSize then
	yHoly2 = gridSize
end
if yRelicMid == yHoly1 or yRelicMid == yHoly2 or yRelicMid == yHoly2+3 then
	yRelicMid = yRelicMid + 1
end
if yRelicMid >= gridSize-2 then
	yRelicMid = yHoly1 + 1
end
if yRelic2-yRelic1 <= 3 then
	RelicVerschil = yRelic2 - yRelic1
	yRelic2 = yRelic2 + 3 - RelicVerschil
end
if yRelic2 >= gridSize-2 then
	yRelic2 = gridSize-3
end


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


visspawns = 0
function visplaatsing()
	visrij = 0
	xPos1 = waterxStart1
	yPos1 = wateryStart1
	xPos2 = waterxStart2
	yPos2 = wateryStart2
	while yPos1 <= gridSize-1 do
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
			if yPos1 <= gridSize-1 and (worldGetRandom() < 0.17) and visspawns <= 7 and visrij <= 1 
				and terrainLayoutResult[xPos1][yPos1].terrainType ~= vis 
				and terrainLayoutResult[xPos2][yPos2].terrainType ~= vis
				then
				terrainLayoutResult[xPos1][yPos1].terrainType = tt_lake_shallow_hill_fish
				if terrainLayoutResult[xPos1+1][yPos1].terrainType ~= vis then
					terrainLayoutResult[xPos1+1][yPos1].terrainType = grond
				end
				if terrainLayoutResult[xPos1-1][yPos1].terrainType ~= vis then
					terrainLayoutResult[xPos1-1][yPos1].terrainType = grond
				end
				if terrainLayoutResult[xPos1][yPos1+1].terrainType ~= vis then
					terrainLayoutResult[xPos1][yPos1+1].terrainType = grond
				end
				if terrainLayoutResult[xPos1][yPos1-1].terrainType ~= vis then
					terrainLayoutResult[xPos1][yPos1-1].terrainType = grond
				end					
				
				if terrainLayoutResult[xPos1-1][yPos1-1].terrainType ~= vis then
					terrainLayoutResult[xPos1-1][yPos1-1].terrainType = grond
				end		
				if terrainLayoutResult[xPos1+1][yPos1-1].terrainType ~= vis then
					terrainLayoutResult[xPos1+1][yPos1-1].terrainType = grond
				end		
				if terrainLayoutResult[xPos1+1][yPos1+1].terrainType ~= vis then
					terrainLayoutResult[xPos1+1][yPos1+1].terrainType = grond
				end		
				if terrainLayoutResult[xPos1-1][yPos1+1].terrainType ~= vis then
					terrainLayoutResult[xPos1-1][yPos1+1].terrainType = grond
				end
				
				
				
				
				
				terrainLayoutResult[xPos2][yPos2].terrainType = vis
				if terrainLayoutResult[xPos2+1][yPos2].terrainType ~= vis then
					terrainLayoutResult[xPos2+1][yPos2].terrainType = grond
				end
				if terrainLayoutResult[xPos2-1][yPos2].terrainType ~= vis then
					terrainLayoutResult[xPos2-1][yPos2].terrainType = grond
				end
				if terrainLayoutResult[xPos2][yPos2+1].terrainType ~= vis then
					terrainLayoutResult[xPos2][yPos2+1].terrainType = grond
				end
				if terrainLayoutResult[xPos2][yPos2-1].terrainType ~= vis then
					terrainLayoutResult[xPos2][yPos2-1].terrainType = grond
				end	
				
								
				if terrainLayoutResult[xPos2-1][yPos2-1].terrainType ~= vis then
					terrainLayoutResult[xPos2-1][yPos2-1].terrainType = grond
				end		
				if terrainLayoutResult[xPos2+1][yPos2-1].terrainType ~= vis then
					terrainLayoutResult[xPos2+1][yPos2-1].terrainType = grond
				end		
				if terrainLayoutResult[xPos2+1][yPos2+1].terrainType ~= vis then
					terrainLayoutResult[xPos2+1][yPos2+1].terrainType = grond
				end		
				if terrainLayoutResult[xPos2-1][yPos2+1].terrainType ~= vis then
					terrainLayoutResult[xPos2-1][yPos2+1].terrainType = grond
				end	
				
				
				visspawns = visspawns + 1
				visrij = visrij + 1
			elseif (worldGetRandom() < 0.3) and terrainLayoutResult[xPos1][yPos1].terrainType ~= vis then
				terrainLayoutResult[xPos1][yPos1].terrainType = tt_hills_lowlands
				terrainLayoutResult[xPos2][yPos2].terrainType = tt_hills_lowlands
			end
		end
		if xPos1 < waterEinde then
			xPos1 = xPos1 + 1
			xPos2 = xPos2 - 1
		else 
			waterEinde = 4 + math.ceil(worldGetRandom() * 5)	
			visrij = 0
			xPos1 = waterxStart1 - 1 + math.ceil(worldGetRandom() * 2)	 
			yPos1 = yPos1 + 1
			xPos2 = waterxStart2 + 1 - math.ceil(worldGetRandom() * 2)
			yPos2 = yPos2 + 1
		end
	end
end

xPos = 1
yPos = heuvelyStart

while yPos <= gridSize do
	if terrainLayoutResult[xPos][yPos].terrainType ~= vis then
		terrainLayoutResult[xPos][yPos].terrainType = tt_hills
	end
	xPos = xPos +1
	yPos = yPos +1
end

xPos = gridSize
yPos = heuvelyStart

while yPos <= gridSize do
	if terrainLayoutResult[xPos][yPos].terrainType ~= vis then
		terrainLayoutResult[xPos][yPos].terrainType = tt_hills
	end
	xPos = xPos - 1
	yPos = yPos + 1
end

xPos = middenPunt
yPos = 1

while yPos <= 6 do
	terrainLayoutResult[xPos][yPos].terrainType = tt_hills	
	if (worldGetRandom() < 0.4) then
		terrainLayoutResult[xPos-1][yPos].terrainType = tt_hills_low_rolling	
	end
	if (worldGetRandom() < 0.4) then
		terrainLayoutResult[xPos+1][yPos].terrainType = tt_hills_low_rolling
	end	
	yPos = yPos + 1
end

for xPos = 6, gridSize-5 do
	for yPos = 5, 11 do
		if (terrainLayoutResult[xPos][yPos].terrainType == tt_hills) 
			and (terrainLayoutResult[xPos-1][yPos].terrainType ~= tt_hills_low_rolling) and (terrainLayoutResult[xPos+1][yPos].terrainType ~= tt_hills_low_rolling) then
				if (worldGetRandom() < 0.5) then
					terrainLayoutResult[xPos-1][yPos].terrainType = tt_hills_low_rolling	
				else
					terrainLayoutResult[xPos+1][yPos].terrainType = tt_hills_low_rolling
				end
			end
	end
end	

for xPos = 6, gridSize-5 do
	for yPos = 5, 11 do
		if (terrainLayoutResult[xPos][yPos].terrainType == tt_hills_low_rolling) 
			and (terrainLayoutResult[xPos-1][yPos].terrainType == tt_none) then
			terrainLayoutResult[xPos-1][yPos].terrainType = tt_valley
		end
		if (terrainLayoutResult[xPos][yPos].terrainType == tt_hills_low_rolling) 
			and (terrainLayoutResult[xPos+1][yPos].terrainType == tt_none) then
			terrainLayoutResult[xPos+1][yPos].terrainType = tt_valley
		end
		if (terrainLayoutResult[xPos][yPos].terrainType == tt_hills_low_rolling) 
			and (terrainLayoutResult[xPos][yPos+1].terrainType == tt_none) then
			terrainLayoutResult[xPos][yPos+1].terrainType = tt_valley
		end
	end
end

for xPos = 1, gridSize do
	for yPos = 1, gridSize do
		if xPos <= 2 or
			xPos >= gridSize-1 or
			yPos <= 2 or
			yPos >= gridSize-1 then
			terrainLayoutResult[xPos][yPos].terrainType = tt_plains
		end
	end
end

terrainLayoutResult[middenPunt][9].terrainType = tt_hills_lowlands
terrainLayoutResult[middenPunt][3].terrainType = tt_hills_lowlands
terrainLayoutResult[middenPunt][gridSize-3].terrainType = tt_hills_lowlands
graafwerk = 0
while graafwerk <= 5 do
	for xPos = 2, gridSize-1 do
		for yPos = 2, gridSize-1 do
			if (terrainLayoutResult[xPos][yPos].terrainType == tt_hills_lowlands) then
				if (worldGetRandom() <= 0.66) and terrainLayoutResult[xPos+1][yPos].terrainType ~= vis then
					terrainLayoutResult[xPos+1][yPos].terrainType = tijdelijk
				end
				if (worldGetRandom() <= 0.32) and terrainLayoutResult[xPos][yPos-1].terrainType ~= vis then
					terrainLayoutResult[xPos][yPos-1].terrainType = tijdelijk
				end
				if (worldGetRandom() <= 0.66) and terrainLayoutResult[xPos-1][yPos].terrainType ~= vis then
					terrainLayoutResult[xPos-1][yPos].terrainType = tijdelijk
				end
				if (worldGetRandom() <= 0.32) and terrainLayoutResult[xPos][yPos+1].terrainType ~= vis then
					terrainLayoutResult[xPos][yPos+1].terrainType = tijdelijk
				end
			end
		end
	end
	for xPos = 2, gridSize-1 do
		for yPos = 2, gridSize-1 do
			if (terrainLayoutResult[xPos][yPos].terrainType == tijdelijk) then
					terrainLayoutResult[xPos][yPos].terrainType = tt_hills_lowlands 			
			end
		end
	end
	graafwerk = graafwerk + 1
end
visplaatsing()
if visspawns <= 7 then
	visplaatsing()
end
if visspawns <= 7 then
	visplaatsing()
end
	

for yBoom = 1, 6 do
	terrainLayoutResult[middenPunt][yBoom].terrainType = tt_trees_plains_stealth
	terrainLayoutResult[middenPunt+1][yBoom].terrainType = tt_trees_plains_stealth
	terrainLayoutResult[middenPunt-1][yBoom].terrainType = tt_trees_plains_stealth
end

terrainLayoutResult[middenPunt][yHoly1].terrainType = tt_holy_site_hill_danger
terrainLayoutResult[middenPunt][yHoly2].terrainType = tt_holy_site_hill_danger

terrainLayoutResult[middenPunt][1].terrainType = bomen
terrainLayoutResult[middenPunt][2].terrainType = bomen

terrainLayoutResult[1][1].terrainType = bomen
terrainLayoutResult[gridSize][1].terrainType = bomen

terrainLayoutResult[2][2].terrainType = bomen
terrainLayoutResult[gridSize-1][2].terrainType = bomen



if (worldGetRandom() < 0.5) then
	terrainLayoutResult[6][1].terrainType = bomen
	terrainLayoutResult[gridSize-5][1].terrainType = bomen
else
	terrainLayoutResult[1][6].terrainType = bomen
	terrainLayoutResult[gridSize][6].terrainType = bomen
end


--Zijbomen ver
boomspawnsL = 0
boomspawnsR = 0
boomkans = 0.2
for yPos = 9, gridSize, 1 do
	if (yPos % 2 ~= 0)  then
		yPosboom = yPos - 1
	else
		yPosboom = yPos
	end
	if (worldGetRandom() < boomkans) and boomspawnsL <= 1 then
		MirrorPlaatsing(1, yPosboom, bomen)
		boomspawnsL = boomspawnsL + 1
		boomkans = boomkans + 0.15
		
	end
end


if yHoly2 + 3 <= gridSize then
	terrainLayoutResult[middenPunt][yHoly2+3].terrainType = bomen
else
	terrainLayoutResult[middenPunt][gridSize].terrainType = bomen
end

RelicPlaatsing1 = 0
RelicPlaatsing2 = 0
while RelicPlaatsing1 == 0 do
	if terrainLayoutResult[xRelic1][yRelic1].terrainType ~= vis and terrainLayoutResult[gridSize+1-xRelic1][yRelic1].terrainType ~= vis then
		terrainLayoutResult[xRelic1][yRelic1].terrainType = relic 
		terrainLayoutResult[gridSize+1-xRelic1][yRelic1].terrainType = relic
		RelicPlaatsing1 = 1
	else
		xRelic1 = xRelic1 + 1
		if xRelic1 >= middenPunt-1 then
			yRelic1 = yRelic1-1
			xRelic1 = 3
		end
	end
end

while RelicPlaatsing2 == 0 do
	if terrainLayoutResult[xRelic2][yRelic2].terrainType ~= vis and terrainLayoutResult[gridSize+1-xRelic2][yRelic2].terrainType ~= vis then
		terrainLayoutResult[xRelic2][yRelic2].terrainType = relic 
		terrainLayoutResult[gridSize+1-xRelic2][yRelic2].terrainType = relic
		RelicPlaatsing2 = 1
	else
		xRelic2 = xRelic2 + 1
		if xRelic2 >= middenPunt-1 then
			yRelic2 = yRelic2-1
			xRelic2 = 3
		end
	end
end
terrainLayoutResult[middenPunt][yRelicMid].terrainType = relic 
terrainLayoutResult[1][gridSize].terrainType = tt_settlement_hills 
terrainLayoutResult[gridSize][gridSize].terrainType = tt_settlement_hills
--[[
--Start resources
terrainLayoutResult[5][2].terrainType = tt_pocket_berries
terrainLayoutResult[gridSize-4][2].terrainType = tt_pocket_berries

terrainLayoutResult[2][4].terrainType = tt_berries_gold_small
terrainLayoutResult[gridSize-1][4].terrainType = tt_berries_gold_small

terrainLayoutResult[4][6].terrainType = tt_pocket_stone_c
terrainLayoutResult[gridSize-3][6].terrainType = tt_pocket_stone_c]]--



terrainLayoutResult[4][4].terrainType = tt_player_start_classic_plains_no_trees
terrainLayoutResult[4][4].playerIndex = 0  
terrainLayoutResult[gridSize-3][4].terrainType = tt_player_start_classic_plains_no_trees
terrainLayoutResult[gridSize-3][4].playerIndex = 1


for xPos = 1, gridSize do
	for yPos = 1, 7 do
		if terrainLayoutResult[xPos][yPos].terrainType == tt_hills_lowlands or 
			terrainLayoutResult[xPos][yPos].terrainType == tt_valley or 
			terrainLayoutResult[xPos][yPos].terrainType == tt_hills or 
			terrainLayoutResult[xPos][yPos].terrainType == tt_hills_low_rolling then
			terrainLayoutResult[xPos][yPos].terrainType = tt_plains
		end
		
	end
end


--Spawn hill
for xPos = 6, 8 do
	for yPos = 3, 6 do
		MirrorPlaatsing(xPos, yPos, h1ramp)
		
	end
end
MirrorPlaatsing(7, 4, h1)
MirrorPlaatsing(7, 5, h1)




if rotatie == 1 then
	terrainLayoutResult = rotate_CCW_90(terrainLayoutResult)
elseif rotatie == 2 then
	terrainLayoutResult = rotate_CW_90(terrainLayoutResult)
elseif rotatie == 3 then
	terrainLayoutResult = rotate_180(terrainLayoutResult)
end





