--Upper Guelders by Adne of the DR
teamMappingTable = CreateTeamMappingTable()
terrainLayoutResult = {}    -- set up initial table for coarse map grid
mapRes = 33
gridHeight, gridWidth, gridSize = SetCustomCoarseGrid(mapRes)

if (gridHeight % 2 == 0) then -- height is even so subtract 1 (we want odd numbered grid sizes so that there is a center line in map)
	gridHeight = gridHeight - 1
end

if (gridWidth % 2 == 0) then -- width is even so subtract 1 (we want odd numbered grid sizes so that there is a center line in map)
	gridWidth = gridWidth - 1
end


gridSize = gridWidth -- set resolution of coarse map

playerStarts = worldPlayerCount

n = tt_none
h = tt_hills
s = tt_mountains_small
m = tt_mountains
i = tt_impasse_mountains
b = tt_hills_low_rolling
mr = tt_hills_med_rolling
hr = tt_hills_high_rolling
low = tt_plateau_low
med = tt_plateau_med
high = tt_plateau_high
p = tt_plains
t = tt_impasse_trees_plains
v = tt_valley
grond = tt_plains
rampgrond = tt_hills_lowlands
rampgrond2 = tt_hills
topgrond = tt_plateau_low
bos = tt_impasse_trees_plains
verstopbos = tt_trees_plains_stealth
heuvel = tt_hills_med_rolling
laagland = tt_valley

--bounty squares are used to populate an area of the map with extra resources
bb = tt_bounty_berries_flatland
bg = tt_bounty_gold_plains

--the following are markers used to determine player and settlement spawn points
s = tt_player_start_hills
sp = tt_settlement_plains
sh = tt_settlement_hills
seb = tt_settlement_hills_high_rolling



terrainLayoutResult = SetUpGrid(gridSize, n, terrainLayoutResult)
mapMidPoint = math.ceil(gridSize / 2)


mapHalfSize = math.ceil(gridSize/2)
mapQuarterSize = math.ceil(gridSize/4)
mapEighthSize = math.ceil(gridSize/8)


playerSpawnXt = math.ceil(worldGetRandom() * 2)	
playerSpawnYt = math.ceil(worldGetRandom() * 2)	
playerSpawnX = 1 + playerSpawnXt
playerSpawnY = 1 + playerSpawnYt
typeSpawn = math.ceil(worldGetRandom() * 2)	
bergZijde = math.ceil(worldGetRandom() * 2)	
bosXYt = math.ceil(worldGetRandom() * 3)
bosTeller = 0
bosAantal = 5
rampGarantie = 1 + math.ceil(worldGetRandom() * 3)
if 0.5 <= worldGetRandom() then
	midHOLY = tt_holy_site_hill
	zijdeHOLY = tt_holy_site_hill_danger_lite
else
	midHOLY = tt_holy_site_hill_danger_lite
	zijdeHOLY = tt_holy_site_hill
end
valleiKeuze1 = math.ceil(worldGetRandom() * 4)
valleiKeuze2 = math.ceil(worldGetRandom() * 4)
valleiKeuze3 = math.ceil(worldGetRandom() * 4)

--1: NOORD ZUID SPAWN
	--1: BERG WEST
	--2: BERG OOST
--2: WEST OOST SPAWN
	--1: BERG NOORD
	--2: BERG ZUID


