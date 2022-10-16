--Teutonic Pass created by Adne of the DR.
print("Teutonic Pass created by Adne of the DR.")


n = tt_none 
tijdelijk = tt_flatland
heuvel = tt_hills
heuvel2 = tt_hills_gentle_rolling_clearing
grond = tt_plains
grond2 = tt_trees_plains_clearing
vis = tt_lake_shallow_hill_fish
--bomen = tt_impasse_trees_hills
bomen = tt_impasse_trees_plains_forest
relic = tt_relic_spawner
wolf = tt_wolf_spawner
berg = tt_impasse_mountains
dal = tt_ocean_deep
markt = tt_settlement_plains


gridHeight, gridWidth, gridSize = SetCustomCoarseGrid(20)

terrainLayoutResult = SetUpGrid(gridSize, n, terrainLayoutResult)

middenPunt =  math.ceil(gridSize/2)	
mirror = math.ceil(worldGetRandom() *2)
rotatie = math.ceil(worldGetRandom() * 4)	

function MirrorPlaatsing(xPos, yPos, ttType)
	if xPos <= gridSize and yPos <= gridSize and xPos >= 1 and yPos >= 1 then
		terrainLayoutResult[xPos][yPos].terrainType = ttType
	end
	if gridSize+1-xPos <= gridSize and gridSize+1-yPos <= gridSize and gridSize+1-xPos >= 1 and gridSize+1-yPos >= 1 then
		terrainLayoutResult[gridSize+1-xPos][gridSize+1-yPos].terrainType = ttType
	end
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function Spiegelen()
	local terrainLayoutResultMirror = {}
	terrainLayoutResultMirror = deepcopy(terrainLayoutResult)
	for xPos = 1, gridSize do
		for yPos = 1, gridSize do
			if yPos < middenPunt then
				terrainLayoutResult[gridSize+1-xPos][yPos].terrainType = terrainLayoutResultMirror[xPos][yPos].terrainType
			elseif yPos > middenPunt then
				terrainLayoutResult[xPos][yPos].terrainType = terrainLayoutResultMirror[gridSize+1-xPos][yPos].terrainType 
			end
		end
	end
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




--Start bergen
bergKans = 0.3
for yPos = middenPunt, middenPunt+4 do
	if yPos < middenPunt+4 then
		MirrorPlaatsing(middenPunt-2, yPos, bomen)
	end
	if yPos >= middenPunt+1 then
		if worldGetRandom() < bergKans then
			MirrorPlaatsing(middenPunt-3, yPos, berg)
			bergKans = bergKans-0.15
		elseif worldGetRandom() < bergKans then
			MirrorPlaatsing(middenPunt-3, yPos, heuvel)
			bergKans = bergKans-0.05
		elseif worldGetRandom() < bergKans-0.1 then
			MirrorPlaatsing(middenPunt-1, yPos, berg)	
			bergKans = bergKans-0.25
		end
	end
end

for xPos = middenPunt-2, middenPunt+2 do
	terrainLayoutResult[xPos][middenPunt].terrainType = berg
	terrainLayoutResult[xPos][middenPunt+1].terrainType = bomen
	terrainLayoutResult[xPos][middenPunt-1].terrainType = bomen
end



if worldGetRandom() < 0.5 then
	MirrorPlaatsing(middenPunt, middenPunt+4, dal)
end

passagePunt = 6 + math.ceil(worldGetRandom() * 3)
if middenPunt+passagePunt < gridSize then
	MirrorPlaatsing(middenPunt+2, middenPunt-passagePunt, heuvel)
end


for xPos = middenPunt-6, middenPunt-5 do
	MirrorPlaatsing(xPos, middenPunt-6, heuvel2)
end


visstartX = 2 + math.ceil(worldGetRandom() * 2)
visstartY = middenPunt + 2 + math.ceil(worldGetRandom() * 3)
visX = visstartX
visY = visstartY
visTabel = {}

