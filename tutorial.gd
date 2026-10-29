extends Node2D

@onready var tutorial_room: Node2D = get_node("TutorialRoom")
@onready var tutorial_timer: Timer = get_node("TutorialTimer")
@onready var dialogue_panel: Panel = get_node("UI/DialoguePanel")

var tutorial_step: int = 0
var experienced_death: bool = false

func _ready() -> void:
	Game.player.in_game = false
	Game.player.stunned = true
	Game.player.invincible = true
	if SavedData.doing_tutorial:
		experienced_death = true
		tutorial_step = 8
		print("after death")
	else:
		SavedData.doing_tutorial = true
		print("first time")
	tutorial_timer.start()
	if tutorial_step == 0:
		dialogue_panel.display_text("hello. this is the tutorial area. we will teach you how to not be useless")


func _on_tutorial_timer_timeout() -> void:
	tutorial_step += 1
	match tutorial_step:
		1:
			#movement
			Game.player.stunned = false
			dialogue_panel.display_text("use WASD to move")
		2:
			#attacking
			Game.player.in_game = true
			dialogue_panel.display_text("left click to attack, hold to charge a stronger attack")
		3:
			#passive enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.CRAWLER)
			dialogue_panel.display_text("there are enemies that do not attack you intentionally")
		4:
			#hostile enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.FLYING_CREATURE)
			dialogue_panel.display_text("there are enemies that actively hunt you")
		5:
			#ranged enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.GOBLIN)
			dialogue_panel.display_text("there are enemies that have enough intelligence to use dangerous tools")
		6: 
			#player has diff weapons / tools
			tutorial_room._spawn_weapon()
			dialogue_panel.display_text("on your journey you may find new tools")
		7:
			#heals and traps
			#make them invis then visible
			tutorial_room.activate_traps_and_heals()
			dialogue_panel.display_text("you may also encounter set traps, or find free fuel")
			pass
		8:
			#spook player out with boss
			dialogue_panel.display_text("sometimes there are powerful enemies guarding powerful abilities")
			pass
		9:
			#player dies and respawns
			if experienced_death:
				tutorial_timer.wait_time = 5
				dialogue_panel.display_text("welcome back! was it enjoyable?")
			else:
				Game.player.invincible = false
				tutorial_timer.wait_time = 9999
				dialogue_panel.display_text("defeat is sometimes inevitable, in which case we will do our best to piece you back together.")
		10:
			tutorial_timer.wait_time = 20
			Game.player.stunned = false
			Game.player.in_game = true
			Game.player.invincible = true
			tutorial_room.num_enemies = 0
			dialogue_panel.display_text("should you reach a safe enough area, activate a safety beacon for our scientists to set up a camp at. this allows us to reassemble closer to the area you were defeated in")
			#safety beacons
			#gotta add them first before this bro
		11:
			SaveFile.mark_tutorial_completed()
			tutorial_room._open_doors()
			dialogue_panel.display_text("you have now learnt everything you need to know for now, you may truly join us")
	if tutorial_step < 11:
		tutorial_timer.start()