if typeSpawn == 1 then
	if bergZijde == 1 then
		pointerX = 1 + math.ceil(worldGetRandom() * 2)	
		pointerY = 2
		holytX = 1+math.ceil(worldGetRandom() * 2)
		holytY = math.ceil(worldGetRandom() * 3)
		--Ramp nabij spawn
		terrainLayoutResult[1][gridSize-pointerX+1].terrainType = heuvel
		terrainLayoutResult[2][gridSize-pointerX+1].terrainType = rampgrond
		terrainLayoutResult[gridSize-pointerX+1][1].terrainType = heuvel
		terrainLayoutResult[gridSize-pointerX+1][2].terrainType = rampgrond
		while gridSize+1-pointerX > 1+1  do 
			--Eerste twee lijnen berg GEDAAN
			terrainLayoutResult[gridSize-pointerX][1].terrainType = topgrond
			terrainLayoutResult[gridSize-pointerX][1+1].terrainType = topgrond
			terrainLayoutResult[1][gridSize-pointerX].terrainType = topgrond
			terrainLayoutResult[1+1][gridSize-pointerX].terrainType = topgrond
			pointerX = pointerX + 1
			--Optioneel 3 GEDAAN
			if 0.8 <= worldGetRandom() then
				terrainLayoutResult[gridSize-pointerX][1+2].terrainType = topgrond 
				terrainLayoutResult[1+2][gridSize-pointerX].terrainType = topgrond 
				terrainLayoutResult[gridSize-pointerX+1][1+2].terrainType = rampgrond
				terrainLayoutResult[1+2][gridSize-pointerX+1].terrainType = rampgrond
				
				--Optioneel 4 GEDAAN
				if 0.4 <= worldGetRandom() and pointerX < gridSize-2 then
					terrainLayoutResult[gridSize-1-pointerX][1+2].terrainType = topgrond 
					terrainLayoutResult[1+2][gridSize-1-pointerX].terrainType = topgrond
					terrainLayoutResult[gridSize-1-pointerX][1+3].terrainType = rampgrond
					terrainLayoutResult[1+3][gridSize-1-pointerX].terrainType = rampgrond
				end
			end				
		end
		--Willekeurige vallei gedaan
		terrainLayoutResult[gridSize+1-valleiKeuze1][1+3].terrainType = rampgrond 
		terrainLayoutResult[gridSize-3][gridSize+1-valleiKeuze1].terrainType = rampgrond 
		terrainLayoutResult[gridSize+1-valleiKeuze2][1+4].terrainType = rampgrond
		terrainLayoutResult[gridSize-4][gridSize+1-valleiKeuze2].terrainType = rampgrond
		terrainLayoutResult[gridSize+1-valleiKeuze3][1+5].terrainType = rampgrond
		terrainLayoutResult[gridSize-5][gridSize+1-valleiKeuze3].terrainType = rampgrond
		
		--Bos midden
		bosX = 1 + 3 + bosXYt
		bosY = 1 + 3 + bosXYt
		while bosTeller < bosAantal do
			terrainLayoutResult[bosX][bosY].terrainType = bos
			
			
			bosTeller = bosTeller + 1
			if bosTeller < bosAantal then
				terrainLayoutResult[bosX+1][bosY].terrainType = bos
				terrainLayoutResult[bosX][bosY+1].terrainType = bos
				if 0.4 <= worldGetRandom() then
					terrainLayoutResult[bosX+2][bosY].terrainType = heuvel
					terrainLayoutResult[bosX+1][bosY+1].terrainType = heuvel
					terrainLayoutResult[bosX][bosY+2].terrainType = heuvel
					terrainLayoutResult[bosX+1][bosY+1].terrainType = heuvel
				end
			end
			if bosTeller == math.ceil(bosAantal / 2) then
				if 0.3333 <= worldGetRandom() then
					bosMiddenX = bosX
					bosMiddenY = bosY
				elseif 0.5 <= worldGetRandom() then
					bosMiddenX = bosX - 1
					bosMiddenY = bosY - 1
				else
					bosMiddenX = bosX + 1
					bosMiddenY = bosY + 1
					--Zie hier onder
				end
				wolfpuntX = bosMiddenX
				wolfpuntY = bosMiddenY
			end
			bosX = bosX + 1
			bosY = bosY + 1			
		end
		--Rampgarantie
		terrainLayoutResult[1+1][1+3+rampGarantie].terrainType = heuvel
		terrainLayoutResult[1+2][1+3+rampGarantie].terrainType = rampgrond2
		terrainLayoutResult[1+2][1+2+rampGarantie].terrainType = grond
		terrainLayoutResult[1+3+rampGarantie][1+1].terrainType = heuvel
		terrainLayoutResult[1+3+rampGarantie][1+2].terrainType = rampgrond2
		terrainLayoutResult[1+2+rampGarantie][1+2].terrainType = grond
		--Berg 4x4
		for row = 1, 1+3 do
			for col = 1, 1+3 do
				terrainLayoutResult[row][col].terrainType = topgrond
			end
		end	
		--Ramp 4x4
		terrainLayoutResult[1+3][1+3].terrainType = rampgrond2
		terrainLayoutResult[1+4][1+2].terrainType = grond
		terrainLayoutResult[1+2][1+4].terrainType = grond
		
		--Heuvel
		for row = gridSize-3, gridSize do
			for col = gridSize-3, gridSize do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= heuvel) then
					terrainLayoutResult[row][col].terrainType = topgrond
				end
			end
		end	
		--Ramp NW
		for row = gridSize-4, gridSize-4 do
			for col = gridSize-2, gridSize do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= topgrond) then
					terrainLayoutResult[row][col].terrainType = heuvel
				end
			end
		end	
		--Ramp NO
		for row = gridSize-2, gridSize do
			for col =  gridSize-4, gridSize-4 do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= topgrond) then
					terrainLayoutResult[row][col].terrainType = heuvel
				end
			end
		end	
		--Doortrekking bos naar heuvel
		while bosX < gridSize - 2 do
			if (terrainLayoutResult[bosX][bosY].terrainType ~= bos) then
				terrainLayoutResult[bosX][bosY].terrainType = topgrond
				terrainLayoutResult[bosX+1][bosY].terrainType = topgrond
				terrainLayoutResult[bosX][bosY+1].terrainType = topgrond
				bosX = bosX + 1
				bosY = bosY + 1
			end
		end
		
		--Passage midden
		pointerX = bosMiddenX+1
		pointerY = bosMiddenY-1
		while pointerY <= bosMiddenY+1 do
			terrainLayoutResult[pointerX][pointerY].terrainType = rampgrond2
			terrainLayoutResult[pointerX+1][pointerY].terrainType = grond
			terrainLayoutResult[pointerX-1][pointerY].terrainType = grond
			pointerX = pointerX - 1
			pointerY = pointerY + 1
		end
		--Spawns
		terrainLayoutResult[gridSize-playerSpawnX][1+playerSpawnY].terrainType = tt_player_start_nomad_hills
		terrainLayoutResult[gridSize-playerSpawnX][1+playerSpawnY].playerIndex = 0	
		adjSquares = Get8Neighbors(gridSize-playerSpawnX, 1+playerSpawnY, terrainLayoutResult)	
		for testNeighborIndex, testNeighbor in ipairs(adjSquares) do
			testNeighborRow = testNeighbor.x
			testNeighborCol = testNeighbor.y
			terrainLayoutResult[testNeighborRow][testNeighborCol].terrainType = rampgrond	
		end		
		terrainLayoutResult[1+playerSpawnY][gridSize-playerSpawnX].terrainType = tt_player_start_nomad_hills
		terrainLayoutResult[1+playerSpawnY][gridSize-playerSpawnX].playerIndex = 1
		adjSquares = Get8Neighbors(1+playerSpawnY, gridSize-playerSpawnX, terrainLayoutResult)	
		for testNeighborIndex, testNeighbor in ipairs(adjSquares) do
			testNeighborRow = testNeighbor.x
			testNeighborCol = testNeighbor.y
			terrainLayoutResult[testNeighborRow][testNeighborCol].terrainType = rampgrond	
		end
		
		--Bos nabij
		terrainLayoutResult[gridSize-playerSpawnX+2][1+playerSpawnY].terrainType = bos
		terrainLayoutResult[1+playerSpawnY][gridSize-playerSpawnX+2].terrainType = bos
		--Bos ver
		if 0.5 <= worldGetRandom() then
			terrainLayoutResult[gridSize-playerSpawnX-2][1+playerSpawnY].terrainType = bos
			terrainLayoutResult[1+playerSpawnY][gridSize-playerSpawnX-2].terrainType = bos
		else
			terrainLayoutResult[gridSize-playerSpawnX][1+playerSpawnY+2].terrainType = bos
			terrainLayoutResult[1+playerSpawnY+2][gridSize-playerSpawnX].terrainType = bos
		end
		--Ramp nabij
		terrainLayoutResult[gridSize-playerSpawnX][1+playerSpawnY-2].terrainType = rampgrond2
		terrainLayoutResult[1+playerSpawnY-2][gridSize-playerSpawnX].terrainType = rampgrond2
		--Holy
		if 0.5 <= worldGetRandom() then
			terrainLayoutResult[1+2][1+2].terrainType = midHOLY
		else
			terrainLayoutResult[1+3][1+3].terrainType = midHOLY 
		end
		terrainLayoutResult[gridSize-holytY][1+4+holytX].terrainType = zijdeHOLY
		terrainLayoutResult[1+4+holytX][gridSize-holytY].terrainType = zijdeHOLY
		
	end
	
	if bergZijde == 2 then
		pointerX = 2
		pointerY = 1 + math.ceil(worldGetRandom() * 2)	
		holytX = 1+math.ceil(worldGetRandom() * 2)
		holytY = math.ceil(worldGetRandom() * 3)
		--Ramp nabij spawn
		terrainLayoutResult[gridSize][1+pointerY-1].terrainType = heuvel
		terrainLayoutResult[gridSize-2][1+pointerY-1].terrainType = rampgrond
		terrainLayoutResult[1+pointerY-1][gridSize].terrainType = heuvel
		terrainLayoutResult[1+pointerY-1][gridSize-2].terrainType = rampgrond
		while pointerY < gridSize-1  do 
			--Eerste twee lijnen berg 
			terrainLayoutResult[gridSize][1+pointerY].terrainType = topgrond
			terrainLayoutResult[gridSize-1][1+pointerY].terrainType = topgrond
			terrainLayoutResult[1+pointerY][gridSize].terrainType = topgrond
			terrainLayoutResult[1+pointerY][gridSize-1].terrainType = topgrond
			pointerY = pointerY + 1
			--Optioneel 3  gedaan
			if 0.8 <= worldGetRandom() then
				terrainLayoutResult[gridSize-2][1+pointerY].terrainType = topgrond 
				terrainLayoutResult[1+pointerY][gridSize-2].terrainType = topgrond 
				terrainLayoutResult[gridSize-2][pointerY].terrainType = rampgrond
				terrainLayoutResult[pointerY][gridSize-2].terrainType = rampgrond
				
				--Optioneel 4 
				if 0.4 <= worldGetRandom() and pointerY < gridSize-2 then
					terrainLayoutResult[gridSize-2][1+1+pointerY].terrainType = topgrond 
					terrainLayoutResult[1+1+pointerY][gridSize-2].terrainType = topgrond
					terrainLayoutResult[gridSize-3][1+1+pointerY].terrainType = rampgrond
					terrainLayoutResult[1+1+pointerY][gridSize-3].terrainType = rampgrond
				end
			end				
		end
		--Willekeurige vallei gedaan
		terrainLayoutResult[gridSize-3][valleiKeuze1].terrainType = rampgrond 
		terrainLayoutResult[valleiKeuze1][gridSize-3].terrainType = rampgrond 
		terrainLayoutResult[gridSize-4][valleiKeuze2].terrainType = rampgrond
		terrainLayoutResult[valleiKeuze2][gridSize-4].terrainType = rampgrond
		terrainLayoutResult[gridSize-5][valleiKeuze3].terrainType = rampgrond
		terrainLayoutResult[valleiKeuze3][gridSize-5].terrainType = rampgrond
		
		--Bos midden
		bosX = gridSize - 3 - bosXYt
		bosY = gridSize - 3 - bosXYt
		while bosTeller < bosAantal do
			terrainLayoutResult[bosX][bosY].terrainType = bos
			
			
			bosTeller = bosTeller + 1
			if bosTeller < bosAantal then
				terrainLayoutResult[bosX-1][bosY].terrainType = bos
				terrainLayoutResult[bosX][bosY-1].terrainType = bos
				if 0.4 <= worldGetRandom() then
					terrainLayoutResult[bosX-2][bosY].terrainType = heuvel
					terrainLayoutResult[bosX-1][bosY-1].terrainType = heuvel
					terrainLayoutResult[bosX][bosY-2].terrainType = heuvel
					terrainLayoutResult[bosX-1][bosY-1].terrainType = heuvel
				end
			end
			if bosTeller == math.ceil(bosAantal / 2) then
				if 0.3333 <= worldGetRandom() then
					bosMiddenX = bosX
					bosMiddenY = bosY
				elseif 0.5 <= worldGetRandom() then
					bosMiddenX = bosX - 1
					bosMiddenY = bosY - 1
				else
					bosMiddenX = bosX + 1
					bosMiddenY = bosY + 1
					--Zie hier onder
				end
				wolfpuntX = bosMiddenX
				wolfpuntY = bosMiddenY
			end
			bosX = bosX - 1
			bosY = bosY - 1			
		end
		--Rampgarantie
		terrainLayoutResult[gridSize-1][gridSize-3-rampGarantie].terrainType = heuvel
		terrainLayoutResult[gridSize-2][gridSize-3-rampGarantie].terrainType = rampgrond2
		terrainLayoutResult[gridSize-2][gridSize-2-rampGarantie].terrainType = grond
		terrainLayoutResult[gridSize-3-rampGarantie][gridSize-1].terrainType = heuvel
		terrainLayoutResult[gridSize-3-rampGarantie][gridSize-2].terrainType = rampgrond2
		terrainLayoutResult[gridSize-2-rampGarantie][gridSize-2].terrainType = grond
		--Berg 4x4
		for row = gridSize-3, gridSize do
			for col = gridSize-3, gridSize do
				terrainLayoutResult[row][col].terrainType = topgrond
			end
		end	
		--Ramp 4x4
		terrainLayoutResult[gridSize-3][gridSize-3].terrainType = rampgrond2
		terrainLayoutResult[gridSize-4][gridSize-2].terrainType = grond
		terrainLayoutResult[gridSize-2][gridSize-4].terrainType = grond
		
		--Heuvel
		for row = 1, 4 do
			for col = 1, 4 do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= heuvel) then
					terrainLayoutResult[row][col].terrainType = topgrond
				end
			end
		end	
		--Ramp NW
		for row = 5, 5 do
			for col = 1, 3 do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= topgrond) then
					terrainLayoutResult[row][col].terrainType = heuvel
				end
			end
		end	
		--Ramp NO
		for row = 1, 3 do
			for col =  5, 5 do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= topgrond) then
					terrainLayoutResult[row][col].terrainType = heuvel
				end
			end
		end	
		--Doortrekking bos naar heuvel
		while bosX > 3 do
			if (terrainLayoutResult[bosX][bosY].terrainType ~= bos) then
				terrainLayoutResult[bosX][bosY].terrainType = topgrond
				terrainLayoutResult[bosX-1][bosY].terrainType = topgrond
				terrainLayoutResult[bosX][bosY-1].terrainType = topgrond
				bosX = bosX - 1
				bosY = bosY - 1
			end
		end
		
		--Passage midden
		pointerX = bosMiddenX+1
		pointerY = bosMiddenY-1
		while pointerY <= bosMiddenY+1 do
			terrainLayoutResult[pointerX][pointerY].terrainType = rampgrond2
			terrainLayoutResult[pointerX+1][pointerY].terrainType = grond
			terrainLayoutResult[pointerX-1][pointerY].terrainType = grond
			pointerX = pointerX - 1
			pointerY = pointerY + 1
		end
		--Spawns
		terrainLayoutResult[gridSize-playerSpawnX][1+playerSpawnY].terrainType = tt_player_start_nomad_hills
		terrainLayoutResult[gridSize-playerSpawnX][1+playerSpawnY].playerIndex = 0	
		adjSquares = Get8Neighbors(gridSize-playerSpawnX, 1+playerSpawnY, terrainLayoutResult)	
		for testNeighborIndex, testNeighbor in ipairs(adjSquares) do
			testNeighborRow = testNeighbor.x
			testNeighborCol = testNeighbor.y
			terrainLayoutResult[testNeighborRow][testNeighborCol].terrainType = rampgrond	
		end		
		terrainLayoutResult[1+playerSpawnY][gridSize-playerSpawnX].terrainType = tt_player_start_nomad_hills
		terrainLayoutResult[1+playerSpawnY][gridSize-playerSpawnX].playerIndex = 1
		adjSquares = Get8Neighbors(1+playerSpawnY, gridSize-playerSpawnX, terrainLayoutResult)	
		for testNeighborIndex, testNeighbor in ipairs(adjSquares) do
			testNeighborRow = testNeighbor.x
			testNeighborCol = testNeighbor.y
			terrainLayoutResult[testNeighborRow][testNeighborCol].terrainType = rampgrond	
		end
				--[[oorsporong
				
				--Bos nabij
		terrainLayoutResult[1+playerSpawnX][1+playerSpawnY-2].terrainType = bos
		terrainLayoutResult[gridSize-playerSpawnY+2][gridSize-playerSpawnX].terrainType = bos
		--Bos ver
		if 0.5 <= worldGetRandom() then
			terrainLayoutResult[1+playerSpawnX][1+playerSpawnY+2].terrainType = bos
			terrainLayoutResult[gridSize-playerSpawnY-2][gridSize-playerSpawnX].terrainType = bos
		else
			terrainLayoutResult[1+playerSpawnX+2][1+playerSpawnY].terrainType = bos
			terrainLayoutResult[gridSize-playerSpawnY][gridSize-playerSpawnX-2].terrainType = bos
		end 
		--Ramp nabij
		terrainLayoutResult[1+playerSpawnX-2][1+playerSpawnY].terrainType = rampgrond2
		terrainLayoutResult[gridSize-playerSpawnY][gridSize-playerSpawnX+2].terrainType = rampgrond2]]--
		--Bos nabij
		terrainLayoutResult[gridSize-playerSpawnX][1+playerSpawnY-2].terrainType = bos
		terrainLayoutResult[1+playerSpawnY-2][gridSize-playerSpawnX].terrainType = bos
		--Bos ver
		if 0.5 <= worldGetRandom() then
			terrainLayoutResult[gridSize-playerSpawnX][1+playerSpawnY+2].terrainType = bos
			terrainLayoutResult[1+playerSpawnY+2][gridSize-playerSpawnX].terrainType = bos
		else
			terrainLayoutResult[gridSize-playerSpawnX-2][1+playerSpawnY].terrainType = bos
			terrainLayoutResult[1+playerSpawnY][gridSize-playerSpawnX-2].terrainType = bos
		end
		--Ramp nabij
		terrainLayoutResult[gridSize-playerSpawnX+2][1+playerSpawnY].terrainType = rampgrond2
		terrainLayoutResult[1+playerSpawnY][gridSize-playerSpawnX+2].terrainType = rampgrond2
		--Holy
		if 0.5 <= worldGetRandom() then
			terrainLayoutResult[gridSize-2][gridSize-2].terrainType = midHOLY
		else
			terrainLayoutResult[gridSize-3][gridSize-3].terrainType = midHOLY 
		end
		terrainLayoutResult[gridSize-4-holytX][1+holytY].terrainType = zijdeHOLY
		terrainLayoutResult[1+holytY][gridSize-4-holytX].terrainType = zijdeHOLY
		
	end
	for row = 1, 2 do
		for col =  1, 2 do
				if 0.5 <= worldGetRandom() then
					terrainLayoutResult[row][col].terrainType = b
				end
			end
		end	
	for row = gridSize-1, gridSize do
		for col =  gridSize-1, gridSize do
				if 0.5 <= worldGetRandom() then
					terrainLayoutResult[row][col].terrainType = b
				end
			end
		end	
