### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ f0253250-b17d-11eb-372f-bbbd03ee7cfb
using NativeSVG

# ╔═╡ 012cf010-b17e-11eb-1316-e1cdffba1b97
using PlutoUI

# ╔═╡ 405d1707-72da-44ae-ae23-154d37b20357
include("Puzzlelist.jl")

# ╔═╡ bfb7e2be-b1d2-11eb-018e-712f9a0a95a2
md"# Palisade"

# ╔═╡ c55850c0-b1d2-11eb-36c8-2f441aa159e9
md"    SGT KBO VAN VAERENBERGH Emile
	SGT KBO BOUCHEZ Cloë
	SGT KBO VAN RIET Pieterjan"

# ╔═╡ d1c5d360-b276-11eb-1d5b-f11e27221dad
md"## Game setup"

# ╔═╡ c5d0a1d4-4e93-40e7-9eb4-0347a1fb0dc6
md" Welcome player!
Palisade is a logic game for one player.
The goal is to divide the grid into regions of a given size.
These are the rules:

	- A black edge means 'Active'
	- A yellow edge means 'Undecided'
	- A grey edge means 'Passive'

A box with a number specifies the number of needed 'Active' / black edges.

A region cannot be larger or smaller than the required region size.

Good luck!"

# ╔═╡ 580af820-b186-11eb-3083-7fc1e247cb1b
md" Select your grid"

# ╔═╡ 19cd1710-b185-11eb-0b12-f912b4360d59
@bind Gridsize Select(["5 x 5" , "8 x 6" , "10 x 8", "15 x 12", "Custom", "Test"])

# ╔═╡ 3a8a33ce-b247-11eb-294e-af65126e69f4
md"If you want a custom sized grid, select 'Custom' and enter your dimensions below."

# ╔═╡ 5609ff50-b247-11eb-3962-e7d25830ec2b
md" Number of rows"

# ╔═╡ 60ca1290-b247-11eb-0f8f-21dd1311e609
@bind Customrow Select(["1" , "2" , "3" , "4" , "5" , "6" , "7" , "8" , "9" , "10"])

# ╔═╡ dabc6020-b248-11eb-0dea-996cec2b1742
md"Number of columns"

# ╔═╡ d25afd60-b248-11eb-33c1-a76ecee59e69
@bind Customcolumn Select(["1" , "2" , "3" , "4" , "5" , "6" , "7" , "8" , "9" , "10"])

# ╔═╡ a0c2c696-fb22-44c9-a9ca-a22e7a50ebaa
md" Click this button to start a new game"

# ╔═╡ 8608cbc3-327c-4159-abf9-b7fe84a275c2
@bind submit Button()

# ╔═╡ e1713572-b276-11eb-2841-017e12e863d3
md"## Play the game!"

# ╔═╡ da15ea92-b1d2-11eb-1a30-0d40c2d12b53
md" Choose the row"

# ╔═╡ e63e6772-b1d2-11eb-30e7-9379f57316a5
md"Choose the column"

# ╔═╡ f15c0400-b1d2-11eb-0c72-f7ca2c8a28c2
md"Choose the edge"

# ╔═╡ f73ed230-b1d2-11eb-2460-1bd8cc839ef8
@bind Edgeselec Select([ "Down" , "Right" , "Up" , "Left" ])

# ╔═╡ fbd4d510-b1d2-11eb-2ed7-55caa10de146
md"Choose the color"

# ╔═╡ ff3f7750-b1d2-11eb-1713-df70f9da245a
@bind Colorselec Select(["Yellow" , "Black" , "Grey"])

# ╔═╡ 036c0a00-b1d3-11eb-3b44-1b84d2ed450d
md" Tick the box to execute your move, turn it off afterwards."

# ╔═╡ 08124b00-b24b-11eb-0f7b-7f5ed32110f1
@bind nextstep CheckBox()

# ╔═╡ 14bdf9a0-6e24-44fa-b3d3-85e465fce684
md" Click this button to solve the game via a bot"

# ╔═╡ d0dccaed-9b37-461a-9e88-c38961a3757b
@bind activatebot CheckBox()

# ╔═╡ 63e1c260-b964-11eb-153c-05fbc821a8f9
md"# General"

# ╔═╡ de074d4e-e570-4e1e-aa0b-0ed32d09b9f2
md"## The Bot"

# ╔═╡ 349ee2c0-b67c-11eb-372c-497a82d46489
md"##### one time checks"

# ╔═╡ 8974bf4e-b964-11eb-3ca7-f16de054f17c
md"##### Dynamic checks"

# ╔═╡ 295ba740-b965-11eb-36ce-a1a294e39999
md"###### Hypothesefunctions"

# ╔═╡ 4b23235f-6d04-4861-a143-8ead80b43d2f
md"### Gridfunctions"

# ╔═╡ 66293d16-4081-46ff-9f0c-417c85ada048
md"### Other functions"

# ╔═╡ 3f499980-bd30-11eb-1ba7-a398aa4adc69
function create_a_random_puzzle(CUSTOMROW,CUSTOMCOLUMN)
	#CUSTOMROW = parse(Int64, Customrow)
	#CUSTOMCOLUMN =parse(Int64, Customcolumn)
	possibilities = ("-3","-2", "-1", "1" , "2" , "3")
	Empty_matrix = fill("" , CUSTOMROW , CUSTOMCOLUMN)
	for i in 1 : CUSTOMROW
		for j in 1 : CUSTOMCOLUMN
			Empty_matrix[i , j] = rand(possibilities)
		end
	end
	for i in 1 : CUSTOMROW
		for j in 1 : CUSTOMCOLUMN
			if Empty_matrix[i , j] == "-1"|| Empty_matrix[i , j] == "-2" || Empty_matrix[i , j] == "-3" || Empty_matrix[1 , 1 ] == "1" || Empty_matrix[1 , CUSTOMCOLUMN] == "1" || Empty_matrix[CUSTOMROW , 1 ] == "1" || Empty_matrix[CUSTOMROW , CUSTOMCOLUMN ] == "1" || Empty_matrix[i , 1] == "0" || Empty_matrix[i , CUSTOMCOLUMN] == "0" || Empty_matrix[1 , j] == "0" || Empty_matrix[CUSTOMROW , j] == "0"
				Empty_matrix[i , j] = ""
			end
		end
	end
	Possible_game = Empty_matrix
	return Possible_game
end

# ╔═╡ cce1b9d0-c91a-11eb-168d-bdf22d5d6b06
Testpuzzle = ["" "" "" "" "" 
"" "" "" "" "" 
"" "" "" "" "" 
"" "" "" "" "" 
"" "" "" "" "" ]

# ╔═╡ 58cb0940-b185-11eb-229e-a9f512b455b0
function infocollect()
	submit
	if Gridsize == "5 x 5"
		global rows = 5
		global columns = 5
		global region = 5
		global (puzzle , Sol) = rand(Puzzles_5x5_Dict)
	end
	if Gridsize == "8 x 6"
		global rows = 6
		global columns = 8
		global region = 6
		global puzzle = fill( "" , 6 , 8)
	end
	if Gridsize == "10 x 8"
		global rows = 8
		global columns = 10
		global region = 8
		global puzzle = fill( "" , 8 , 10)
	end
	if Gridsize == "15 x 12"
		global rows = 12
		global columns = 15
		global region = 10
		global puzzle = fill( "" , 12 , 15)
	end
	if Gridsize =="Custom"
		global rows = parse(Int64, Customrow)
		global columns = parse(Int64, Customcolumn)
		global region = (parse(Int64, Customrow) * parse(Int64 , Customcolumn)) / maximum([parse(Int64, Customrow) , parse(Int64 , Customcolumn)])
		global puzzle = fill("",parse(Int64,"$Customrow"),parse(Int64,"$Customcolumn"))
	end
	if Gridsize == "Custom"
		if Customrow == "5"
			if Customcolumn == "8"
				global rows = 5
				global columns = 8
				global region = 5
				global puzzle = puzzle_5x8
			end
		end
	end
	if Gridsize == "Test"
		global rows = 5
		global columns = 5
		global region = 5 
		global puzzle = Testpuzzle
	end
end

# ╔═╡ fb7e0980-b185-11eb-1bc8-1919e5821fb8
infocollect()

# ╔═╡ 643ceae2-b186-11eb-0f69-47102d6f1ea6
md" Your region size is $region"

# ╔═╡ 10205112-b260-11eb-143e-579c85416a64
function printnumbers()
	for ii in 1:rows
		for jj in 1:columns
			if puzzle[ii,jj] == ""
				continue
			else
				g(font_size = "50", font_family = "Verdana") do
					text(x = (jj-1)*100 + 45, y = (ii-1)*100 +75) do
						str(puzzle[ii,jj])
					end
				end
			end
		end
	end
