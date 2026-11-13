extends Node2D

@onready var tutorial_room: Node2D = get_node("TutorialRoom")
@onready var tutorial_timer: Timer = get_node("TutorialTimer")
@onready var text_box: AnimatedSprite2D = get_node("UI/TextBox")

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
		text_box.display_text("Hello and welcome. We will teach you how to move, to fight, to protect us, before your body is fully implemented. You will be able to move shortly.")


func _on_tutorial_timer_timeout() -> void:
	tutorial_step += 1
	match tutorial_step:
		1:
			#movement
			Game.player.stunned = false
			text_box.display_text("First, use WASD to move. Familarise yourself with fast, precise movement.")
		2:
			#attacking
			Game.player.in_game = true
			text_box.display_text("Your fuel will continuously drain due to design limitations. Left click to attack enemies and take fuel from them. You can hold left click to charge a stronger attack.")
		3:
			#passive enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.CRAWLER)
			text_box.display_text("Some enemies do not attack you intentionally. They are a great source of fuel.")
		4:
			#hostile enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.FLYING_CREATURE)
			text_box.display_text("There are enemies that actively seek to fight you. Do not try talking it out.")
		5:
			#ranged enemies
			tutorial_room.tutorial_spawn_enemy(tutorial_room.ENEMY_SCENES.GOBLIN)
			text_box.display_text("There are also enemies that are intelligent enough to develop and use crude tools to attack you.")
		6: 
			#player has diff weapons / tools
			tutorial_room._spawn_weapon()
			text_box.display_text("On your journey, you may find new powerful tools and weapons. Scroll to swap between them, press Q to drop. Use these to your advantage.")
		7:
			#heals and traps
			#make them invis then visible
			tutorial_room.activate_traps_and_heals()
			text_box.display_text("You may encounter traps set for you. Stay vigilant and avoid them. You may also encounter unused fuel, which you should take.")
		8:
			#spook player out with boss
			text_box.display_text("Sometimes, you may encounter very powerful enemies that return much more than fuel upon their defeat. However, we do not have full data of these enemies, and cannot simulate them.")
		9:
			#player dies and respawns
			if experienced_death:
				tutorial_timer.wait_time = 10
				text_box.display_text("Welcome back! Of course, that defeat was simulated and you were never in real danger.")
			else:
				Game.player.invincible = false
				tutorial_timer.wait_time = 9999
				Game.player.hp += 5
				text_box.display_text("Defeat is sometimes inevitable, in which case, we will repair you and you can return to the nearest safe area to continue your journey.")
		10:
			Game.player.stunned = false
			Game.player.in_game = true
			Game.player.invincible = true
			tutorial_room.num_enemies = 0
			tutorial_timer.wait_time = 30
			text_box.display_text("If you find a safe area, light a safety beacon, so our scientists can set up camp there. This allows us to drop you off at the midpoint of your journey, as opposed to the beginning.")
			#safety beacons
		11:
			SaveFile.mark_tutorial_completed()
			tutorial_room._open_doors()
			text_box.display_text("This is all you need to know for now. Step through the gate and join us.")
	if tutorial_step < 11:
		tutorial_timer.start()
