board = {}

--Cria um novo tabuleiro
function board:newBoard()
  for i=1, 8 do
      board[i] = {}
      for j=1, 8 do
        board[i][j] = {}
      end 
  end
end 

--Mostra o tabuleiro
function board:showBoard()
  local tab = ""
	local num = "  "
	for i = 1, 8 do
		num = num.." "..i.." "
	end
	print(num)
  for i = 1, 8 do
    for j = 1, 8 do
				if(j == 8) then
					tab = tab..board[i][j].."\n" 
				elseif(j == 1) then
					tab = tab..i.." "..board[i][j]
				else
				tab = tab..board[i][j]
				end
    end  
  end
  return tab
end  

--Preenche o tabuleiro(Xadrez)
function board:fillBoard()
		for i = 1, 8 do
			for j = 1, 8 do
				if j == 1 and i%2==1 then
					board[i][j] = "[#]"		 
				elseif board[i][j-1] == "[ ]" then
					board[i][j] = "[#]"
				else
					board[i][j] = "[ ]"
				end 
			end
		end  	
end

--Função que testa se a posição pretendida é inválida
function board:isInvalid(newPosition)
	if board[newPosition.line][newPosition.column] == "[ ]" or board[newPosition.line][newPosition.column] == "[b]" or board[newPosition.line][newPosition.column] == "[a]" then
		return true
	else
		return false	
	end
end

return board
