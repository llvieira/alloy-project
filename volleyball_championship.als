module volleyball

one sig Campeonato {
	times: set Time
}

sig Time {
	jogadoresTitulares: set JogadorTitular,
	jogadoresReservas: set JogadorReserva,
	regiao: one Regiao
}


abstract sig  Jogador{
--	idade: one Int,
	regiao: one Regiao
}

sig JogadorTitular extends Jogador {}

sig JogadorReserva extends Jogador {}

--sig Idade {
--	valor: one Int
--}

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
	#Time = 2

--  Fatos dos times
	all t: Time | one t.~times
--	all t: Time | some t.jogadores
	all t: Time | one t.regiao
	all t: Time | #(t.jogadoresTitulares) = 1
	all t: Time | #t.jogadoresReservas >= 2 && #t.jogadoresReservas =< 3

-- Fatos dos jogadores
	all j: JogadorTitular | one j.~jogadoresTitulares
	all j: JogadorReserva | one j.~jogadoresReservas
	all j: Jogador | one j.regiao
	all j: Jogador, t: Time | (j in t.jogadoresTitulares => j.regiao = t.regiao) 
	&& (j in t.jogadoresReservas => j.regiao = t.regiao)
-- Fatos das idades
--	all i: Idade | one i.~idade
}

pred show[] {}

run show for 25
