extends Node2D

@onready var tutorial_room: Node2D = get_node("TutorialRoom")
@onready var tutorial_timer: Timer = get_node("TutorialTimer")

var tutorial_step: int = 0

func _process(_delta: float) -> void:
	if tutorial_step < 11:
		if tutorial_timer.time_left <= 0:
			tutorial_timer.start()

func _on_tutorial_timer_timeout() -> void:
	tutorial_step += 1
	match tutorial_step:
		1:
			#player moves around
			pass
		2:
			#player attacks
			pass
		3:
			#player has diff weapons / tools
			pass
		4:
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.CRAWLER)
		5:
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.FLYING_CREATURE)
		6: 
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.GOBLIN)
		7:
			#spook player out with boss
			pass
		8:
			#heals and traps
			pass
		9:
			#player dies and respawns
			pass
		10:
			#safety beacons
			pass
