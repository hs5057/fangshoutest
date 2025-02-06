extends Node

signal enemies_changed(enemies)
signal enemies_count_changed(enemies_count)

var enemies : Array[Enemy] = [] :
	set(value):
		if enemies != value:
			enemies = value
			emit_signal("enemies_changed",enemies)
			
var enemies_count : int = 0 :
	set(value):
		if enemies_count != value:
			enemies_count = value
			emit_signal("enemies_count_changed",enemies_count)
