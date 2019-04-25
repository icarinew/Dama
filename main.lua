--Função que dá início ao jogo
function start(board, player1, player2)
	board:newBoard()
	board:fillBoard()
	player:putPiece(board, player1)
	player:putPiece(board, player2)
	print(board:showBoard())
end

--Função que pede a localização atual da peça a ser movida
function askCurrentLocation()
	local location = {line, column}
	print("Qual a posição da linha que a peça está agora?")
	location.line = io.read("*n")
	print("Qual a posição da coluna que a peça está agora?")
	location.column = io.read("*n")
	return location
end

--Função que pede a localização futura da peça a ser movida
function askMove()
	local location = {line, column}
	print("Qual a posição da linha que a peça vai?")
	location.line = io.read("*n")
	print("Qual a posição da coluna que a peça vai?")
	location.column = io.read("*n")
	return location
end

--Função que muda a posição da peça
function changePosition(oldPosition, newPosition, board)
	jog = board[oldPosition.line][oldPosition.column]
	
	board[oldPosition.line][oldPosition.column] = "[#]"
	if jog == "[a]" then
		board[newPosition.line][newPosition.column] = "[a]"
	elseif jog == "[b]" then
		board[newPosition.line][newPosition.column] = "[b]"
	elseif jog == "[A]"	then
		board[newPosition.line][newPosition.column] = "[A]"
	elseif jog == "[B]"	then
		board[newPosition.line][newPosition.column] = "[B]"	
	end
end

--Função que pega a linha da peça comida
function findLine(oldPosition, newPosition)
	local line
	if oldPosition.line < newPosition.line then
		for i = oldPosition.line, newPosition.line do
			if i > oldPosition.line and i < newPosition.line then
				line = i
			else
			end
		end
	else
		for i = oldPosition.line, newPosition.line, -1 do
			if i < oldPosition.line and  i > newPosition.line then
				line = i
			else
			end
		end
	end
	return line
end

--Função que pega a coluna da peça comida
function findColumn(oldPosition, newPosition)
	local column
	if oldPosition.column < newPosition.column then
		for i = oldPosition.column, newPosition.column do
			if i > oldPosition.column and i < newPosition.column
		 then
				column = i
			else
			end
		end
	else
		for i = oldPosition.column, newPosition.column, -1 do
			if i < oldPosition.column and i%2 == 0 and i > newPosition.column then
				column = i
			elseif i < oldPosition.column and i%2 == 1 and i > newPosition.column then
				column = i
			end
		end
	end
	return column
end

--Função que checa se há alguma peça a ser comida
function check(oldPosition, newPosition, board)
	local line
	local column
	local teste = oldPosition.line - newPosition.line
	
		if teste > 1 or teste < -1 then
	
				line = findLine(oldPosition, newPosition)
				column = findColumn(oldPosition, newPosition)
				element = board[line][column]
				board[line][column] = "[#]"
				player:toScore(element)
		end
end

--Função que checa se é fim de jogo
function endGame(player)
		if player.pontuacao == 12 then
			return true
		else
			return false
		end	
end

function king(newPosition, board)
	line = newPosition.line
	column = newPosition.column
	element = board[line][column]
	if element == "[a]" and line == 1 then
		board[line][column] = "[A]"
	elseif element == "[b]" and line == 8 then
		board[line][column] = "[B]"	
	end	
end

local board = require("board")
local player = require("player")

player1 = {id = 1, pecas = 12, pontuacao = 0}
player2 = {id = 2, pecas = 12, pontuacao = 0}

start(board, player1, player2)

opc = 0
--Execução do jogo
repeat
	repeat
		vezUm = true
		print("Vez do jogador 1")
		player = player1
		oldPosition = askCurrentLocation()
		newPosition = askMove()
		if board:isInvalid(newPosition) then
			vezUm = true
			print("Posição inválida, tente novamente.")
		else	
			changePosition(oldPosition, newPosition, board)
			king(newPosition, board)
			check(oldPosition, newPosition, board)
			print(board:showBoard())
			vezUm = false
		end	
	until(vezUm ~= true)

	print("Player 1:"..player1.pontuacao)
	print("Player 2:"..player2.pontuacao)

	--Testa se o jogo acabou
			if endGame(player1) then
				print("FIM DE JOGO")
				break
			end	

	repeat
		vezDois = true
		print("Vez do jogador 2")
		player = player2
		oldPosition = askCurrentLocation()
		newPosition = askMove()
		if board:isInvalid(newPosition) then
			vezDois = true
			print("Posição inválida, tente novamente.")
		else	
			changePosition(oldPosition, newPosition, board)
			king(newPosition, board)
			check(oldPosition, newPosition, board)
			print("Player 1:"..player1.pontuacao)
			print("Player 2:"..player2.pontuacao)
			print(board:showBoard())
			vezDois = false
		end
	
	until(vezDois ~= true)

		--Testa se o jogo acabou
		if endGame(player2) then
				print("FIM DE JOGO")
				break
			end

until(opc ~= 0)
