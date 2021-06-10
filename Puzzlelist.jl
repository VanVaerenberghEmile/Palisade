### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 8e12da30-b35e-11eb-356d-b9a7a2cb2b8b
md"# List of puzzles"

# ╔═╡ 4f27e48c-8c89-4d57-ab1a-a386f2dcaa4f
md"## 5x5"

# ╔═╡ ceb25488-68fa-4d88-8097-9e2fe781b697
md"### Puzzle 1"

# ╔═╡ cf0c31f4-afeb-4a0a-adec-3e1cb4a1a4d5
puzzle_5x5_1 = [ "2" "1" "" "2" "3" 
			"" "" "" "1" "" 
			"3" "" "2" "" "" 
			"3" "" "2" "" "1" 
			"2" "2" "" "" "" ]

# ╔═╡ 92bef126-f26a-481c-b149-bce6cbacd42a
puzzle_5x5_1_sol_hor = [ "B"  "B"  "B"  "B"  "B"
 ""   ""   "B"  ""   "B"
 "B"  "B"  "B"  ""   ""
 "B"  ""   ""   "B"  ""
 ""   "B"  "B"  "B"  ""
 "B"  "B"  "B"  "B"  "B"]

# ╔═╡ a77841e6-860b-461c-bcc1-9e03dfabf942
puzzle_5x5_1_sol_ver = [ "B"  ""   ""   "B"  ""   "B"
 "B"  ""   "B"  ""   "B"  "B"
 "B"  ""   ""   "B"  "B"  "B"
 "B"  "B"  ""   "B"  ""   "B"
 "B"  ""   ""   ""   "B"  "B"]

# ╔═╡ 2082e84b-59a7-4cc0-ab6c-0366a5f65607
Sol_5x5_1 = (puzzle_5x5_1_sol_hor , puzzle_5x5_1_sol_ver)

# ╔═╡ 043c237d-3fae-47ec-a51c-9e4727921852
md"### Puzzle 2"

# ╔═╡ 70cbe421-c024-4d1c-8d8d-ed4fe2bee218
puzzle_5x5_2 =["2" "" "" "" "2"
				"2" "1" "3" "3" ""
				"3" "3" "" "" ""
			"2" "" "1" "" ""
			"2" "" "" "" ""]

# ╔═╡ 1bb0914c-95c1-4d71-84d7-68daf5adfaab
puzzle_5x5_2_sol_hor = [ "B"  "B"  "B"  "B"  "B"
 ""   ""   ""   "B"  ""
 "B"  ""   "B"  ""   "B"
 ""   "B"  ""   "B"  ""
 ""   "B"  "B"  ""   ""
 "B"  "B"  "B"  "B"  "B" ]

# ╔═╡ 79021008-77ea-4c2b-adde-1a11aa8c43a5
puzzle_5x5_2_sol_ver = [ "B"  ""   "B"  ""   ""   "B"
 "B"  ""   "B"  "B"  "B"  "B"
 "B"  "B"  "B"  "B"  ""   "B"
 "B"  "B"  ""   ""   "B"  "B"
 "B"  ""   ""   "B"  "B"  "B"]

# ╔═╡ b6ba494f-7637-49bc-be73-587e689d4b2e
Sol_5x5_2 = (puzzle_5x5_2_sol_hor , puzzle_5x5_2_sol_ver)

# ╔═╡ f882ba30-c947-11eb-0de0-5d1f64a57d99
md"### Puzzle 3"

# ╔═╡ 6f061530-c948-11eb-2a50-dd6855cd5dc2
puzzle_5x5_3 =[ "" "" "" "" "3"
				"" "" "" "" "3"
				"" "" "" "" ""
				"1" "3" "" "2" "1" 
				"" "" "" "3" ""]

# ╔═╡ 8959bcc0-c948-11eb-0802-7b5c027e751e
puzzle_5x5_3_sol_hor = [ "B"  "B"  "B"  "B"  "B"
 "B"  "B"  "B"  "B"  "B"
 ""   ""   "B"  "B"  "B"
 ""   "B"  ""   ""   ""
 ""   "B"  ""   "B"  ""
 "B"  "B"  "B"  "B"  "B"]