end

# ╔═╡ 7399876f-a48f-4e22-98ba-ace50e4cc65a
function create_numberofblackedges(HOR , VER)
	numberofblackedges = fill("", rows, columns)
	#gridedge
	for ii in 1:rows
		numberofblackedges[ii, 1]  = "R"
		numberofblackedges[ii, columns]  = "R"
		for jj in 2:columns-1
			numberofblackedges[1, jj] = "D"
			numberofblackedges[ii, jj] = ""
			numberofblackedges[rows, jj] = "D"
		end
	end 
	#corners
	numberofblackedges[1, columns]  = numberofblackedges[1, columns]*"D"
	numberofblackedges[1, 1]  = numberofblackedges[1, 1]*"D"
	numberofblackedges[rows, 1]  = numberofblackedges[rows, 1]*"D"
	numberofblackedges[rows, columns]  = numberofblackedges[rows, columns]*"D" 
	#general
	for ii in 2:rows  
		for jj in 2:columns
			if HOR[ii, jj] == "B"
				numberofblackedges[ii, jj] = numberofblackedges[ii, jj]*"D"
				numberofblackedges[ii-1, jj] = numberofblackedges[ii-1, jj]*"D"
			end
		end
	end
	for ii in 2:rows  
		for jj in 2:columns
			if VER[ii, jj] == "B"
				numberofblackedges[ii, jj] = numberofblackedges[ii, jj]*"R"
				numberofblackedges[ii, jj-1] = numberofblackedges[ii, jj-1]*"R"
			end
		end
	end
	#for row 1
	for jj in 1:columns-1
		if VER[1,jj+1] == "B"
			numberofblackedges[1, jj] = numberofblackedges[1, jj]*"R"
			numberofblackedges[1, jj+1] = numberofblackedges[1, jj+1]*"R"
		end
	end
	#for column 1
	for ii in 1:rows-1
		if HOR[ii+1,1] == "B"
			numberofblackedges[ii,1] = numberofblackedges[ii,1]*"D"
			numberofblackedges[ii+1,1] = numberofblackedges[ii+1,1]*"D"
		end
	end
	for ii in 1:rows
		for jj in 1:columns
			number = length(numberofblackedges[ii, jj])
			numberofblackedges[ii, jj] = "$number"
		end
	end
	return numberofblackedges
end

# ╔═╡ 13efda23-db35-4616-8dd3-beaef126d975
function create_numberofgreyedges(HOR , VER)
	numberofgreyedges = fill("", rows, columns)
	#general
	for ii in 2:rows  
		for jj in 2:columns
			if HOR[ii, jj] == "G"
				numberofgreyedges[ii, jj] = numberofgreyedges[ii, jj]*"D"
				numberofgreyedges[ii-1, jj] = numberofgreyedges[ii-1, jj]*"D"
			end
		end
	end
	for ii in 2:rows  
		for jj in 2:columns
			if VER[ii, jj] == "G"
				numberofgreyedges[ii, jj] = numberofgreyedges[ii, jj]*"R"
				numberofgreyedges[ii, jj-1] = numberofgreyedges[ii, jj-1]*"R"
			end
		end
	end
	#for row 1
	for jj in 1:columns-1
		if VER[1,jj+1] == "G"
			numberofgreyedges[1, jj] = numberofgreyedges[1, jj]*"R"
			numberofgreyedges[1, jj+1] = numberofgreyedges[1, jj+1]*"R"
		end
	end
	#for column 1
	for ii in 1:rows-1
		if HOR[ii+1,1] == "G"
			numberofgreyedges[ii,1] = numberofgreyedges[ii,1]*"D"
			numberofgreyedges[ii+1,1] = numberofgreyedges[ii+1,1]*"D"
		end
	end
	for ii in 1:rows
		for jj in 1:columns
			number = length(numberofgreyedges[ii, jj])
			numberofgreyedges[ii, jj] = "$number"
		end
	end
	return numberofgreyedges
end

# ╔═╡ 866f9440-b1d2-11eb-391e-abaa0c424efe
function knots()
	for n in 0:columns-2
			for j in 0:rows-2
				g(fill = "red", stroke = "none") do
					rect( x =108.5+n*100 , y = 108.5+j*100 , width = 3 , height = 3)
				end
			end
		end
		for nn in 0:columns - 1
			for jj in 0:rows - 1
				g(fill = "Black", stroke = "none") do
					rect( x = 8.5 + nn * 100 , y = 9 , width = 3 , height = 2.2)
				end
				g(fill = "Black", stroke = "none") do
					rect( x = 9 , y =8.5 + jj * 100 , width = 2.2 , height = 3)
				end
				g(fill = "Black", stroke = "none") do
					rect(x=8.5+nn *100,y=8.5+rows*100 , width = 2.5 , height = 2.5)
				end
				g(fill = "Black", stroke = "none") do
					rect(x=8.5+columns*100,y=8.5+jj*100 , width = 2.5 , height = 2.5)
				end
			end
		end
end

# ╔═╡ 8831ef40-b186-11eb-145a-df5c1a00c256
function create_hor_edg()
	#Dit is een row +1, column array
	hor_edg = fill("",rows + 1, columns)
	for i in 1 : columns
		hor_edg[1 , i] = hor_edg[1 , i] * "B"
		hor_edg[rows + 1 , i] = hor_edg[rows + 1 , i] * "B"
	end
	for i in 2 : rows
		for j in 1 : columns
		hor_edg[i , j] = hor_edg[i , j] * "Y"
		end
	end
	return hor_edg
end

# ╔═╡ 934a82c0-b186-11eb-39b7-ef349142f77e
hor_edg = create_hor_edg()

# ╔═╡ 492e9450-b1d2-11eb-37f9-f3a502ac50e9
function printhor()
		for i in 1 : rows + 1
			for j in 1 : columns
				if hor_edg[i , j] == "Y"
					g(fill = "rgb(100.0%,100.0%,20.0%)", stroke = "rgb(100.0%,100.0%,20.0%)", stroke_width = "3") do
						line(x1=10+(j-1)*100, y1=10+(i-1)*100 , x2=10+j*100, y2=10+(i-1)*100)	
					end
				end
			end
		end
		for i in 1 : rows + 1
			for j in 1 : columns
				if hor_edg[i , j] == "B"
					g(fill = "rgb(0%,0%,0%)", stroke = "rgb(0%,0%,0%)", stroke_width = "3") do
						line(x1=10+(j-1)*100, y1=10+(i-1)*100 , x2=10+j*100, y2=10+(i-1)*100)	
					end
				end
			end
		end
		for i in 1 : rows + 1
			for j in 1 : columns
				if hor_edg[i , j] == "G"
					g(fill = "rgb(96%,96%,96%)", stroke = "rgb(96%,96%,96%)", stroke_width = "1.5") do
						line(x1=10+(j-1)*100, y1=10+(i-1)*100 , x2=10+j*100, y2=10+(i-1)*100)	
					end
				end
			end
		end
		for i in 1 : rows + 1
			for j in 1 : columns
				if hor_edg[i , j] == "R"
					g(fill = "rgb(100%,0.03%,0%)", stroke = "rgb(100%,0.03%,0%)", stroke_width = "3") do
						line(x1=10+(j-1)*100, y1=10+(i-1)*100 , x2=10+j*100, y2=10+(i-1)*100)	
					end
				end
			end
		end
end

# ╔═╡ f3fa59b9-8723-495f-a3bb-7f3afe20c86a
function create_blackedgeshor()
	blackedgeshor = fill("" , rows + 1 , columns)
	for i in 1 : rows + 1
		for j in 1 : columns
			if hor_edg[ i , j ] == "B"
				blackedgeshor[ i , j ] = "B"
			end
		end
	end
	return blackedgeshor
end

# ╔═╡ 08e276e0-b188-11eb-2251-ef9a8d1304f4
function create_ver_edg()
	#Dit is een row , column + 1array
	ver_edg = fill("" , rows , columns + 1)
	for i in 1 : rows
		ver_edg[i , 1] = ver_edg[i , 1] * "B"
		ver_edg[i , columns + 1] = ver_edg[i , columns + 1] * "B"
	end
	for i in 1 : rows
		for j in 2 : columns
		ver_edg[i , j] = ver_edg[i , j] * "Y"
		end
	end
	return ver_edg
end

# ╔═╡ 2b8a88e0-b188-11eb-377b-6546773fda30
ver_edg = create_ver_edg()

