module volleyball

sig string{}

sig Campeonato {
	times: set Time
}

sig Time {
	jogadores: set Jogador
--	regiao: one Regiao
}

sig Jogador{
	idade: one Idade,
	regiao: one Regiao
}

sig Idade {
	valor: Int
}

abstract sig Regiao{
}

sig Norte extends Regiao {
}

sig Sul extends Regiao {
}

sig Leste extends Regiao {
}

sig Oeste extends Regiao {
}

sig Centro extends Regiao {
}

pred show[] {}

run show for 3