# ╔═╡ 95f2aeb0-c948-11eb-3cd9-87f0eedb4a32
puzzle_5x5_3_sol_ver =[ "B"  ""   ""   ""   ""   "B"
 "B"  "B"  ""   ""   ""   "B"
 "B"  "B"  "B"  "B"  ""   "B"
 "B"  ""   "B"  "B"  ""   "B"
 "B"  "B"  ""   ""   "B"  "B"]

# ╔═╡ 1651b060-c949-11eb-1a64-eb7370ec0e4b
Sol_5x5_3 = (puzzle_5x5_3_sol_hor , puzzle_5x5_3_sol_ver)

# ╔═╡ 9d7eeb4f-d93b-4c30-bd27-a47ebfac8662
md"#### Dictionary"

# ╔═╡ 4c0a1d74-ad9d-4453-88c9-09c6eeb0a8cf
Puzzles_5x5_Dict = Dict([(puzzle_5x5_1 , Sol_5x5_1) , (puzzle_5x5_2 ,Sol_5x5_2), (puzzle_5x5_3 , Sol_5x5_3)])

# ╔═╡ 860a9d64-0ec9-4c06-b988-ad7cc597bb85
md"## CUSTOM"

# ╔═╡ a14f9acf-ee45-4315-8df7-5c53e3c6268b
md"#### 5x8"

# ╔═╡ 1694d97c-0e97-4244-8a75-f1d9219f883b
puzzle_5x8 = ["2" "1" "" "2" "3" "" "" ""
				"" "" "" "1" "" "0" "" "2"
			"3" "" "2" "" "" "" "" ""
			"3" "" "2" "" "0" "" "" "3"
			"2" "2" "" "" "" "" "1" "3"]

# ╔═╡ e07fb4ab-6216-44b2-b2bc-4bc91b9922cd
md"# -----------------------------------------------------------"

# ╔═╡ ba9af59f-d460-447d-8215-d8f16c26f0f5
md"##### Made by:
- Van Vaerenbergh Emile
- Bouchez Cloë
- Van Riet Pieterjan"

# ╔═╡ 650461cb-cea8-4df7-9684-07fdd31e632e
A = ["175 is the BEST prom"]

# ╔═╡ Cell order:
# ╟─8e12da30-b35e-11eb-356d-b9a7a2cb2b8b
# ╟─4f27e48c-8c89-4d57-ab1a-a386f2dcaa4f
# ╟─ceb25488-68fa-4d88-8097-9e2fe781b697
# ╟─cf0c31f4-afeb-4a0a-adec-3e1cb4a1a4d5
# ╟─92bef126-f26a-481c-b149-bce6cbacd42a
# ╟─a77841e6-860b-461c-bcc1-9e03dfabf942
# ╟─2082e84b-59a7-4cc0-ab6c-0366a5f65607
# ╟─043c237d-3fae-47ec-a51c-9e4727921852
# ╟─70cbe421-c024-4d1c-8d8d-ed4fe2bee218
# ╟─1bb0914c-95c1-4d71-84d7-68daf5adfaab
# ╟─79021008-77ea-4c2b-adde-1a11aa8c43a5
# ╟─b6ba494f-7637-49bc-be73-587e689d4b2e
# ╟─f882ba30-c947-11eb-0de0-5d1f64a57d99
# ╟─6f061530-c948-11eb-2a50-dd6855cd5dc2
# ╟─8959bcc0-c948-11eb-0802-7b5c027e751e
# ╟─95f2aeb0-c948-11eb-3cd9-87f0eedb4a32
# ╟─1651b060-c949-11eb-1a64-eb7370ec0e4b
# ╟─9d7eeb4f-d93b-4c30-bd27-a47ebfac8662
# ╟─4c0a1d74-ad9d-4453-88c9-09c6eeb0a8cf
# ╟─860a9d64-0ec9-4c06-b988-ad7cc597bb85
# ╟─a14f9acf-ee45-4315-8df7-5c53e3c6268b
# ╟─1694d97c-0e97-4244-8a75-f1d9219f883b
# ╟─e07fb4ab-6216-44b2-b2bc-4bc91b9922cd
# ╟─ba9af59f-d460-447d-8215-d8f16c26f0f5
# ╟─650461cb-cea8-4df7-9684-07fdd31e632e
