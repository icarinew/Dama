player = {id = "",pecas = 12, pontuacao = 0}

--Coloca as peças no tabuleiro
function player:putPiece(board, playerr)
	if playerr.id == 1 then
		for i = 1, 3 do
			for j = 1, 8 do
					if j == 1 and i%2==1 then
						board[i][j] = "[b]"		 
					elseif board[i][j-1] == "[ ]" then
						board[i][j] = "[b]"
					else
						board[i][j] = "[ ]"
					end 
			end
		end  
	else
		for i = 6, 8 do
				for j = 1, 8 do
						if j == 1 and i%2==1 then
							board[i][j] = "[a]"		 
						elseif board[i][j-1] == "[ ]" then
							board[i][j] = "[a]"
						else
							board[i][j] = "[ ]"
						end 
				end
			end  
	end	
end

--Função que pontua os jogadores
function player:toScore(element)
	if element == "[b]" then
		player1.pontuacao = player1.pontuacao + 1
		player2.pecas = player2.pecas - 1
	else
		player2.pontuacao = player2.pontuacao + 1
		player1.pecas = player1.pecas - 1
	end
end

return player
