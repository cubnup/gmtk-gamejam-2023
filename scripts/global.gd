extends Node

var bro
var flower
var puspawner
var enemanager
var score = 0
var wave = 0

func waveup():
	wave+=1
	puspawner.probs[0] *=0.8
	puspawner.probs[0] = max(1,puspawner.probs[0])
	
