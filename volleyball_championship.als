module volleyball

one sig Campeonato {
	jogos: set Jogo
}

sig Time {
	jogadoresTitulares: set Jogador,
	jogadoresReservas: set Jogador,
	regiao: one Regiao
}

sig Jogo {
	timeCasa: one Time,
	timeFora: one Time,
}


abstract sig  Jogador{
	regiao: one Regiao
}

sig JogadorMaiorIdade extends Jogador {}

sig JogadorMenorIdade extends Jogador {}

abstract sig Regiao{
}

one sig Norte extends Regiao {
}

one sig Sul extends Regiao {
}

one sig Leste extends Regiao {
}

one sig Oeste extends Regiao {
}

one sig Centro extends Regiao {
}

fact LimiteTimes{
	#Campeonato = 1
	#Time = 4

--  Fatos dos times
	all t: Time | one (t.~timeCasa + t.~timeFora)
	all t: Time | one t.regiao
	all t: Time | #(t.jogadoresTitulares) = 1
	all t: Time | #t.jogadoresReservas >= 2 && #t.jogadoresReservas =< 3

-- Fatos dos jogadores
	all j: JogadorMaiorIdade | one (j.~jogadoresTitulares + j.~jogadoresReservas)
	all j: JogadorMenorIdade, t: Time | not (j in t.jogadoresTitulares || j in t.jogadoresReservas )
	all j: JogadorMaiorIdade, t: Time | not (j in t.jogadoresTitulares && j in t.jogadoresReservas)
	all j: Jogador | one j.regiao
	all j: Jogador, t: Time | (j in t.jogadoresTitulares => j.regiao = t.regiao) 
	&& (j in t.jogadoresReservas => j.regiao = t.regiao)

-- Fatos dos Jogos

	all j: Jogo | one j.~jogos
	all j: Jogo, t1: Time, t2: Time | (t1 in j.timeCasa && t2 in j.timeFora => t1.regiao = t2.regiao && t1 != t2) 

}

pred show[] {}

run show for 25