# ╔═╡ 43e90cb6-f772-4375-be75-a597650dbffe
function CHECKZERO()
    for ii in 1:rows
        if puzzle[ii , 1] == "0" || puzzle[ii , columns] == "0"
           error("This puzzle is not solvable")
        end
    end
    for jj in 1:columns
		if puzzle[1 , jj] == "0" || puzzle[rows , jj] == "0"
        	error("This puzzle is not solvable")
    end
    for ii in 2: rows - 1
        for jj in 2: columns - 1
            if puzzle[ii , jj] == "0"
                hor_edg[ii , jj] = "G" 
				hor_edg[ii + 1 , jj] = "G"
				ver_edg[ii , jj] = "G"
				ver_edg[ii , jj + 1] = "G"
				end
            end
        end
    end
end

# ╔═╡ 1653dc53-7232-4e3e-aba7-b0cf8ae7ce11
function CHECKONE()
	if puzzle[1 , 1] == "1" || puzzle[1 , columns] == "1" || puzzle[rows , 1] == "1"|| puzzle[rows, columns] == "1"
		error("This puzzle is not solvable")
    end
    for ii in 2:(rows - 1)
        if puzzle[ii , 1] == "1"
            hor_edg[ii+1,1] = "G"
			hor_edg[ii , 1] = "G"
			ver_edg[ii , 2] = "G"
		end
		if puzzle[ii , columns] == "1"
			hor_edg[ii , columns] = "G"
			hor_edg[ii + 1 , columns] = "G"
			ver_edg[ii , columns] = "G"
		end
    end
    for jj in 2:(columns - 1)
        if puzzle[1 , jj] == "1"
			ver_edg[1 , jj] = "G"
			ver_edg[1 , jj + 1] = "G"
			hor_edg[2 , jj ] = "G"
		end
		if puzzle[rows , jj] == "1"
			ver_edg[rows , jj] = "G"
			ver_edg[rows , jj + 1] = "G"
			hor_edg[rows , jj ] = "G"
		end
    end
end

# ╔═╡ 5c6d3943-90ca-44f5-bab1-8fc4e7c43dbc
function CHECKTWO()
    if puzzle[1,1] == "2"
        hor_edg[2,1] = "G"
		ver_edg[1 , 2] = "G"
	end
	if puzzle[1 , columns] == "2"
		hor_edg[2,columns] = "G"
		ver_edg[1,columns] = "G"
	end
	if puzzle[rows , 1] == "2"
		hor_edg[rows , 1] = "G"
		ver_edg[rows , 2] = "G"
	end
	if puzzle[rows , columns] == "2"
		hor_edg[rows , columns] = "G"
		ver_edg[rows , columns] = "G"
	end
end

# ╔═╡ 99ca0e09-0054-4c16-831b-e2487c62e548
function CHECKTREE()
    for ii in 1:rows
        for jj in 1:columns
            if puzzle[ii,jj] == "3"
                if ii != rows && puzzle[ii,jj] == puzzle[ii+1,jj]
					hor_edg[ii + 1 , jj] = "B"
                elseif jj != columns && puzzle[ii,jj] == puzzle[ii,jj+1]
					ver_edg[ii , jj + 1] = "B"
                end
            end
        end
    end
end

# ╔═╡ df6095a0-b6ef-11eb-3c99-2de8057496ff
function diagonal_two_one_corners()
	#EENMAAL IN HET BEGIN
	if Gridsize == "5 x 5"
		if puzzle[1 , 1] == "2" && puzzle[2 , 2] == "1"
			hor_edg[3 , 1] = "B"
			ver_edg[3 , 1] = "B"
		elseif puzzle[rows , 1] == "2" && puzzle[rows - 1 , 2] == "1"
			hor_edg[rows - 1 , 1] = "B"
			ver_edg[rows , 3] = "B"
		elseif puzzle[1 , columns] == "2" && puzzle[2 , columns - 1] == "1"
			hor_edg[3 , columns] = "B"
			ver_edg[1 , columns - 1] = "B"
		elseif puzzle[rows , columns] == "2" && puzzle[rows - 1 , columns - 1] == "1"
			hor_edg[rows - 1 , columns] = "B"
			ver_edg[rows , columns - 1] = "B"
		end
	end
end

# ╔═╡ 2c59aff0-b73f-11eb-326d-cb60a5f4b687
function initial_bot()
	CHECKZERO()
	CHECKONE()
	CHECKTWO()
	CHECKTREE()
	diagonal_two_one_corners()
end

# ╔═╡ c9982d9c-1f03-4e41-ae34-c96783c25900
function diagonal_one_grey_sides()
 	#Rechtsonder
    for ii in 1:rows - 1
        for jj in 1:columns - 1
            if puzzle[ii,jj] == "1"
				if hor_edg[ii + 1 , jj + 1] == "G" && ver_edg[ii + 1 , jj + 1] == "G"
					hor_edg[ii + 1 , jj] = "G"
					ver_edg[ii , jj + 1] = "G"
                end
            end
        end
    end
	#rechtsboven
    for ii in 2 : rows
        for jj in 1 : columns - 1
            if puzzle[ii , jj] == "1"
				if hor_edg[ii , jj + 1] == "G" && ver_edg[ii - 1 , jj + 1] == "G"
					hor_edg[ii , jj] = "G"
					ver_edg[ii , jj + 1] = "G"
				end
			end
		end
	end
	#linksboven
	for ii in 2: rows
         for jj in 2: columns
             if puzzle[ii,jj] == "1"
				if hor_edg[ii , jj-1] == "G" && ver_edg[ii - 1 , jj ] == "G"
					hor_edg[ii , jj] = "G"
					ver_edg[ii , jj] = "G"
				end
			end
		end
	end
	#linksonder
	for ii in 1 : rows - 1
		for jj in 2 : columns
			if puzzle[ii , jj] == "1"
				if hor_edg[ii + 1 , jj - 1] == "G" && ver_edg[ii + 1, jj] == "G"
					hor_edg[ii + 1 , jj] = "G"
					ver_edg[ii , jj] = "G"
				end
			end
		end
	end
end

# ╔═╡ 850ef840-f1e9-490e-a3dd-291442e5be44
function diagonal_three_grey_sides()
    #Rechtsonder
    for ii in 1:rows - 1
        for jj in 1:columns - 1
            if puzzle[ii,jj] == "3"
				if hor_edg[ii + 1 , jj + 1] == "G" && ver_edg[ii + 1 , jj + 1] == "G"
					hor_edg[ii + 1 , jj] = "B"
					ver_edg[ii , jj + 1] = "B"
                end
            end
        end
    end
	#rechtsboven
    for ii in 2 : rows
        for jj in 1 : columns - 1
            if puzzle[ii , jj] == "3"
				if hor_edg[ii , jj + 1] == "G" && ver_edg[ii - 1 , jj + 1] == "G"
					hor_edg[ii , jj] = "B"
					ver_edg[ii , jj + 1] = "B"
				end
			end
		end
	end
	#linksboven
	for ii in 2: rows
         for jj in 2: columns
             if puzzle[ii,jj] == "3"
				if hor_edg[ii , jj-1] == "G" && ver_edg[ii - 1 , jj ] == "G"
					hor_edg[ii , jj] = "B"
					ver_edg[ii , jj] = "B"
				end
			end
		end
	end
	#linksonder
	for ii in 1 : rows - 1
		for jj in 2 : columns
			if puzzle[ii , jj] == "3"
				if hor_edg[ii + 1 , jj - 1] == "G" && ver_edg[ii + 1, jj] == "G"
					hor_edg[ii + 1 , jj] = "B"
					ver_edg[ii , jj] = "B"
				end
			end
		end
	end
end

# ╔═╡ b46cd320-b6ec-11eb-28ed-df92b7a6d9d6
function Grey_cross()
    for ii in 1 : rows - 1
        for jj in 1 : columns - 1
			if hor_edg[ii + 1 , jj] == "G" && hor_edg[ii + 1, jj + 1] == "G" && ver_edg[ii, jj + 1 ] == "G"
				ver_edg[ii + 1 , jj + 1] = "G" 
			end
			if hor_edg[ii + 1 , jj] == "G" && hor_edg[ii + 1, jj + 1] == "G" && ver_edg[ii + 1, jj + 1 ] == "G"
				ver_edg[ii  , jj + 1] = "G" 
			end
			if ver_edg[ii , jj + 1] == "G" && ver_edg[ii + 1 , jj + 1] == "G" && hor_edg[ii + 1 , jj] == "G"
				hor_edg[ii + 1 , jj + 1] = "G"
			end
			if ver_edg[ii , jj + 1] == "G" && ver_edg[ii + 1 , jj + 1] == "G" && hor_edg[ii + 1 , jj + 1] == "G"
				hor_edg[ii + 1 , jj] = "G"
			end
		end
	end
