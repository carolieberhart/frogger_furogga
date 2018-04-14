
# == move_frog ===============================
# recebe matriz que representa o mapa e a direção como string
# limpar a tela

function move_frog(m, left, right, up, down) 
	position = find(x -> x == "W", m) # Encontra posicao do sapo na matriz
	m[position] = "." # 'Remove' sapo daquela posição (TODO: deveria ser subsituido por o caracter de acordo com o devido 'terreno' que o sapo se encontra)
	y,x = ind2sub(m,position) # Converte posicao de indice em posicao representação por tupla
	new_x_pos = x + right - left
	new_y_pos = y + down - up
	# check_for_colisions() Chama metodo que verifica colisoes e etc...
	m[new_y_pos, new_x_pos] = "W"
	print_map(m)
	return m
end
# ========================================

# == clear ===============================
# chama "clear" no terminal para
# limpar a tela

function clear()
	run(`clear`) # run(x) chama o comando x direto no terminal
end

# == print_map ===============================
# Recebe matriz que representa o mapa do jogo
# Printa essa matriz
function print_map(map)
	clear()
	for j = 1:size(map,1)
		for i = 1:size(map,2)
			print(map[j,i])
		end
		print("\n\r") # quando stty raw ta ativado, temos que usar \n e \r 
		# para ir para uma nova linha (\n\r = CRLF)
	end
end
# ========================================

m = readdlm("map.txt")
print_map(m)

while true

	run(`stty raw`)	# stty raw faz com que, alem de nao dar echo no terminal,
				# tambem libere o STDIN sem precisar dar enter,
				# ou seja, pega o primeiro caractere digitado e manda.

	# == getch ===============================
	# essa rotina permite que a gente
	# consiga pegar a tecla que o usuario
	# digita no teclado sem que a tecla 
	# de echo no terminal.

	user_input = '+'	# + eh um caractere qualquer que serve de placeholder
						# enquanto o usuario nao digita nada.
	    
	@async user_input = read(STDIN, Char)	# @async faz com que a chamada de read(),
											# que devolve o que foi digitado pelo teclado,
											# possa continuar no background, sem trancar 
											# a execucao do resto do game.
	# ========================================

	# == update ==============================
	# essa rotina serve para atualizar tudo que acontece no jogo
	while(user_input == '+')
		
		print("")	# precisa existir uma funcao que "faz algo"
					# para que o @async funcione

		if(user_input == 'a')
			m = move_frog(m, 1, 0, 0, 0)

		elseif(user_input == 's')
			m = move_frog(m, 0, 0, 0, 1)

		elseif(user_input == 'd')
			m = move_frog(m, 0, 1, 0, 0)

		elseif(user_input == 'w')
			m = move_frog(m, 0, 0, 1, 0)

		elseif(user_input == 'q')
			print("QUIT GAME \n\r")
			run(`stty cooked`)
			exit()
		end
	end
	# ========================================
end