end
	
if typeSpawn == 2 then
	if bergZijde == 1 then
		pointerX = 2
		pointerY = 1 + math.ceil(worldGetRandom() * 2)	
		holytX = 1+math.ceil(worldGetRandom() * 2)
		holytY = math.ceil(worldGetRandom() * 3)
		--Ramp nabij spawn
		terrainLayoutResult[1][1+pointerY-1].terrainType = heuvel
		terrainLayoutResult[1+1][1+pointerY-1].terrainType = rampgrond
		terrainLayoutResult[gridSize-pointerY+1][gridSize].terrainType = heuvel
		terrainLayoutResult[gridSize-pointerY+1][gridSize-1].terrainType = rampgrond
		while pointerY < gridSize-1 do
			--Eerste twee lijnen berg
			terrainLayoutResult[1][1+pointerY].terrainType = topgrond
			terrainLayoutResult[1+1][1+pointerY].terrainType = topgrond
			terrainLayoutResult[gridSize-pointerY][gridSize].terrainType = topgrond
			terrainLayoutResult[gridSize-pointerY][gridSize-1].terrainType = topgrond
			pointerY = pointerY + 1
			--Optioneel 3
			if 0.8 <= worldGetRandom() then
				terrainLayoutResult[1+2][1+pointerY].terrainType = topgrond
				terrainLayoutResult[gridSize-pointerY][gridSize-2].terrainType = topgrond
				terrainLayoutResult[1+2][1+pointerY-1].terrainType = rampgrond
				terrainLayoutResult[gridSize-pointerY+1][gridSize-2].terrainType = rampgrond
				
				--Optioneel 4
				if 0.4 <= worldGetRandom() and pointerY < gridSize-2 then
					terrainLayoutResult[1+2][1+1+pointerY].terrainType = topgrond
					terrainLayoutResult[gridSize-1-pointerY][gridSize-2].terrainType = topgrond
					terrainLayoutResult[1+3][1+1+pointerY].terrainType = rampgrond
					terrainLayoutResult[gridSize-1-pointerY][gridSize-3].terrainType = rampgrond
				end
			end				
		end
		--Willekeurige vallei
		terrainLayoutResult[1+3][valleiKeuze1].terrainType = rampgrond
		terrainLayoutResult[gridSize+1-valleiKeuze1][gridSize-3].terrainType = rampgrond
		terrainLayoutResult[1+4][valleiKeuze2].terrainType = rampgrond
		terrainLayoutResult[gridSize+1-valleiKeuze2][gridSize-4].terrainType = rampgrond
		terrainLayoutResult[1+5][valleiKeuze3].terrainType = rampgrond
		terrainLayoutResult[gridSize+1-valleiKeuze3][gridSize-5].terrainType = rampgrond
		
		
		--Bos midden
		bosX = 1 + 3 + bosXYt
		bosY = gridSize - 3 - bosXYt
		while bosTeller < bosAantal do
			terrainLayoutResult[bosX][bosY].terrainType = bos
			
			
			bosTeller = bosTeller + 1
			if bosTeller < bosAantal then
				terrainLayoutResult[bosX+1][bosY].terrainType = bos
				terrainLayoutResult[bosX][bosY-1].terrainType = bos
				if 0.4 <= worldGetRandom() then
					terrainLayoutResult[bosX+2][bosY].terrainType = heuvel
					terrainLayoutResult[bosX+1][bosY+1].terrainType = heuvel
					terrainLayoutResult[bosX][bosY-2].terrainType = heuvel
					terrainLayoutResult[bosX-1][bosY-1].terrainType = heuvel
				end
			end
			if bosTeller == math.ceil(bosAantal / 2) then
				if 0.333 <= worldGetRandom() then
					bosMiddenX = bosX
					bosMiddenY = bosY
				elseif 0.5 <= worldGetRandom() then
					bosMiddenX = bosX - 1
					bosMiddenY = bosY + 1
				else
					bosMiddenX = bosX + 1
					bosMiddenY = bosY - 1
					--Zie hier onder
				end
				wolfpuntX = bosMiddenX
				wolfpuntY = bosMiddenY
			end
			bosX = bosX + 1
			bosY = bosY - 1			
		end
		--Rampgarantie
		terrainLayoutResult[1+1][gridSize-3-rampGarantie].terrainType = heuvel
		terrainLayoutResult[1+2][gridSize-3-rampGarantie].terrainType = rampgrond2
		terrainLayoutResult[1+2][gridSize-2-rampGarantie].terrainType = grond
		terrainLayoutResult[1+3+rampGarantie][gridSize-1].terrainType = heuvel
		terrainLayoutResult[1+3+rampGarantie][gridSize-2].terrainType = rampgrond2
		terrainLayoutResult[1+2+rampGarantie][gridSize-2].terrainType = grond
		--Berg 4x4
		for row = 1, 1+3 do
			for col = gridSize-3, gridSize do
				terrainLayoutResult[row][col].terrainType = topgrond
			end
		end	
		--Ramp 4x4
		terrainLayoutResult[1+3][gridSize-3].terrainType = rampgrond2
		terrainLayoutResult[1+4][gridSize-2].terrainType = grond
		terrainLayoutResult[1+2][gridSize-4].terrainType = grond
		--Heuvel
		for row = gridSize-3, gridSize do
			for col = 1, 1+3 do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= heuvel) then
					terrainLayoutResult[row][col].terrainType = topgrond
				end
			end
		end	
		--Ramp NW
		for row = gridSize-4, gridSize-4 do
			for col = 1, 1+2 do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= topgrond) then
					terrainLayoutResult[row][col].terrainType = heuvel
				end
			end
		end	
		--Ramp NO
		for row = gridSize-2, gridSize do
			for col = 1+4, 1+4 do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= topgrond) then
					terrainLayoutResult[row][col].terrainType = heuvel
				end
			end
		end	
		--Doortrekking bos naar heuvel
		while bosX < gridSize - 2 do
			if (terrainLayoutResult[bosX][bosY].terrainType ~= bos) then
				terrainLayoutResult[bosX][bosY].terrainType = topgrond
				terrainLayoutResult[bosX+1][bosY].terrainType = topgrond
				terrainLayoutResult[bosX][bosY-1].terrainType = topgrond
				bosX = bosX + 1
				bosY = bosY - 1	
			end
		end
		
		--Passage midden
		pointerX = bosMiddenX-1
		pointerY = bosMiddenY-1
		while pointerX <= bosMiddenX+1 do
			terrainLayoutResult[pointerX][pointerY].terrainType = rampgrond2
			terrainLayoutResult[pointerX][pointerY+1].terrainType = grond
			terrainLayoutResult[pointerX][pointerY-1].terrainType = grond
			pointerX = pointerX + 1
			pointerY = pointerY + 1
		end
		--Spawns
		terrainLayoutResult[1+playerSpawnX][1+playerSpawnY].terrainType = tt_player_start_nomad_hills
		terrainLayoutResult[1+playerSpawnX][1+playerSpawnY].playerIndex = 0	
		adjSquares = Get8Neighbors(1+playerSpawnX, 1+playerSpawnY, terrainLayoutResult)	
		for testNeighborIndex, testNeighbor in ipairs(adjSquares) do
			testNeighborRow = testNeighbor.x
			testNeighborCol = testNeighbor.y
			terrainLayoutResult[testNeighborRow][testNeighborCol].terrainType = rampgrond	
		end		
		terrainLayoutResult[gridSize-playerSpawnY][gridSize-playerSpawnX].terrainType = tt_player_start_nomad_hills
		terrainLayoutResult[gridSize-playerSpawnY][gridSize-playerSpawnX].playerIndex = 1
		adjSquares = Get8Neighbors(gridSize-playerSpawnY, gridSize-playerSpawnX, terrainLayoutResult)	
		for testNeighborIndex, testNeighbor in ipairs(adjSquares) do
			testNeighborRow = testNeighbor.x
			testNeighborCol = testNeighbor.y
			terrainLayoutResult[testNeighborRow][testNeighborCol].terrainType = rampgrond	
		end
		--Bos nabij
		terrainLayoutResult[1+playerSpawnX][1+playerSpawnY-2].terrainType = bos
		terrainLayoutResult[gridSize-playerSpawnY+2][gridSize-playerSpawnX].terrainType = bos
		--Bos ver
		if 0.5 <= worldGetRandom() then
			terrainLayoutResult[1+playerSpawnX][1+playerSpawnY+2].terrainType = bos
			terrainLayoutResult[gridSize-playerSpawnY-2][gridSize-playerSpawnX].terrainType = bos
		else
			terrainLayoutResult[1+playerSpawnX+2][1+playerSpawnY].terrainType = bos
			terrainLayoutResult[gridSize-playerSpawnY][gridSize-playerSpawnX-2].terrainType = bos
		end
		--Ramp nabij
		terrainLayoutResult[1+playerSpawnX-2][1+playerSpawnY].terrainType = rampgrond2
		terrainLayoutResult[gridSize-playerSpawnY][gridSize-playerSpawnX+2].terrainType = rampgrond2
		--Holy
		if 0.5 <= worldGetRandom() then
			terrainLayoutResult[1+2][gridSize-2].terrainType = midHOLY
		else
			terrainLayoutResult[1+3][gridSize-3].terrainType = midHOLY
		end
		terrainLayoutResult[1+4+holytX][1+holytY].terrainType = zijdeHOLY
		terrainLayoutResult[gridSize-holytY][gridSize-4-holytX].terrainType = zijdeHOLY
		
	end	
	