end


# ╔═╡ c220eeb0-b710-11eb-3b71-a1a484ba7ae7
function only_path()
	for i in 1 : rows - 1
		for j in 1 : columns - 1
			#L_R_GREY
			if hor_edg[i + 1 , j] == "G" && hor_edg[i + 1 , j + 1] == "G"
				if ver_edg[i , j + 1] == "B"
					ver_edg[i + 1 , j + 1] = "B"
				end
				if ver_edg[i + 1 , j + 1] == "B"
					ver_edg[i , j + 1] = "B"
				end
			end
			#B_O_GREY
			if ver_edg[i , j + 1] == "G" && ver_edg[i + 1, j + 1] == "G"
				if hor_edg[i + 1 , j] == "B"
					hor_edg[i + 1 , j + 1] = "B"
				end
				if hor_edg[i + 1, j + 1] == "B"
					hor_edg[i + 1 , j] = "B"
				end
			end
			#L_B_GREY
			if hor_edg[i + 1 , j] == "G" && ver_edg[i , j + 1] == "G"
				if hor_edg[i + 1 , j + 1] == "B"
					ver_edg[i + 1 , j + 1] = "B"
				end
				if ver_edg[ i + 1 , j + 1] == "B"
					hor_edg[i + 1 , j + 1] = "B"
				end
			end
			#R_B_GREY
			if hor_edg[i + 1 , j + 1] == "G" && ver_edg[i , j + 1] == "G"
				if hor_edg[i + 1 , j] == "B"
					ver_edg[i + 1 , j + 1] = "B"
				end
				if ver_edg[i + 1 , j + 1] == "B"
					hor_edg[i + 1 , j] = "B"
				end
			end
			#L_O_GREY
			if hor_edg[i + 1 , j] == "G" && ver_edg[i + 1 , j + 1] == "G"
				if hor_edg[i + 1 , j + 1] == "B"
					ver_edg[i , j + 1] = "B"
				end
				if ver_edg[i , j + 1] == "B"
					hor_edg[i + 1 , j + 1] = "B"
				end
			end
			#R_O_GREY
			if hor_edg[i + 1 , j + 1] == "G" && ver_edg[i + 1 , j + 1] == "G"
				if hor_edg[i + 1 , j] == "B"
					ver_edg[i , j + 1] = "B"
				end
				if ver_edg[i , j + 1] == "B"
					hor_edg[i + 1 , j] = "B"
				end
			end
		end
	end		
end

# ╔═╡ 1003c0a2-3a45-4a9e-b071-bab4a3ae07f6
function deletered()
	for i in 1 : rows
		for j in 1 : columns + 1
			if ver_edg[i , j] == "R"
				ver_edg[i , j] = "B"
			end
		end
	end
	for i in 1 : rows + 1
		for j in 1 : columns
			if hor_edg[i , j] == "R"
				hor_edg[i , j] = "B"
			end
		end
	end
end

# ╔═╡ 882c0aec-372e-46e8-9911-f777f83e2268
function Three_grey_sides()
	deletered()
	for i in 2:rows
		for j in 2:columns
			#Onderste
			if hor_edg[i,j-1] == "G" && hor_edg[i,j] == "G" && ver_edg[i-1,j] == "G" && ver_edg[i,j] == "B"
				ver_edg[i,j] = "R"
			end
			#Bovenste
			if hor_edg[i,j-1] == "G" && hor_edg[i,j] == "G" && ver_edg[i,j] == "G" && ver_edg[i-1,j] == "B"
				ver_edg[i-1,j] = "R"
			end
			#Rechtse
			if hor_edg[i,j-1] == "G" && ver_edg[i-1,j] == "G" && ver_edg[i,j] == "G" && hor_edg[i,j] == "B"
				hor_edg[i,j] = "R"
			end
			#Linkse
			if hor_edg[i,j] == "G" && ver_edg[i-1,j] == "G" && ver_edg[i,j] == "G" && hor_edg[i,j-1] == "B"
				hor_edg[i,j-1] = "R"
			end
		end
	end
end

# ╔═╡ 180591b2-348a-43f1-9090-fe2951c0f3cd
function checks()
	Three_grey_sides()
end

# ╔═╡ 3e56b6e4-4af0-4e0c-8eda-f8a82b9f38e6
function create_numberofblackedges()
	numberofblackedges = fill("", rows, columns)
	#gridedge
	for ii in 1:rows
		numberofblackedges[ii, 1]  = "R"
		numberofblackedges[ii, columns]  = "R"
		for jj in 2:columns-1
			numberofblackedges[1, jj] = "D"
			numberofblackedges[ii, jj] = ""
			numberofblackedges[rows, jj] = "D"
		end
	end 
	#corners
	numberofblackedges[1, columns]  = numberofblackedges[1, columns]*"D"
	numberofblackedges[1, 1]  = numberofblackedges[1, 1]*"D"
	numberofblackedges[rows, 1]  = numberofblackedges[rows, 1]*"D"
	numberofblackedges[rows, columns]  = numberofblackedges[rows, columns]*"D" 
	#general
	for ii in 2:rows  
		for jj in 2:columns
			if hor_edg[ii, jj] == "B"
				numberofblackedges[ii, jj] = numberofblackedges[ii, jj]*"D"
				numberofblackedges[ii-1, jj] = numberofblackedges[ii-1, jj]*"D"
			end
		end
	end
	for ii in 2:rows  
		for jj in 2:columns
			if ver_edg[ii, jj] == "B"
				numberofblackedges[ii, jj] = numberofblackedges[ii, jj]*"R"
				numberofblackedges[ii, jj-1] = numberofblackedges[ii, jj-1]*"R"
			end
		end
	end
	#for row 1
	for jj in 1:columns-1
		if ver_edg[1,jj+1] == "B"
			numberofblackedges[1, jj] = numberofblackedges[1, jj]*"R"
			numberofblackedges[1, jj+1] = numberofblackedges[1, jj+1]*"R"
		end
	end
	#for column 1
	for ii in 1:rows-1
		if hor_edg[ii+1,1] == "B"
			numberofblackedges[ii,1] = numberofblackedges[ii,1]*"D"
			numberofblackedges[ii+1,1] = numberofblackedges[ii+1,1]*"D"
		end
	end
	for ii in 1:rows
		for jj in 1:columns
			number = length(numberofblackedges[ii, jj])
			numberofblackedges[ii, jj] = "$number"
		end
	end
	return numberofblackedges
end

# ╔═╡ 72fdf1e2-b6f5-11eb-2343-a357e381083c
function diagonal_two_grey_sides()
	#Rechtsonder
nobe = create_numberofblackedges()
	for ii in 1:rows - 1
		for jj in 1:columns - 1
			if puzzle[ii,jj] == "2"
				if parse(Int64,nobe[ii , jj]) < 2
					if hor_edg[ii + 1 , jj + 1] == "G" && ver_edg[ii + 1 , jj + 1] == "G"
						if hor_edg[ii , jj] == "B"
							ver_edg[ii , jj] = "B"
						end
						if ver_edg[ii , jj] == "B"
							hor_edg[ii , jj] = "B"
						end
					end
				end
			end
		end
	end
	#rechtsboven
	for ii in 2 : rows
		for jj in 1 : columns - 1
			if puzzle[ii , jj] == "2"
				if parse(Int64,nobe[ii , jj]) < 2 
					if hor_edg[ii , jj + 1] == "G" && ver_edg[ii - 1 , jj + 1] == "G"
						if hor_edg[ii + 1 , jj] == "B"
							ver_edg[ii , jj] = "B"
						end
						if ver_edg[ii , jj] == "B"
							hor_edg[ii + 1 , jj] = "B"
						end
					end
				end
			end
		end
	end
	#linksboven
	for ii in 2: rows
		for jj in 2: columns
			if puzzle[ii,jj] == "2"
				if parse(Int64,nobe[ii , jj]) < 2
					if hor_edg[ii , jj-1] == "G" && ver_edg[ii - 1 , jj ] == "G"
						if hor_edg[ii + 1 , jj] =="B"
							ver_edg[ii , jj + 1] = "B"
						end
						if ver_edg[ii , jj + 1] == "B"
							hor_edg[ii + 1 , jj] = "B"
						end
					end
				end
			end
		end
	end
	#linksonder
	for ii in 1 : rows - 1
		for jj in 2 : columns
			if puzzle[ii , jj] == "2"
				if parse(Int64,nobe[ii , jj]) < 2
					if hor_edg[ii + 1 , jj - 1] == "G" && ver_edg[ii + 1, jj] == "G"
						if hor_edg[ii , jj] == "B"
							ver_edg[ii , jj + 1] ="B"
						end
						if ver_edg[ii , jj + 1] == "B"
							hor_edg[ii , jj] = "B"
						end
					end
				end
			end
		end
	end
