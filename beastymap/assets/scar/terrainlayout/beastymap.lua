--Beastymap created by Adne of the DR and high, high level player BeastyQT
--Holy!

n = tt_none 
tijdelijk = tt_flatland
heuvel = tt_hills
heuvel2 = tt_hills_gentle_rolling_clearing
grond = tt_plains
grond2 = tt_trees_plains_clearing
vis = tt_lake_shallow_hill_fish
meer = tt_lake_shallow_hill
--vis = tt_lake_shallow_hill_fish
--bomen = tt_impasse_trees_hills
bomen = tt_impasse_trees_plains_forest
kleinebomen = tt_impasse_trees_small_plains
midclear = tt_trees_plains_clearing_large
berg = tt_rock_pillar

relic = tt_relic_spawner
wolf = tt_wolf_spawner
dal = tt_ocean
gold = tt_gold_large_single
goldsmall = tt_gold_small_single
stone = tt_stone_large_single
berries = tt_berries_small_single

markt = tt_settlement_plains


h1 = tt_plateau_low
h1holy = tt_holy_site_hill
h2 = tt_plateau_med
h1ramp = tt_hills
h1gold = tt_tactical_region_gold_plateau_low_a
h1stone = tt_tactical_region_stone_plateau_low_a
goldberries = tt_tactical_region_gold_plains_c
holy = tt_holy_site
deer = tt_deer_herd_large
water = tt_valley
stealth = tt_trees_plains_stealth


gridHeight, gridWidth, gridSize = SetCustomCoarseGrid(15)
terrainLayoutResult = SetUpGrid(gridSize, n, terrainLayoutResult)

middenPunt =  math.ceil(gridSize/2)	
rotatie = math.ceil(worldGetRandom() * 4)	

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

function MirrorPlaatsing(xPos, yPos, ttType)
	if xPos <= gridSize and yPos <= gridSize and xPos >= 1 and yPos >= 1 then
		terrainLayoutResult[xPos][yPos].terrainType = ttType
	end
	if gridSize+1-xPos <= gridSize and yPos <= gridSize and gridSize+1-xPos >= 1 and gridSize+1-yPos >= 1 then
		terrainLayoutResult[gridSize+1-xPos][yPos].terrainType = ttType
	end
end

function vrijCheck (xPos, yPos)
	for x = xPos - 2, xPos + 2 do
		for y = yPos - 2, yPos + 2 do
			if x <= gridSize and
				x >= 1 and 
				y <= gridSize and 
				y >= 1 then
					if terrainLayoutResult[x][y].terrainType ~= tt_none or terrainLayoutResult[gridSize+1-x][y].terrainType ~= tt_none then 				
						return false
					end
			else	
				return false
			end
		end
	end
	return true
end

function vrijCheckGeenMirror (xPos, yPos)
	for x = xPos - 2, xPos + 2 do
		for y = yPos - 2, yPos + 2 do
			if x <= gridSize and
				x >= 1 and 
				y <= gridSize and 
				y >= 1 then
					if terrainLayoutResult[x][y].terrainType ~= tt_none then 				
						return false
					end
			else	
				return false
			end
		end
	end
	return true
end



for yPos = 7, 14 do
	terrainLayoutResult[middenPunt][yPos].terrainType = berg
end




--Vis
MirrorPlaatsing(1, 2, meer)
MirrorPlaatsing(1, 1, vis)

MirrorPlaatsing(2, 1, meer)
MirrorPlaatsing(2, 2, meer)

MirrorPlaatsing(3, 1, meer)
MirrorPlaatsing(3, 2, meer)

--[[
if worldGetRandom() < 0.5 then
	MirrorPlaatsing(1, 3, vis)
	MirrorPlaatsing(2, 3, vis)
else
	MirrorPlaatsing(3, 1, vis)
	MirrorPlaatsing(3, 2, vis)
end]]--

for xPos = 13, 15 do
		terrainLayoutResult[xPos][27].terrainType = meer
end
terrainLayoutResult[14][26].terrainType = meer
if worldGetRandom() < 0.5 then
	terrainLayoutResult[13][26].terrainType = vis
	terrainLayoutResult[15][26].terrainType = meer
else
	terrainLayoutResult[15][26].terrainType = vis
	terrainLayoutResult[13][26].terrainType = meer	
end

--[[
if worldGetRandom() < 0.5 then
	MirrorPlaatsing(1, 25, vis)
	MirrorPlaatsing(2, 25, vis)
else
	MirrorPlaatsing(3, 26, vis)
	MirrorPlaatsing(3, 27, vis)
end]]--



--Bomen
print("Bomen")
--[[
if worldGetRandom() < 0.333 then
	MirrorPlaatsing(4, 10, bomen)
	boomSoort = 1
	print("1")
elseif worldGetRandom() < 0.5 then
	MirrorPlaatsing(8, 6, bomen)
	boomSoort = 2
	print("2")
else
	MirrorPlaatsing(8, 14, bomen)
	boomSoort = 3
	print("3")
end]]--

if worldGetRandom() < 0.5 then
	terrainLayoutResult[12][9].terrainType = bomen
	terrainLayoutResult[16][11].terrainType = bomen