--2:2		
	
	if bergZijde == 2 then
		holytX = math.ceil(worldGetRandom() * 3)
		holytY = 1+math.ceil(worldGetRandom() * 2)
		pointerX = 1 + math.ceil(worldGetRandom() * 2)
		pointerY = 2
		--Ramp nabij spawn gedaan
		terrainLayoutResult[1+pointerX-1][1].terrainType = heuvel 
		terrainLayoutResult[1+pointerX-1][1+1].terrainType = rampgrond 
		terrainLayoutResult[gridSize][gridSize-pointerX+1].terrainType = heuvel 
		terrainLayoutResult[gridSize-1][gridSize-pointerX+1].terrainType = rampgrond 
		while pointerX < gridSize-1 do
			--Eerste twee lijnen berg gedaan
			terrainLayoutResult[1+pointerX][1].terrainType = topgrond
			terrainLayoutResult[1+pointerX][1+1].terrainType = topgrond
			terrainLayoutResult[gridSize][gridSize-pointerX].terrainType = topgrond
			terrainLayoutResult[gridSize-1][gridSize-pointerX].terrainType = topgrond
			pointerX = pointerX + 1
			--Optioneel 3 gedaan
			if 0.8 <= worldGetRandom() then
				terrainLayoutResult[1+pointerX][1+2].terrainType = topgrond
				terrainLayoutResult[gridSize-2][gridSize-pointerX].terrainType = topgrond
				terrainLayoutResult[1+pointerX-1][1+2].terrainType = rampgrond
				terrainLayoutResult[gridSize-2][gridSize-pointerX+1].terrainType = rampgrond
					
				--Optioneel 4 gedaan
				if 0.4 <= worldGetRandom() and pointerX < gridSize-2 then
					terrainLayoutResult[1+1+pointerX][1+2].terrainType = topgrond
					terrainLayoutResult[gridSize-2][gridSize-1-pointerX].terrainType = topgrond
					terrainLayoutResult[1+1+pointerX][1+3].terrainType = rampgrond 
					terrainLayoutResult[gridSize-3][gridSize-1-pointerX].terrainType = rampgrond
				end
			end				
		end  
		--Willekeurige vallei gedaan
		terrainLayoutResult[valleiKeuze1][1+3].terrainType = rampgrond 
		terrainLayoutResult[gridSize-3][gridSize+1-valleiKeuze1].terrainType = rampgrond  
		terrainLayoutResult[valleiKeuze2][1+4].terrainType = rampgrond
		terrainLayoutResult[gridSize-4][gridSize+1-valleiKeuze2].terrainType = rampgrond 
		terrainLayoutResult[valleiKeuze3][1+5].terrainType = rampgrond 
		terrainLayoutResult[gridSize-5][gridSize+1-valleiKeuze3].terrainType = rampgrond 
		
		
		--Bos midden gedaan
		bosX = gridSize - 3 - bosXYt
		bosY = 1 + 3 + bosXYt
		while bosTeller < bosAantal do
			terrainLayoutResult[bosX][bosY].terrainType = bos
			
			
			bosTeller = bosTeller + 1
			if bosTeller < bosAantal then
				terrainLayoutResult[bosX][bosY+1].terrainType = bos
				terrainLayoutResult[bosX-1][bosY].terrainType = bos
				if 0.4 <= worldGetRandom() then
					terrainLayoutResult[bosX][bosY+2].terrainType = heuvel
					terrainLayoutResult[bosX+1][bosY+1].terrainType = heuvel
					terrainLayoutResult[bosX-2][bosY].terrainType = heuvel
					terrainLayoutResult[bosX-1][bosY-1].terrainType = heuvel
				end
			end
			if bosTeller == math.ceil(bosAantal / 2) then
				if 0.3333 <= worldGetRandom() then
					bosMiddenX = bosX
					bosMiddenY = bosY
				elseif 0.5 <= worldGetRandom() then
					bosMiddenX = bosX + 1
					bosMiddenY = bosY - 1
				else
					bosMiddenX = bosX - 1
					bosMiddenY = bosY + 1
					--Zie hier onder
				end
				wolfpuntX = bosMiddenX
				wolfpuntY = bosMiddenY
			end
			
			bosX = bosX - 1
			bosY = bosY + 1		
		end
		--Rampgarantie gedaan
		terrainLayoutResult[gridSize-3-rampGarantie][1+1].terrainType = heuvel 
		terrainLayoutResult[gridSize-3-rampGarantie][1+2].terrainType = rampgrond2 
		terrainLayoutResult[gridSize-2-rampGarantie][1+2].terrainType = grond 
		terrainLayoutResult[gridSize-1][1+3+rampGarantie].terrainType = heuvel 
		terrainLayoutResult[gridSize-2][1+3+rampGarantie].terrainType = rampgrond2 
		terrainLayoutResult[gridSize-2][1+2+rampGarantie].terrainType = grond 
		--Berg 4x4 gedaan
		for row = gridSize-3, gridSize do
			for col = 1, 1+3 do
				terrainLayoutResult[row][col].terrainType = topgrond
			end
		end	
		--Ramp 4x4 gedan
		terrainLayoutResult[gridSize-3][1+3].terrainType = rampgrond2 
		terrainLayoutResult[gridSize-2][1+4].terrainType = grond 
		terrainLayoutResult[gridSize-4][1+2].terrainType = grond 
		--Heuvel
		for row = 1, 1+3  do
			for col = gridSize-3, gridSize do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= heuvel) then
					terrainLayoutResult[row][col].terrainType = topgrond
				end
			end
		end	
		--Ramp NW gedaan
		for row = 1, 1+2 do
			for col = gridSize-4, gridSize-4 do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= topgrond) then
					terrainLayoutResult[row][col].terrainType = heuvel
				end
			end
		end	
		--Ramp NO gedaan
		for row = 1+4, 1+4 do
			for col = gridSize-2, gridSize do
				if (terrainLayoutResult[row][col].terrainType ~= bos) and (terrainLayoutResult[row][col].terrainType ~= topgrond) then
					terrainLayoutResult[row][col].terrainType = heuvel
				end
			end
		end	
		--Doortrekking bos naar heuvel 
		while bosY < gridSize - 2 do
			if (terrainLayoutResult[bosX][bosY].terrainType ~= bos) then
				terrainLayoutResult[bosX][bosY].terrainType = topgrond
				terrainLayoutResult[bosX][bosY-1].terrainType = topgrond
				terrainLayoutResult[bosX+1][bosY].terrainType = topgrond
				bosX = bosX - 1
				bosY = bosY + 1	
			end
		end
		
		--Passage midden
		pointerX = bosMiddenX+1
		pointerY = bosMiddenY+1
		while pointerX >= bosMiddenX-1 do
			terrainLayoutResult[pointerX][pointerY].terrainType = rampgrond2
			terrainLayoutResult[pointerX][pointerY+1].terrainType = grond
			terrainLayoutResult[pointerX][pointerY-1].terrainType = grond
			pointerX = pointerX - 1
			pointerY = pointerY - 1
		end 
		--Spawns 
		terrainLayoutResult[1+playerSpawnY][1+playerSpawnX].terrainType = tt_player_start_nomad_hills 
		terrainLayoutResult[1+playerSpawnY][1+playerSpawnX].playerIndex = 0	 
		adjSquares = Get8Neighbors(1+playerSpawnY, 1+playerSpawnX, terrainLayoutResult)	
		for testNeighborIndex, testNeighbor in ipairs(adjSquares) do
			testNeighborRow = testNeighbor.x
			testNeighborCol = testNeighbor.y
			terrainLayoutResult[testNeighborRow][testNeighborCol].terrainType = rampgrond	
		end		
		terrainLayoutResult[gridSize-playerSpawnX][gridSize-playerSpawnY].terrainType = tt_player_start_nomad_hills 
		terrainLayoutResult[gridSize-playerSpawnX][gridSize-playerSpawnY].playerIndex = 1 
		adjSquares = Get8Neighbors(gridSize-playerSpawnX, gridSize-playerSpawnY, terrainLayoutResult)	
		for testNeighborIndex, testNeighbor in ipairs(adjSquares) do
			testNeighborRow = testNeighbor.x
			testNeighborCol = testNeighbor.y
			terrainLayoutResult[testNeighborRow][testNeighborCol].terrainType = rampgrond	
		end
		--Bos nabij gedaan
		terrainLayoutResult[1+playerSpawnY-2][1+playerSpawnX].terrainType = bos
		terrainLayoutResult[gridSize-playerSpawnX][gridSize-playerSpawnY+2].terrainType = bos 
		--Bos ver gedaan
		if 0.5 <= worldGetRandom() then
			terrainLayoutResult[1+playerSpawnY+2][1+playerSpawnX].terrainType = bos 
			terrainLayoutResult[gridSize-playerSpawnX][gridSize-playerSpawnY-2].terrainType = bos 
		else
			terrainLayoutResult[1+playerSpawnY][1+playerSpawnX+2].terrainType = bos 
			terrainLayoutResult[gridSize-playerSpawnX-2][gridSize-playerSpawnY].terrainType = bos 
		end
		--Ramp nabij gedaan
		terrainLayoutResult[1+playerSpawnY][1+playerSpawnX-2].terrainType = rampgrond2 
		terrainLayoutResult[gridSize-playerSpawnX+2][gridSize-playerSpawnY].terrainType = rampgrond2 
		--Holy 
		if 0.5 <= worldGetRandom() then
			terrainLayoutResult[gridSize-2][1+2].terrainType = midHOLY 
		else
			terrainLayoutResult[gridSize-3][1+3].terrainType = midHOLY 
		end
		terrainLayoutResult[1+holytX][1+4+holytY].terrainType = zijdeHOLY 
		terrainLayoutResult[gridSize-4-holytY][gridSize-holytX].terrainType = zijdeHOLY 
		
	end
	for row = 1, 2 do
		for col =   gridSize-1, gridSize do
				if 0.5 <= worldGetRandom() then
					terrainLayoutResult[row][col].terrainType = b
				end
			end
		end	
	for row = gridSize-1, gridSize do
		for col =  1, 2 do
				if 0.5 <= worldGetRandom() then
					terrainLayoutResult[row][col].terrainType = b
				end
			end
		end	
end	

for row = 1, gridSize do
	for col = 1, gridSize do
		if row == 1 or col == 1 or row == gridSize or col == gridSize then
			if(terrainLayoutResult[row][col].terrainType == topgrond ) then
				if 0.35 <= worldGetRandom() then
					terrainLayoutResult[row][col].terrainType = rampgrond2
				end
			end
		end
	end	
end


--Wolfjes
terrainLayoutResult[wolfpuntX][wolfpuntY].terrainType = tt_wolf_spawner


