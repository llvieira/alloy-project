module volleyball


-- ASSINATURAS

one sig Campeonato {
	jogos: set Jogo
}

sig Time {
	jogadoresTitulares: set Jogador,
	jogadoresReservas: set Jogador,
	regiao: one Regiao
}

sig Jogo {
	timeMandante: one Time,
	timeVisitante: one Time,
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

-- FATOS

fact TimeFatos{

	#Campeonato = 1
	#Time = 4

	all t: Time | one (t.~timeMandante + t.~timeVisitante)
	all t: Time | one t.regiao
	all t: Time | #(getJogadoresTitulares[t]) = 1
	all t: Time | #(getJogadoresReservas[t]) >= 2 && #(getJogadoresReservas[t]) =< 3

}

fact JogadorFatos {

	all j: JogadorMaiorIdade | one (j.~jogadoresTitulares + j.~jogadoresReservas)
	all j: JogadorMenorIdade, t: Time | not ( jogadorEhTitular[j, t] || jogadorEhReserva[j, t] )
	all j: JogadorMaiorIdade, t: Time | not ( jogadorEhTitular[j, t] && jogadorEhReserva[j, t] )
	all j: Jogador | one j.regiao
	all j: Jogador, t: Time | ( jogadorNoTime[j, t] => j.regiao = t.regiao)
}

fact JogoFatos {

	all j: Jogo | one j.~jogos
	all j: Jogo, t1: Time, t2: Time | ( timeEhMandante[j, t1] && timeEhVisitante[j, t2] => t1.regiao = t2.regiao && t1 != t2) 
}


-- PREDICADOS 

pred jogadorNoTime[j: Jogador, t: Time] {
	j in getJogadores[t]
}

pred jogadorEhTitular[j: Jogador, t: Time] {
	j in getJogadoresTitulares[t]
}

pred jogadorEhReserva[j: Jogador, t: Time]{
	j in getJogadoresReservas[t]
}

pred timeEhMandante[j: Jogo, t: Time]{
	t in getTimeMandante[j]
}

pred timeEhVisitante[j: Jogo, t: Time]{
	t in getTimeVisitante[j]
}



-- FUNÇOES

fun getJogadores[t: Time] : set Jogador {
	t.jogadoresTitulares + t.jogadoresReservas
}

fun getJogadoresTitulares[t: Time] : set Jogador {
	t.jogadoresTitulares
}

fun getJogadoresReservas[t: Time] : set Jogador {
	t.jogadoresReservas
}

fun getTimeMandante[j: Jogo] : one Time{
	j.timeMandante
}

fun getTimeVisitante[j: Jogo] :  one Time{
	j.timeVisitante
}




pred show[] { }


run show for 25
