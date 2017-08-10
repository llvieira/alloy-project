module volleyball

one sig Campeonato {
	times: set Time
}

sig Time {
	jogadores: some Jogador
--	regiao: one Regiao
}

sig Jogador{
--	idade: one Idade,
--	regiao: one Regiao
}

--sig Idade {
--	valor: Int
--}

--abstract sig Regiao{
--}

--sig Norte extends Regiao {
--}

--sig Sul extends Regiao {
--}

--sig Leste extends Regiao {
--}

--sig Oeste extends Regiao {
--}

--sig Centro extends Regiao {
--}

fact LimiteTimes{
	#Campeonato = 1
	#Time = 2
--	#jogadores =< 24
	all t: Time | one t.~times
	all t: Time | some t.jogadores
	all t: Time | #t.jogadores >= 6 && #t.jogadores =< 12
	all j: Jogador | one j.~jogadores
}

pred show[] {}

run show for 30