function visplaatsing()
	table.insert(visTabel, #visTabel+1, {6, 14})	
	if worldGetRandom() < 0.5 then
		table.insert(visTabel, #visTabel+1, {8, 17})	
	else
		table.insert(visTabel, #visTabel+1, {7, 17})	
	end	
	if worldGetRandom() < 0.5 then
		table.insert(visTabel, #visTabel+1, {4, 19})	
	else
		table.insert(visTabel, #visTabel+1, {3, 19})
	end		
	
	table.insert(visTabel, #visTabel+1, {6, 16})		
	table.insert(visTabel, #visTabel+1, {4, 16})	
	table.insert(visTabel, #visTabel+1, {6, 18})	
	table.insert(visTabel, #visTabel+1, {8, 18})
	table.insert(visTabel, #visTabel+1, {4, 18})	
	table.insert(visTabel, #visTabel+1, {5, 17})	
	table.insert(visTabel, #visTabel+1, {10, 16})		
end

visplaatsing()
visplaatsingShuffled = {}
for i = 1, 6 do
		visVerwijder = math.ceil(worldGetRandom() * #visTabel)
		table.insert(visplaatsingShuffled, #visplaatsingShuffled+1, visTabel[visVerwijder])	
		table.remove(visTabel, visVerwijder)
end


MirrorPlaatsing(visplaatsingShuffled[1][1], visplaatsingShuffled[1][2], vis)
MirrorPlaatsing(visplaatsingShuffled[2][1], visplaatsingShuffled[2][2], vis)
MirrorPlaatsing(visplaatsingShuffled[3][1], visplaatsingShuffled[3][2], vis)
MirrorPlaatsing(visplaatsingShuffled[4][1], visplaatsingShuffled[4][2], vis)
MirrorPlaatsing(visplaatsingShuffled[5][1], visplaatsingShuffled[5][2], vis)
MirrorPlaatsing(visplaatsingShuffled[6][1], visplaatsingShuffled[6][2], tt_berries_gold_small)

--Fruit
function Fruit(i)
	fruitsoort = i
	fruitTabel = {}
	table.insert(fruitTabel, #fruitTabel+1, heuvel2)	
	if fruitsoort == 1 then
		table.insert(fruitTabel, #fruitTabel+1, bomen)	
		table.insert(fruitTabel, #fruitTabel+1, heuvel)	
	elseif fruitsoort == 2 then
		table.insert(fruitTabel, #fruitTabel+1, tt_berries_gold_small)	
		table.insert(fruitTabel, #fruitTabel+1, tt_holy_site_hill)
	elseif fruitsoort == 3 then
		table.insert(fruitTabel, #fruitTabel+1, tt_tactical_region_gold_plains_c)	
		table.insert(fruitTabel, #fruitTabel+1, grond)	
	else
		table.insert(fruitTabel, #fruitTabel+1, tt_berries_gold_small)	
		table.insert(fruitTabel, #fruitTabel+1, tt_pocket_berries)	
	end
	


	fruitTabelShuffle = {}
	for i = 1, #fruitTabel do
		fruitVerwijder = math.ceil(worldGetRandom() * #fruitTabel)
		table.insert(fruitTabelShuffle, #fruitTabelShuffle+1, fruitTabel[fruitVerwijder])	
		table.remove(fruitTabel, fruitVerwijder)
	end
end



Fruit(1)

MirrorPlaatsing(4, 3, fruitTabelShuffle[1])
MirrorPlaatsing(2, 3, fruitTabelShuffle[2])
MirrorPlaatsing(3, 5, fruitTabelShuffle[3])
MirrorPlaatsing(5, 1, fruitTabelShuffle[4])

for i = 1, 4 do
	print("FruitTabel")
	print(fruitTabelShuffle[i])
end

MirrorPlaatsing(1, 1, berg)
MirrorPlaatsing(2, 1, berg)
MirrorPlaatsing(1, 2, berg)
if worldGetRandom() < 0.5 then
	MirrorPlaatsing(1, 3, berg)
	MirrorPlaatsing(3, 1, bomen)
	MirrorPlaatsing(4, 1, bomen)
else
	MirrorPlaatsing(3, 1, berg)
	MirrorPlaatsing(1, 3, bomen)
	MirrorPlaatsing(1, 4, bomen)
end

MirrorPlaatsing(1, 6+(math.ceil(worldGetRandom() * 2)), bomen)
MirrorPlaatsing(5, 9+(math.ceil(worldGetRandom() * 2)), bomen)
	
Fruit(2)
tweedeFruitY = middenPunt-1+math.ceil(worldGetRandom() * 2)
MirrorPlaatsing(3, tweedeFruitY+1, fruitTabelShuffle[1])
MirrorPlaatsing(1, tweedeFruitY+1, fruitTabelShuffle[2])
MirrorPlaatsing(1, tweedeFruitY+3, fruitTabelShuffle[3])
MirrorPlaatsing(3, tweedeFruitY+3, fruitTabelShuffle[4])
MirrorPlaatsing(2, tweedeFruitY+2, heuvel2)


Fruit(3)
derdeFruitY = 1
MirrorPlaatsing(middenPunt+2, derdeFruitY, fruitTabelShuffle[1])
MirrorPlaatsing(middenPunt, derdeFruitY, fruitTabelShuffle[2])
MirrorPlaatsing(middenPunt, derdeFruitY+2, fruitTabelShuffle[3])
MirrorPlaatsing(middenPunt+2, derdeFruitY+2, fruitTabelShuffle[4])
MirrorPlaatsing(middenPunt+1, derdeFruitY+1, heuvel2)
MirrorPlaatsing(gridSize-1, 1, bomen)

MirrorPlaatsing(1, 7+(math.ceil(worldGetRandom() * 2)), bomen)
	
--Relics


if (worldGetRandom() < 0.5) then
	if 	terrainLayoutResult[middenPunt+4][middenPunt+3].terrainType ~= bomen then
		MirrorPlaatsing(6, 1, relic)
		print("R1 1")
	else
		MirrorPlaatsing(7, 1, relic)	
		print("R1 2")
	end
else
	MirrorPlaatsing(7, 1, relic)	
	print("R1 2")
end

--[[
if (worldGetRandom() < 0.5) then
	MirrorPlaatsing(5, 12, relic)
	print("R2 1")
else
	MirrorPlaatsing(1, 18, relic)	
	print("R2 2")
end]]--
	
if (worldGetRandom() < 0.5) then
	MirrorPlaatsing(15, 1, relic)
	print("R3 1")
else
	MirrorPlaatsing(17, 1, relic)	
	print("R3 2")
end



if worldGetRandom() < 0.5 then
	MirrorPlaatsing(9, 4, berg)
	if worldGetRandom() < 0.5 then
		MirrorPlaatsing(9, 3, berg)
	else
		MirrorPlaatsing(9, 5, berg)		
	end
else
	MirrorPlaatsing(8, 4, berg)
	if worldGetRandom() < 0.5 then
		MirrorPlaatsing(7, 4, berg)
	else
		MirrorPlaatsing(8, 3, berg)
	end
end

MirrorPlaatsing(1, 18, markt)	

print("Relic locaties")
for xPos = 1, gridSize do
	for yPos = 1, gridSize do
		if terrainLayoutResult[xPos][yPos].terrainType == relic then
			print(xPos, yPos)
		end
	end
end

if mirror == 2 then
	Spiegelen()
end


if mirror ~= 2 then
	terrainLayoutResult[middenPunt-4][middenPunt-3].terrainType = tt_player_start_classic_plains_no_trees
	terrainLayoutResult[middenPunt-4][middenPunt-3].playerIndex = 0  
	terrainLayoutResult[middenPunt+4][middenPunt+3].terrainType = tt_player_start_classic_plains_no_trees
	terrainLayoutResult[middenPunt+4][middenPunt+3].playerIndex = 1
else
	terrainLayoutResult[middenPunt+4][middenPunt-3].terrainType = tt_player_start_classic_plains_no_trees
	terrainLayoutResult[middenPunt+4][middenPunt-3].playerIndex = 0  
	terrainLayoutResult[middenPunt-4][middenPunt+3].terrainType = tt_player_start_classic_plains_no_trees
	terrainLayoutResult[middenPunt-4][middenPunt+3].playerIndex = 1
end


if rotatie == 1 then
	terrainLayoutResult = rotate_CCW_90(terrainLayoutResult)
elseif rotatie == 2 then
	terrainLayoutResult = rotate_CW_90(terrainLayoutResult)
elseif rotatie == 3 then
	terrainLayoutResult = rotate_180(terrainLayoutResult)
end