end

# ╔═╡ 6172d3b0-b73f-11eb-2a53-59b81076e2a2
function Diagonalchecks()
	diagonal_one_grey_sides()
	diagonal_two_grey_sides()
	diagonal_three_grey_sides()
end

# ╔═╡ 243f8370-b6ff-11eb-002a-75b8d147bc1b
function Complete_number_grey()
	nobe = create_numberofblackedges()
	for i in 1 : rows
		for j in 1 : columns
			if puzzle[i , j] == string(nobe[i , j])
				if hor_edg[i + 1 , j] == "Y"
					hor_edg[i + 1 , j] = "G"
				end
				if hor_edg[i , j] == "Y"
					hor_edg[i , j] = "G"
				end
				if ver_edg[i , j + 1] == "Y"
					ver_edg[i , j + 1] = "G"
				end
				if ver_edg[i , j ] == "Y"
					ver_edg[i , j] = "G"
				end
			end
		end
	end
end

# ╔═╡ 4064658f-763d-4f59-8ed0-5946d256b42c
function create_numberofgreyedges()
	numberofgreyedges = fill("", rows, columns)
	#general
	for ii in 2:rows  
		for jj in 2:columns
			if hor_edg[ii, jj] == "G"
				numberofgreyedges[ii, jj] = numberofgreyedges[ii, jj]*"D"
				numberofgreyedges[ii-1, jj] = numberofgreyedges[ii-1, jj]*"D"
			end
		end
	end
	for ii in 2:rows  
		for jj in 2:columns
			if ver_edg[ii, jj] == "G"
				numberofgreyedges[ii, jj] = numberofgreyedges[ii, jj]*"R"
				numberofgreyedges[ii, jj-1] = numberofgreyedges[ii, jj-1]*"R"
			end
		end
	end
	#for row 1
	for jj in 1:columns-1
		if ver_edg[1,jj+1] == "G"
			numberofgreyedges[1, jj] = numberofgreyedges[1, jj]*"R"
			numberofgreyedges[1, jj+1] = numberofgreyedges[1, jj+1]*"R"
		end
	end
	#for column 1
	for ii in 1:rows-1
		if hor_edg[ii+1,1] == "G"
			numberofgreyedges[ii,1] = numberofgreyedges[ii,1]*"D"
			numberofgreyedges[ii+1,1] = numberofgreyedges[ii+1,1]*"D"
		end
	end
	for ii in 1:rows
		for jj in 1:columns
			number = length(numberofgreyedges[ii, jj])
			numberofgreyedges[ii, jj] = "$number"
		end
	end
	return numberofgreyedges
end

# ╔═╡ dc75cec0-b710-11eb-2058-93262abf07a3
function check_available_sides()
	nobe = create_numberofblackedges()
	noge = create_numberofgreyedges()
	available_sides = fill("" , rows , columns)
	for i in 1 : rows
		for j in 1 : columns
			available_sides[i , j] = string(4 - (parse(Int64 , nobe[i , j]) + parse(Int64 , noge[i , j])))
		end
	end
	return available_sides
end

# ╔═╡ e50c497c-9fd0-434b-98b4-ff1b961b33ae
function check_available_sides(HYPOTHOR , HYPOTVER)
	nobe = create_numberofblackedges(HYPOTHOR , HYPOTVER)
	noge = create_numberofgreyedges(HYPOTHOR , HYPOTVER)
	available_sides = fill("" , rows , columns)
	for i in 1 : rows
		for j in 1 : columns
			available_sides[i , j] = string(4 - (parse(Int64 , nobe[i , j]) + parse(Int64 , noge[i , j])))
		end
	end
	return available_sides
end

# ╔═╡ 59b55ca0-b740-11eb-3fdf-833a9e85c7b5
function complete_available_sides()
	av_sides = check_available_sides()
	nobe = create_numberofblackedges()
	for i in 1 : rows
		for j in 1 : columns
			if puzzle[i , j] == string(parse(Int64 , nobe[i , j]) + parse(Int64,av_sides[i , j]))
				if hor_edg[i + 1 , j] == "Y"
					hor_edg[i + 1 , j] = "B"
				end
				if hor_edg[i , j] == "Y"
					hor_edg[i , j] = "B"
				end
				if ver_edg[i , j + 1] == "Y"
					ver_edg[i , j + 1] = "B"
				end
				if ver_edg[i , j] == "Y"
					ver_edg[i , j] = "B"
				end
			end
		end
	end
end

# ╔═╡ 05f92524-84f9-478d-86d5-0deecbdf4da8
function checknumbers()
	numberofblackedges = create_numberofblackedges()
	numberofgreyedges =  create_numberofgreyedges()
	Rednumbers = fill("", rows, columns)
	for ii in 1:rows
		for jj in 1:columns
			if puzzle[ii, jj] < numberofblackedges[ii, jj]
				Rednumbers[ii , jj] = puzzle[ii , jj]
			elseif puzzle[ii, jj] >= numberofblackedges[ii, jj]
				Rednumbers[ii , jj] = ""
			end
		end
	end
	for ii in 1: rows
		for jj in 1:columns
			if puzzle[ii , jj] != "" && numberofgreyedges[ii , jj] != ""
				if parse(Int64,puzzle[ii , jj]) > 4 - 					parse(Int64,numberofgreyedges[ii , jj])
					Rednumbers[ii , jj] = puzzle[ii , jj]
				end
			end
		end
	end
	return Rednumbers
end

# ╔═╡ 59a9e0e8-2f98-46fc-8d49-f1bd71635c38
function printrednumbers()
	Rednumbers = checknumbers()
	for ii in 1:rows
		for jj in 1:columns
			if Rednumbers[ii,jj] == ""
				continue
			else
				g(fill = "red", font_size = "50", stroke = "red", font_family = "Verdana") do
					text(x = (jj-1)*100 + 45, y = (ii-1)*100 + 75) do
						str(Rednumbers[ii,jj])
					end
				end
			end
		end
	end
end

# ╔═╡ 69d46db0-b1d2-11eb-37c4-cdb58915fb30
function printver()
	for i in 1 : rows
			for j in 1 : columns + 1
				if ver_edg[i , j] == "Y"
					g(fill = "rgb(100.0%,100.0%,20.0%)", stroke = "rgb(100.0%,100.0%,20.0%)", stroke_width = "3") do
						line(x1=10+(j-1)*100, y1=10+(i-1)*100 , x2=10+(j-1)*100, y2=10+i*100)
					end
				end
			end
		end
		for i in 1 : rows
			for j in 1 : columns + 1
				if ver_edg[i , j] == "B"
					g(fill = "rgb(0%,0%,0%)", stroke = "rgb(0%,0%,0%)", stroke_width = "3") do
						line(x1=10+(j-1)*100, y1=10+(i-1)*100 , x2=10+(j-1)*100, y2=10+i*100)
					end
				end
			end
		end
		for i in 1 : rows
			for j in 1 : columns + 1
				if ver_edg[i , j] == "G"
					g(fill = "rgb(96%,96%,96%)", stroke = "rgb(96%,96%,96%)", stroke_width = "1.5") do
						line(x1=10+(j-1)*100, y1=10+(i-1)*100 , x2=10+(j-1)*100, y2=10+i*100)
					end
				end
			end
		end
		for i in 1 : rows
			for j in 1 : columns + 1
				if ver_edg[i , j] == "R"
					g(fill = "rgb(100%,0.03%,0%)", stroke = "rgb(100%,0.03%,0%)", stroke_width = "3") do
						line(x1=10+(j-1)*100, y1=10+(i-1)*100 , x2=10+(j-1)*100, y2=10+i*100)
					end
				end
			end
		end
end

# ╔═╡ 803589a3-e241-463d-8c8a-35212dfcab02
function create_blackedgesver()
	blackedgesver = fill("" , rows , columns + 1)
	for i in 1 : rows
		for j in 1 : columns + 1
			if ver_edg[ i , j ] == "B"
				blackedgesver[ i , j ] = "B"
			end
		end
	end
	return blackedgesver
end

# ╔═╡ af66f3b4-08c5-4809-98af-5db3864ea19a
function Victory()
	A = create_blackedgeshor()
	B = create_blackedgesver()
	if A == Sol[1]
		if B == Sol[2]
			g(fill = "Blue",font_size = "25", font_family = "Verdana") do
				text(x = 100*columns + 50, y = 30) do
					str("Congratulations!")
				end
			end
		end
	end