else
	terrainLayoutResult[16][9].terrainType = bomen
	terrainLayoutResult[12][11].terrainType = bomen
end

terrainLayoutResult[14][2].terrainType = holy

if worldGetRandom() < 0.5 then
	MirrorPlaatsing(7, 21, holy)
else
	MirrorPlaatsing(8, 21, holy)
end

bomenSecundair = {}
bomenTertiair = {}
--[[
if boomSoort == 1 then
	table.insert(bomenSecundair, #bomenSecundair+1, {7, 5})
	table.insert(bomenSecundair, #bomenSecundair+1, {8, 4})
	table.insert(bomenSecundair, #bomenSecundair+1, {8, 5})
	table.insert(bomenSecundair, #bomenSecundair+1, {8, 15})
	table.insert(bomenSecundair, #bomenSecundair+1, {8, 16})
	table.insert(bomenSecundair, #bomenSecundair+1, {9, 15})
end
if boomSoort == 2 then
	table.insert(bomenSecundair, #bomenSecundair+1, {4, 11})
	table.insert(bomenSecundair, #bomenSecundair+1, {4, 12})
	table.insert(bomenSecundair, #bomenSecundair+1, {5, 13})
	table.insert(bomenSecundair, #bomenSecundair+1, {6, 14})
	table.insert(bomenSecundair, #bomenSecundair+1, {7, 14})
	table.insert(bomenSecundair, #bomenSecundair+1, {7, 15})
end

if boomSoort == 3 then
	table.insert(bomenSecundair, #bomenSecundair+1, {8, 4})
	table.insert(bomenSecundair, #bomenSecundair+1, {8, 5})
	table.insert(bomenSecundair, #bomenSecundair+1, {7, 5})
	table.insert(bomenSecundair, #bomenSecundair+1, {6, 5})	
end

	table.insert(bomenTertiair, #bomenTertiair+1, {4, 19})
	table.insert(bomenTertiair, #bomenTertiair+1, {6, 18})
	table.insert(bomenTertiair, #bomenTertiair+1, {4, 24})
	table.insert(bomenTertiair, #bomenTertiair+1, {3, 20})


]]--



table.insert(bomenSecundair, #bomenSecundair+1, {5, 15})
table.insert(bomenSecundair, #bomenSecundair+1, {4, 15})
table.insert(bomenSecundair, #bomenSecundair+1, {6, 15})
table.insert(bomenSecundair, #bomenSecundair+1, {5, 15})
table.insert(bomenSecundair, #bomenSecundair+1, {6, 16})
table.insert(bomenSecundair, #bomenSecundair+1, {5, 16})

table.insert(bomenTertiair, #bomenTertiair+1, {10, 19})
table.insert(bomenTertiair, #bomenTertiair+1, {10, 24})
table.insert(bomenTertiair, #bomenTertiair+1, {11, 23})
table.insert(bomenTertiair, #bomenTertiair+1, {9, 24})



if worldGetRandom() < 0.22 then
	local keuze = math.ceil(worldGetRandom() * #bomenSecundair)
	MirrorPlaatsing(bomenSecundair[keuze][1], bomenSecundair[keuze][2], bomen)
	print("Mirror bomenSecundair")
	print("bomenSecundair X " .. bomenSecundair[keuze][1])
	print("bomenSecundair Y " .. bomenSecundair[keuze][2])
else
	local keuze = math.ceil(worldGetRandom() * #bomenSecundair)
	local keuzeTwee = math.ceil(worldGetRandom() * #bomenSecundair)
	terrainLayoutResult[bomenSecundair[keuze][1]][bomenSecundair[keuze][2]].terrainType = bomen
	terrainLayoutResult[gridSize+1-bomenSecundair[keuzeTwee][1]][bomenSecundair[keuzeTwee][2]].terrainType = bomen
	print("bomenSecundair X " .. bomenSecundair[keuze][1])
	print("bomenSecundair Y " .. bomenSecundair[keuze][2])
	print("bomenSecundair X " .. bomenSecundair[keuzeTwee][1])
	print("bomenSecundair Y " .. bomenSecundair[keuzeTwee][2])
	
end



if worldGetRandom() < 0.27 then
	local keuze = math.ceil(worldGetRandom() * #bomenTertiair)
	MirrorPlaatsing(bomenTertiair[keuze][1], bomenTertiair[keuze][2], bomen)
	print("Mirror bomenTertiair")
	print("bomenTertiair X " .. bomenTertiair[keuze][1])
	print("bomenTertiair Y " .. bomenTertiair[keuze][2])
else
	local keuze = math.ceil(worldGetRandom() * #bomenTertiair)
	local keuzeTwee = math.ceil(worldGetRandom() * #bomenTertiair)
	terrainLayoutResult[bomenTertiair[keuze][1]][bomenTertiair[keuze][2]].terrainType = bomen
	terrainLayoutResult[gridSize+1-bomenTertiair[keuzeTwee][1]][bomenTertiair[keuzeTwee][2]].terrainType = bomen
	print("bomenTertiair X " .. bomenSecundair[keuze][1])
	print("bomenTertiair Y " .. bomenSecundair[keuze][2])
	print("bomenTertiair X " .. bomenSecundair[keuzeTwee][1])
	print("bomenTertiair Y " .. bomenSecundair[keuzeTwee][2])
end




--Relics
terrainLayoutResult[14][5].terrainType = relic
terrainLayoutResult[14][17+(math.ceil(worldGetRandom() * 2))].terrainType = relic
terrainLayoutResult[14][22+(math.ceil(worldGetRandom() * 2))].terrainType = relic

relicTabel ={}
for xPos = 1, 8 do
	for yPos = 15, 22 do
		if vrijCheck(xPos, yPos) == true then
			table.insert(relicTabel, #relicTabel+1, {xPos, yPos})
		end
	end
end

if #relicTabel >= 1 then
	local keuze = math.ceil(worldGetRandom() * #relicTabel)
	MirrorPlaatsing(relicTabel[keuze][1], relicTabel[keuze][2], relic)
else
	MirrorPlaatsing(12, 5, relic)
end


--Goud en steen
--[[
if worldGetRandom() < 0.5 then
	eersteResource = gold
	tweedeResource = stone
else
	eersteResource = stone
	tweedeResource = gold	
end]]--
eersteResource = stone
tweedeResource = gold	

eersteResourceTabel ={}
for xPos = 4, 10 do
	for yPos = 2, 4 do
		if vrijCheck(xPos, yPos) == true then
			table.insert(eersteResourceTabel, #eersteResourceTabel+1, {xPos, yPos})
		end
	end
end

if #eersteResourceTabel >= 1 then
	local keuze = math.ceil(worldGetRandom() * #eersteResourceTabel)
	MirrorPlaatsing(eersteResourceTabel[keuze][1], eersteResourceTabel[keuze][2], eersteResource)
else
	MirrorPlaatsing(5, 2, eersteResource)
end

tweedeResourceTabel ={}
for xPos = 1, 10 do
	for yPos = 23, 27 do
		if vrijCheck(xPos, yPos) == true then
			table.insert(tweedeResourceTabel, #tweedeResourceTabel+1, {xPos, yPos})
		end
	end
end

if #tweedeResourceTabel >= 1 then
	local keuze = math.ceil(worldGetRandom() * #tweedeResourceTabel)
	MirrorPlaatsing(tweedeResourceTabel[keuze][1], tweedeResourceTabel[keuze][2], tweedeResource)
else
	MirrorPlaatsing(7,27, tweedeResource)
end

--Deer
deerResourceTabel ={}
for xPos = 2, 7 do
	for yPos = 14, 18 do
		if vrijCheck(xPos, yPos) == true then
			table.insert(deerResourceTabel, #deerResourceTabel+1, {xPos, yPos})
		end
	end
end

if #deerResourceTabel >= 1 then
	local keuze = math.ceil(worldGetRandom() * #deerResourceTabel)
	MirrorPlaatsing(deerResourceTabel[keuze][1], deerResourceTabel[keuze][2], heuvel)
else
	MirrorPlaatsing(2,15, heuvel)
end

deerResourceTabel ={}
for xPos = 6, 10 do
	for yPos = 19, 25 do
		if vrijCheck(xPos, yPos) == true then
			table.insert(deerResourceTabel, #deerResourceTabel+1, {xPos, yPos})
		end
	end
end

if #deerResourceTabel >= 1 then
	local keuze = math.ceil(worldGetRandom() * #deerResourceTabel)
	MirrorPlaatsing(deerResourceTabel[keuze][1], deerResourceTabel[keuze][2], deer)
else
	MirrorPlaatsing(5,26, deer)
end


--Berries
MirrorPlaatsing(2, 7, berries)

--Stealth
for i = 1, 14 do
	stealthTabel ={}
	for xPos = 1, gridSize do
		for yPos = 1, gridSize do
			if yPos <= 5 or yPos >= 16 then
				if vrijCheckGeenMirror(xPos, yPos) == true then
					table.insert(stealthTabel, #stealthTabel+1, {xPos, yPos})
				end
			end		
		end
	end

	if #stealthTabel >= 1 then
		local keuze = math.ceil(worldGetRandom() * #stealthTabel)
		xPos = stealthTabel[keuze][1]
		yPos = stealthTabel[keuze][2]
		terrainLayoutResult[xPos][yPos].terrainType = stealth
	end
end

--Markt
MirrorPlaatsing(1, 4, markt)

terrainLayoutResult[8][10].terrainType = tt_player_start_classic_plains_low_trees_no_deer
terrainLayoutResult[8][10].playerIndex = 0  


terrainLayoutResult[20][10].terrainType = tt_player_start_classic_plains_low_trees_no_deer
terrainLayoutResult[20][10].playerIndex = 1



if rotatie == 1 then
	terrainLayoutResult = rotate_CCW_90(terrainLayoutResult)
elseif rotatie == 2 then
	terrainLayoutResult = rotate_CW_90(terrainLayoutResult)
elseif rotatie == 3 then
	terrainLayoutResult = rotate_180(terrainLayoutResult)
end



