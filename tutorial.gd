extends Node2D

@onready var tutorial_room: Node2D = get_node("TutorialRoom")
@onready var tutorial_timer: Timer = get_node("TutorialTimer")
@onready var dialogue_panel: Sprite2D = get_node("UI/TutorialTextbox")

var tutorial_step: int = 0
var experienced_death: bool = false

func _ready() -> void:
	Game.player.in_game = false
	Game.player.stunned = true
	Game.player.invincible = true
	if SavedData.doing_tutorial:
		experienced_death = true
		tutorial_step = 8
		tutorial_timer.wait_time = 1
		print("after death")
	else:
		SavedData.doing_tutorial = true
		print("first time")
	tutorial_timer.start()
	if tutorial_step == 0:
		dialogue_panel.display_text("Hello. We will teach you how to move, to fight, to protect us. You will be able to move shortly.")


func _on_tutorial_timer_timeout() -> void:
	tutorial_step += 1
	match tutorial_step:
		1:
			#movement
			Game.player.stunned = false
			dialogue_panel.display_text("First, use WASD to move.")
		2:
			#attacking
			Game.player.in_game = true
			dialogue_panel.display_text("Your fuel will continuously drain. Left click to attack enemies and take fuel from them. You can hold left click to charge a stronger attack.")
		3:
			#passive enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.CRAWLER)
			dialogue_panel.display_text("Some enemies do not attack you intentionally. They are a great source of fuel.")
		4:
			#hostile enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.FLYING_CREATURE)
			dialogue_panel.display_text("There are enemies that actively seek to fight you. Do not try talking it out.")
		5:
			#ranged enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.GOBLIN)
			dialogue_panel.display_text("There are also enemies that are intelligent enough to develop and use crude tools to attack you.")
		6: 
			#player has diff weapons / tools
			tutorial_room._spawn_weapon()
			dialogue_panel.display_text("On your journey, you may find new powerful tools and weapons. Use these to your advantage.")
		7:
			#heals and traps
			#make them invis then visible
			tutorial_room.activate_traps_and_heals()
			dialogue_panel.display_text("You may encounter traps set for you. Stay vigilant and avoid them. You may also encounter unused fuel, which should be taken.")
			pass
		8:
			#spook player out with boss
			dialogue_panel.display_text("Sometimes, you may encounter very powerful enemies that return much more than fuel upon their defeat.")
			pass
		9:
			#player dies and respawns
			if experienced_death:
				tutorial_timer.wait_time = 10
				dialogue_panel.display_text("Welcome back! Of course, that defeat was simulated and you were never in danger.")
			else:
				Game.player.invincible = false
				tutorial_timer.wait_time = 9999
				Game.player.hp += 5
				dialogue_panel.display_text("Defeat is sometimes inevitable, in which case, we will repair you at the nearest safe area.")
		10:
			Game.player.stunned = false
			Game.player.in_game = true
			Game.player.invincible = true
			tutorial_room.num_enemies = 0
			tutorial_timer.wait_time = 30
			dialogue_panel.display_text("If you find a safe area, light a safety beacon, so our scientists can set up camp there. This allows us to repair you at the midpoint of your journey, as opposed to the beginning.")
			#safety beacons
			#gotta add them first before this bro
		11:
			SaveFile.mark_tutorial_completed()
			tutorial_room._open_doors()
			dialogue_panel.display_text("This is all you need to know for now. Step through the gate and join us.")
	if tutorial_step < 11:
		tutorial_timer.start()
