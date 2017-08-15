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
	#Time = 6

	all t: Time | one (t.~timeMandante + t.~timeVisitante)
	all t: Time | one t.regiao
	all t: Time | #(getJogadoresTitulares[t]) = 6
	all t: Time | #(getJogadoresReservas[t]) >= 0 && #(getJogadoresReservas[t]) =< 6

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


-- CRIAÇAO DO DIAGRAMA

pred show[] { }

run show for 50

--TESTES

assert todoJogoPertenceAoCampeonato {
	all t: Time | one (t.~timeMandante + t.~timeVisitante)
}

assert todoTimeTemJogador {
	all t: Time | #(getJogadoresTitulares[t]) = 6
	all t: Time | #(getJogadoresReservas[t]) >= 0 && #(getJogadoresReservas[t]) =< 6
}

assert todoJogoTemDoisTimes {
	all j: Jogo | one j.timeMandante
	all j: Jogo | one j.timeVisitante 
}

assert todoTimeDoJogoEhDaMesmaRegiao {
	all j: Jogo, t1: Time, t2: Time | ( timeEhMandante[j, t1] && timeEhVisitante[j, t2] => t1.regiao = t2.regiao && t1 != t2) 
}

assert todoJogadorTemAMesmaRegiaoDoTime {
	all j: Jogador, t: Time | ( jogadorNoTime[j, t] => j.regiao = t.regiao)
}

assert todoJogadorMaiorIdadeTemTime {
	all j: JogadorMaiorIdade | one (j.~jogadoresReservas + j.~jogadoresTitulares)
}

assert todoJogadorMenorIdadeNaoTemTime {
	all j: JogadorMenorIdade, t: Time | not (j in t.jogadoresReservas ||  j in t.jogadoresTitulares)
}

check todoJogoPertenceAoCampeonato for 50
check todoTimeTemJogador for 50
check todoJogoTemDoisTimes for 50
check todoTimeDoJogoEhDaMesmaRegiao for 50
check todoJogadorTemAMesmaRegiaoDoTime for 50
check todoJogadorMaiorIdadeTemTime for 50
check todoJogadorMenorIdadeNaoTemTime for 50


