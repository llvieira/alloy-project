module volleyball

one sig Campeonato {
	times: set Time
}

sig Time {
	jogadores: some Jogador,
	regiao: one Regiao
}

sig Jogador{
	idade: one Idade,
	regiao: one Regiao
}

sig Idade {
	valor: one Int
}

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
	all t: Time | one t.~times
	all t: Time | some t.jogadores
	all t: Time | one t.regiao
	all t: Time | #t.jogadores >= 2 && #t.jogadores =< 3

-- Fatos dos jogadores
	all j: Jogador | one j.~jogadores
	all j: Jogador | one j.regiao
	all j: Jogador, t: Time | j in t.jogadores => j.regiao = t.regiao

-- Fatos das idades
	all i: Idade | one i.~idade
}

pred show[] {}

run show for 25