end

# ╔═╡ f9b2b392-b710-11eb-2a37-0378aa36f60d
function grey_group()
	groups = zeros(rows, columns)
	counter = 1
	for ii in 2 : rows + 1
		for jj in 2 : columns + 1
			if ii == 2
				if ver_edg[ii-1, jj] == "G"
					groups[ii-1, jj-1] = counter
					groups[ii-1, jj] = groups[ii-1, jj-1]
				else
					groups[ii-1, jj-1] = counter
					counter += 1
				end
			else
				if hor_edg[ii-1, jj-1] == "G"
					groups[ii-1, jj-1] = groups[ii-2, jj-1]
				else
					groups[ii-1, jj-1] = counter
					counter += 1
				end
			end
		end
	end
	for ii in 3:rows+1
		for jj in 2:columns+1
			if hor_edg[ii-1, jj-1] == "G"
				groups[ii-1, jj-1] = groups[ii-2, jj-1]
			end
			if ver_edg[ii-1, jj] == "G"
				if groups[ii-1, jj-1] > groups[ii-1, jj]
					groups[ii-1, jj-1] = groups[ii-1, jj]
				else
					groups[ii-1, jj] = groups[ii-1, jj-1]
				end
			end
		end
	end
	return groups
end

# ╔═╡ 05946867-5d6b-4fa4-9c13-30bd70f10deb
function grey_group(HOR , VER)
	minigroups = zeros(rows, columns)
	counter = 1
	for ii in 2:rows+1
		for jj in 2:columns+1
			if ii == 2
				if VER[ii-1, jj] == "G"
					minigroups[ii-1, jj-1] = counter
					minigroups[ii-1, jj] = minigroups[ii-1, jj-1]
				else
					minigroups[ii-1, jj-1] = counter
					counter += 1
				end
			else
				if HOR[ii-1, jj-1] == "G"
					minigroups[ii-1, jj-1] = minigroups[ii-2, jj-1]
				else
					minigroups[ii-1, jj-1] = counter
					counter += 1
				end
			end
		end
	end
	for ii in 3:rows+1
		for jj in 2:columns+1
			if HOR[ii-1, jj-1] == "G"
				minigroups[ii-1, jj-1] = minigroups[ii-2, jj-1]
			end
			if VER[ii-1, jj] == "G"
				if minigroups[ii-1, jj-1] > minigroups[ii-1, jj]
					minigroups[ii-1, jj-1] = minigroups[ii-1, jj]
				else
					minigroups[ii-1, jj] = minigroups[ii-1, jj-1]
				end
			end
		end
	end
	return minigroups
end

# ╔═╡ a9d9fdc5-9f62-4338-96d9-e5afc1dfaf5a
#er mogen geen gele zijden meer zijn in de rest van de groep
function no_more_yellow_sides(HYPOTHOR , HYPOTVER, i , j)
	minigroups = grey_group(HYPOTHOR , HYPOTVER)
	available_sides = check_available_sides(HYPOTHOR , HYPOTVER)
			group = minigroups[i , j]
			for ii in 1 : rows
				for jj in 1 : columns
					if minigroups[ii , jj] == group
						if available_sides[ii , jj] !== "0"
							return false
						end
					end
				end
			end
end			

# ╔═╡ f4416be0-b710-11eb-2e90-edbf3c4b7ee6
function grey_area()
	groups = grey_group()
	Grey_area_groups = zeros(rows, columns)
	m = maximum(groups)
	for i in 1:m
		size = 0
		for ii in 1:rows
			for jj in 1:columns
				if i == groups[ii, jj]
					size += 1
				end
			end
		end
		for ii in 1:rows
			for jj in 1:columns
				if i == groups[ii, jj]
					Grey_area_groups[ii, jj] = size
				end
			end
		end
	end
	return Grey_area_groups
end

# ╔═╡ 15096e65-895b-487e-8cda-6372255be41c
function grey_area(HOR , VER)
	minigroups = grey_group(HOR,VER)
	Grey_area_groups = zeros(rows, columns)
	m = maximum(minigroups)
	for i in 1:m
		size = 0
		for ii in 1:rows
			for jj in 1:columns
				if i == minigroups[ii, jj]
					size += 1
				end
			end
		end
		for ii in 1:rows
			for jj in 1:columns
				if i == minigroups[ii, jj]
					Grey_area_groups[ii, jj] = size
				end
			end
		end
	end
	return Grey_area_groups
end

# ╔═╡ e84e08be-b710-11eb-390a-d14cd856daa6
function adjecent_areas()
	Grey_area_groups = grey_area()
	Grey_groups = grey_group()

	for i in 1 : rows - 1
		for j in 1 : columns
			if Grey_groups[i , j] != Grey_groups[i + 1 , j]
				if Grey_area_groups[i , j] + Grey_area_groups[i + 1 , j] > region
					hor_edg[i + 1 , j] = "B"
				end
			end
		end
	end
	for i in 1 : rows
		for j in 1 : columns - 1
			if Grey_groups[i , j] != Grey_groups[i , j + 1]
				if Grey_area_groups[i , j] + Grey_area_groups[i , j + 1] > region
					ver_edg[i , j + 1] = "B"
				end
			end
		end
	end
end

# ╔═╡ 348fa730-b792-11eb-11aa-4ff102c2996a
function Grey_region_complete()
	#3 voudig probleem
		# eerst de binnenste vakjes die de randen niet raken
		# dan de vakken die de randen 1-maal raken
		# als laatste de hoeken
	Grey_area_groups = grey_area()
	for i in 2 : rows - 1
		for j in 2 : columns - 1
			if Grey_area_groups[i , j] == region
				if Grey_area_groups[i + 1, j] != region
					hor_edg[i + 1, j] = "B"
					
				end
				if Grey_area_groups[i - 1 , j] != region
					hor_edg[i , j] = "B"
					
				end
				if Grey_area_groups[i , j + 1] != region
					ver_edg[i , j + 1] = "B"
				
				end
				if Grey_area_groups[i , j - 1] != region
					ver_edg[i , j] = "B"
				end
			end
		end
	end
	for i in 2 : columns - 1
		if Grey_area_groups[1 , i] == region
			if Grey_area_groups[2 , i] != region
				hor_edg[2 , i] = "B" 
			end
			if Grey_area_groups[1 , i + 1] != region
				ver_edg[1 , i + 1] = "B"
				
			end
			if Grey_area_groups[1 , i - 1] != region
				ver_edg[1 , i] = "B"
			end
		end
	end
	for i in 2 : columns - 1
		if Grey_area_groups[rows , i] == region
			if Grey_area_groups[rows - 1 , i] != region
				hor_edg[rows , i] = "B" 
			end
			if Grey_area_groups[rows , i + 1] != region
				ver_edg[rows , i + 1] = "B"
				
			end
			if Grey_area_groups[rows , i - 1] != region
				ver_edg[rows , i] = "B"
			end
		end
	end
	for i in 2 : rows - 1
		if Grey_area_groups[i , 1] == region
			if Grey_area_groups[i , 2] != region
				ver_edg[i , 2] = "B"
				
			end
			if Grey_area_groups[i + 1 , 1] != region
				hor_edg[i + 1 , 1] = "B"
				
			end
			if Grey_area_groups[i - 1 , 1] != region
				hor_edg[i , 1] = "B"
			end
		end
	end
	for i in 2 : rows - 1
		if Grey_area_groups[i , columns] == region
			if Grey_area_groups[i , columns - 1] != region
				ver_edg[i , columns] = "B"
				
			end
			if Grey_area_groups[i + 1 , columns] != region
				hor_edg[i + 1 , columns] = "B"
				
			end
			if Grey_area_groups[i - 1 , columns] != region
				hor_edg[i , columns] = "B"
			end
		end
	end
	if Grey_area_groups[1 , 1] == region
		if Grey_area_groups[2 , 1] != region
		end
		if Grey_area_groups[1 , 2] != region
			ver_edg[1 , 2] = "B"
		end
	end
	if Grey_area_groups[rows , columns] == region
		if Grey_area_groups[rows - 1 , columns] != region
			hor_edg[rows , columns] = "B"
		end
		if Grey_area_groups[rows , columns - 1] != region
			ver_edg[rows , columns] = "B"
		end
	end
	if Grey_area_groups[1 , columns] == region
		if Grey_area_groups[2 , columns] != region
			hor_edg[2 , columns] = "B"
		end
		if Grey_area_groups[1, columns - 1] != region
			ver_edg[1 , columns] = "B"
		end
	end
	if Grey_area_groups[rows , 1] == region
		if Grey_area_groups[rows - 1 , 1] != region
			hor_edg[rows , 1] = "B"
		end
		if Grey_area_groups[rows , 2] != region
			ver_edg[rows , 2] = "B"
		end
	end
