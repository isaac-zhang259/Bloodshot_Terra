extends Node2D

@onready var tutorial_room: Node2D = get_node("TutorialRoom")
@onready var tutorial_timer: Timer = get_node("TutorialTimer")

var tutorial_step: int = 0
var experienced_death: bool = false

func _ready() -> void:
	Game.player.in_game = false
	Game.player.stunned = true
	Game.player.invincible = true
	if SavedData.doing_tutorial:
		experienced_death = true
		tutorial_step = 9
		print("after death")
	else:
		SavedData.doing_tutorial = true
		print("first time")
	tutorial_timer.start()


func _on_tutorial_timer_timeout() -> void:
	tutorial_step += 1
	match tutorial_step:
		1:
			#movement
			Game.player.stunned = false
		2:
			#attacking
			Game.player.in_game = true
		3:
			#passive enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.CRAWLER)
		4:
			#hostile enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.FLYING_CREATURE)
		5:
			#ranged enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.GOBLIN)
		6: 
			#player has diff weapons / tools
			pass
		7:
			#heals and traps
			pass
		8:
			#spook player out with boss
			pass
		9:
			if experienced_death:
				tutorial_timer.wait_time = 5
			else:
				Game.player.invincible = false
				tutorial_timer.wait_time = 9999
			#player dies and respawns
			#this might be a bit hard to make ngl
		10:
			tutorial_timer.wait_time = 10
			Game.player.stunned = false
			Game.player.in_game = true
			Game.player.invincible = true
			#safety beacons
			#gotta add them first before this bro
		11:
			SavedData.did_tutorial = true
			tutorial_room._open_doors()
	if tutorial_step < 11:
		tutorial_timer.start()