end

# ╔═╡ 6d4429fe-2e85-4f10-be2e-b8461ac2ea2d
function check_the_last_side(hor_edg, ver_edg)
	available_sides = check_available_sides()
	for i in 1 : rows
		for j in 1 : columns
			if available_sides[i , j] == "1"
				#UP
				HYPOTHOR = copy(hor_edg)
				HYPOTVER = copy(ver_edg)
				if HYPOTHOR[i , j] == "Y"
					HYPOTHOR[i , j] = "B"
					areagroups = grey_area(HYPOTHOR , HYPOTVER)
					if areagroups[i , j] < region
						if no_more_yellow_sides(HYPOTHOR , HYPOTVER, i , j) !== false
							HYPOTHOR[i , j] = "G"
							hor_edg[i , j] = HYPOTHOR[i , j]
						end
					end
					
				end
				#DOWN
				if HYPOTHOR[i + 1 , j] == "Y"
					HYPOTHOR[i + 1, j] = "B"
					areagroups = grey_area(HYPOTHOR , HYPOTVER)
					if areagroups[i , j] < region
						if no_more_yellow_sides(HYPOTHOR , HYPOTVER, i , j) !== false
							HYPOTHOR[i + 1 , j] = "G"
							hor_edg[i + 1 , j] = HYPOTHOR[i + 1 , j]
						end
					end
					
				end
				#LEFT
				if HYPOTVER[i , j] == "Y"
					HYPOTVER[i , j] = "B"
					areagroups = grey_area(HYPOTHOR , HYPOTVER)
					if areagroups[i , j] < region
						if no_more_yellow_sides(HYPOTHOR , HYPOTVER, i , j) !== false
							HYPOTVER[i , j] = "G"
							ver_edg[i  , j] = HYPOTVER[i , j]
						end
					end
					
				end
				#RIGHT
				if HYPOTVER[i , j + 1] == "Y"
					HYPOTVER[i , j + 1] = "B"
					areagroups = grey_area(HYPOTHOR , HYPOTVER)
					if areagroups[i , j] < region
						if no_more_yellow_sides(HYPOTHOR , HYPOTVER, i , j) !== false
							HYPOTVER[i , j + 1] = "G"
							ver_edg[i , j + 1] = HYPOTVER[i , j + 1]
						end
					end
				end
			end
		end
	end
end

# ╔═╡ 5d4030b2-b967-11eb-0e8c-bb515a3914f5
function Dynamic_checks()
	Diagonalchecks()
	Grey_cross()
	Complete_number_grey()
	check_available_sides()
	complete_available_sides()
	Grey_region_complete()
	adjecent_areas()
	only_path()
	check_the_last_side(hor_edg , ver_edg)
end

# ╔═╡ eb8e0a10-b677-11eb-2c66-e5d28bf510c9
function activate_bot()
		initial_bot()
		Diagonalchecks()
		Grey_cross()
		Complete_number_grey()
		complete_available_sides()
		grey_group()
		only_path() 
		adjecent_areas()
		Grey_region_complete()
		check_the_last_side(hor_edg , ver_edg)
end

# ╔═╡ 8d528e3b-7294-4406-8148-ab999b06a288
function Victory_area()
	areagroups = grey_area()
	if areagroups == fill(region , rows , columns)
		g(fill = "Blue",font_size = "25", font_family = "Verdana") do
		text(x = 100*columns + 50, y = 30) do
			str("Congratulations!")
			end
		end
	end
end

# ╔═╡ 068a8bb0-bf44-46fa-9c37-3765f90e6e24
function Selectrowdefiner()
	A = A = Array(1:parse(Int64, "$rows"))
	B = String[]
	for i in A
		push!(B, string(A[i]))
	end
	return B
end

# ╔═╡ e30116c0-b1d2-11eb-1431-cb25882c682f
@bind Rowselec Select(Selectrowdefiner())

# ╔═╡ f2b858b5-061f-487b-bbe2-420c706bb37d
function Selectcolumndefiner()
	C = Array(1:parse(Int64, "$columns"))
	D = String[]
	for i in C
		push!(D, string(C[i]))
	end
	return D
end

# ╔═╡ ecd6ca00-b1d2-11eb-2b69-2b4b159760ef
@bind Columnselec Select(Selectcolumndefiner())

# ╔═╡ 6af3caf2-b1d3-11eb-14f9-33180ae61d1f
function Changecolor()
	Row = parse(Int , Rowselec)
	Column = parse(Int , Columnselec)
	if Colorselec == "Yellow"
		Color = "Y"
	elseif Colorselec == "Black"
		Color = "B"
	elseif Colorselec == "Grey"
		Color = "G"
	end
		
	if Edgeselec == "Down"
		hor_edg[Row + 1, Column] = "$Color"
	elseif Edgeselec == "Up"
		hor_edg[Row, Column] = "$Color"
	elseif Edgeselec == "Right"
		ver_edg[Row, Column+1] = "$Color"
	elseif Edgeselec == "Left"
		ver_edg[Row, Column] = "$Color"
	end
end

# ╔═╡ 012b4260-b17e-11eb-0931-c32b4d62f944
function Blackgrid()
	Drawing(width = (columns + 1) * 100 + 50, height = (rows + 1) * 100 + 50) do
		#Horizontale strepen
		for n in 1: rows + 1
			for j in 1: columns
			g(fill = "none", stroke = "Black", stroke_width = "3") do
				line(x1=10+(j-1)*100, y1=10+(n-1)*100 , x2=10+j*100, y2=10+(n-1)*100)
				end
			end
		end
		#Verticale strepen
		for n in 1: columns + 1
			for j in 1: rows
			g(fill = "none", stroke = "Black", stroke_width = "3") do
				line(x1=10+(n-1)*100, y1=10+(j-1)*100 , x2=10+(n-1)*100, y2=10+j*100)
				end
			end
		end
	end
end

# ╔═╡ 3e5ed7ae-4b43-4853-b7aa-09029a907c68
function Printtext(message)
	g(fill = "Red",font_size = "25", font_family = "Verdana") do
					text(x = 20, y = 100*rows + 70) do
						str(string(message))
		end
	end
end

# ╔═╡ 8dbcc570-b262-11eb-35ba-8369dec6c0b2
function Checkgridedge()
	if Colorselec == "Yellow" || Colorselec == "Grey"
		if Rowselec == "1" && Edgeselec == "Up"
			hor_edg[1, parse(Int64,Columnselec)] = "B"
			Printtext("This combination is not possible")
		elseif Rowselec == "$rows" && Edgeselec == "Down"
			hor_edg[parse(Int64,Rowselec)+1, parse(Int64,Columnselec)] = "B"
			Printtext("This combination is not possible")
		elseif Columnselec == "1" && Edgeselec == "Left"
			ver_edg[parse(Int64,Rowselec),1] = "B"
			Printtext("This combination is not possible")
		elseif Columnselec == "$columns" && Edgeselec == "Right"
			ver_edg[parse(Int64,Rowselec),parse(Int64,Columnselec)+1] = "B"
			Printtext("This combination is not possible")
		end
	end
end	

# ╔═╡ c7910ce0-b189-11eb-0550-05cf02c658f2
function printgrid()
	Drawing(width = (columns + 1) * 100 + 150, height = (rows + 1) * 100 + 10) do
		Checkgridedge()
		printnumbers()
		printrednumbers()
		printhor()
		printver()
		knots()
		Victory_area()
	end
end

# ╔═╡ 21989764-24f6-4477-ace8-3eb47d74d52d
function nextmoveBOT()
	if nextstep
		Changecolor()
		checks()
	end
	activate_bot()
	printgrid()
end

# ╔═╡ 2ccadc00-b1d3-11eb-3fef-c331206ee65c
function nextmove()
	if nextstep
		Changecolor()
		checks()
	end
	printgrid()
end

# ╔═╡ 95fdab20-b684-11eb-0b44-258b188d4af6
function main()
	puzzle_solved = false
	if activatebot 
		initial_bot()
		while puzzle_solved == false
			HOR = deepcopy(hor_edg)
			VER = deepcopy(ver_edg)
			Dynamic_checks()
			areagroups = grey_area(HOR , VER)
				if areagroups == fill(region , rows , columns)
				puzzle_solved = true
			end
			if HOR == hor_edg && VER == ver_edg
				puzzle_solved = true
			end
		end
	end
	nextmove()
end

# ╔═╡ bb853654-f337-495f-bcbd-c1df3655c599
main()

# ╔═╡ 7f62ea37-3554-4588-8994-264e9ce4a007
function solve_with_solution()
	for i in 1 : rows 
		for j in 1 : columns
			if create_blackedgeshor()[i , j] !== Sol[1][i , j]
				hor_edg[i , j] = Sol[1][i , j]
			end
			if create_blackedgesver()[i , j] !== Sol[2][i , j]
				ver_edg[i , j] = Sol[2][i , j]	
			end
		end
	end
end

# ╔═╡ Cell order:
# ╟─f0253250-b17d-11eb-372f-bbbd03ee7cfb
# ╟─012cf010-b17e-11eb-1316-e1cdffba1b97
# ╟─fb7e0980-b185-11eb-1bc8-1919e5821fb8
# ╟─bfb7e2be-b1d2-11eb-018e-712f9a0a95a2
# ╟─c55850c0-b1d2-11eb-36c8-2f441aa159e9
# ╟─d1c5d360-b276-11eb-1d5b-f11e27221dad
# ╟─c5d0a1d4-4e93-40e7-9eb4-0347a1fb0dc6
# ╟─580af820-b186-11eb-3083-7fc1e247cb1b
# ╟─19cd1710-b185-11eb-0b12-f912b4360d59
# ╟─3a8a33ce-b247-11eb-294e-af65126e69f4
# ╟─5609ff50-b247-11eb-3962-e7d25830ec2b
# ╟─60ca1290-b247-11eb-0f8f-21dd1311e609
# ╟─dabc6020-b248-11eb-0dea-996cec2b1742
# ╟─d25afd60-b248-11eb-33c1-a76ecee59e69
# ╟─a0c2c696-fb22-44c9-a9ca-a22e7a50ebaa
# ╟─8608cbc3-327c-4159-abf9-b7fe84a275c2
# ╟─e1713572-b276-11eb-2841-017e12e863d3
# ╟─da15ea92-b1d2-11eb-1a30-0d40c2d12b53
# ╟─e30116c0-b1d2-11eb-1431-cb25882c682f
# ╟─e63e6772-b1d2-11eb-30e7-9379f57316a5
# ╟─ecd6ca00-b1d2-11eb-2b69-2b4b159760ef
# ╟─f15c0400-b1d2-11eb-0c72-f7ca2c8a28c2
# ╟─f73ed230-b1d2-11eb-2460-1bd8cc839ef8
# ╟─fbd4d510-b1d2-11eb-2ed7-55caa10de146
# ╟─ff3f7750-b1d2-11eb-1713-df70f9da245a
# ╟─036c0a00-b1d3-11eb-3b44-1b84d2ed450d
# ╟─08124b00-b24b-11eb-0f7b-7f5ed32110f1
# ╟─643ceae2-b186-11eb-0f69-47102d6f1ea6
# ╟─bb853654-f337-495f-bcbd-c1df3655c599
# ╟─14bdf9a0-6e24-44fa-b3d3-85e465fce684
# ╟─d0dccaed-9b37-461a-9e88-c38961a3757b
# ╟─63e1c260-b964-11eb-153c-05fbc821a8f9
# ╟─95fdab20-b684-11eb-0b44-258b188d4af6
# ╟─2c59aff0-b73f-11eb-326d-cb60a5f4b687
# ╟─6172d3b0-b73f-11eb-2a53-59b81076e2a2
# ╟─5d4030b2-b967-11eb-0e8c-bb515a3914f5
# ╟─21989764-24f6-4477-ace8-3eb47d74d52d
# ╟─eb8e0a10-b677-11eb-2c66-e5d28bf510c9
# ╟─de074d4e-e570-4e1e-aa0b-0ed32d09b9f2
# ╟─349ee2c0-b67c-11eb-372c-497a82d46489
# ╟─43e90cb6-f772-4375-be75-a597650dbffe
# ╟─1653dc53-7232-4e3e-aba7-b0cf8ae7ce11
# ╟─5c6d3943-90ca-44f5-bab1-8fc4e7c43dbc
# ╟─99ca0e09-0054-4c16-831b-e2487c62e548
# ╟─df6095a0-b6ef-11eb-3c99-2de8057496ff
# ╟─8974bf4e-b964-11eb-3ca7-f16de054f17c
# ╟─c9982d9c-1f03-4e41-ae34-c96783c25900
# ╟─72fdf1e2-b6f5-11eb-2343-a357e381083c
# ╟─850ef840-f1e9-490e-a3dd-291442e5be44
# ╟─b46cd320-b6ec-11eb-28ed-df92b7a6d9d6
# ╟─243f8370-b6ff-11eb-002a-75b8d147bc1b
# ╟─dc75cec0-b710-11eb-2058-93262abf07a3
# ╟─e50c497c-9fd0-434b-98b4-ff1b961b33ae
# ╟─59b55ca0-b740-11eb-3fdf-833a9e85c7b5
# ╟─e84e08be-b710-11eb-390a-d14cd856daa6
# ╟─c220eeb0-b710-11eb-3b71-a1a484ba7ae7
# ╟─348fa730-b792-11eb-11aa-4ff102c2996a
# ╟─295ba740-b965-11eb-36ce-a1a294e39999
# ╟─6d4429fe-2e85-4f10-be2e-b8461ac2ea2d
# ╟─a9d9fdc5-9f62-4338-96d9-e5afc1dfaf5a
# ╟─4b23235f-6d04-4861-a143-8ead80b43d2f
# ╟─2ccadc00-b1d3-11eb-3fef-c331206ee65c
# ╟─6af3caf2-b1d3-11eb-14f9-33180ae61d1f
# ╟─180591b2-348a-43f1-9090-fe2951c0f3cd
# ╟─882c0aec-372e-46e8-9911-f777f83e2268
# ╟─1003c0a2-3a45-4a9e-b071-bab4a3ae07f6
# ╟─c7910ce0-b189-11eb-0550-05cf02c658f2
# ╟─8dbcc570-b262-11eb-35ba-8369dec6c0b2
# ╟─10205112-b260-11eb-143e-579c85416a64
# ╟─59a9e0e8-2f98-46fc-8d49-f1bd71635c38
# ╟─05f92524-84f9-478d-86d5-0deecbdf4da8
# ╟─3e56b6e4-4af0-4e0c-8eda-f8a82b9f38e6
# ╟─7399876f-a48f-4e22-98ba-ace50e4cc65a
# ╟─4064658f-763d-4f59-8ed0-5946d256b42c
# ╟─13efda23-db35-4616-8dd3-beaef126d975
# ╟─492e9450-b1d2-11eb-37f9-f3a502ac50e9
# ╟─69d46db0-b1d2-11eb-37c4-cdb58915fb30
# ╟─866f9440-b1d2-11eb-391e-abaa0c424efe
# ╟─af66f3b4-08c5-4809-98af-5db3864ea19a
# ╟─8d528e3b-7294-4406-8148-ab999b06a288
# ╟─803589a3-e241-463d-8c8a-35212dfcab02
# ╟─f3fa59b9-8723-495f-a3bb-7f3afe20c86a
# ╟─8831ef40-b186-11eb-145a-df5c1a00c256
# ╟─08e276e0-b188-11eb-2251-ef9a8d1304f4
# ╟─66293d16-4081-46ff-9f0c-417c85ada048
# ╟─f9b2b392-b710-11eb-2a37-0378aa36f60d
# ╟─05946867-5d6b-4fa4-9c13-30bd70f10deb
# ╟─f4416be0-b710-11eb-2e90-edbf3c4b7ee6
# ╟─15096e65-895b-487e-8cda-6372255be41c
# ╟─58cb0940-b185-11eb-229e-a9f512b455b0
# ╟─068a8bb0-bf44-46fa-9c37-3765f90e6e24
# ╟─f2b858b5-061f-487b-bbe2-420c706bb37d
# ╟─012b4260-b17e-11eb-0931-c32b4d62f944
# ╟─3e5ed7ae-4b43-4853-b7aa-09029a907c68
# ╟─7f62ea37-3554-4588-8994-264e9ce4a007
# ╟─3f499980-bd30-11eb-1ba7-a398aa4adc69
# ╟─934a82c0-b186-11eb-39b7-ef349142f77e
# ╟─2b8a88e0-b188-11eb-377b-6546773fda30
# ╟─cce1b9d0-c91a-11eb-168d-bdf22d5d6b06
# ╟─405d1707-72da-44ae-ae23-154d37b20357
