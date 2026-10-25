extends CanvasLayer

var new_scene: String

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func start_transition_to(path_to_scene: String) -> void:
	new_scene = path_to_scene
	animation_player.play("change_scene")
	if Game.player.hp <= 0:
		SavedData.num_floor = 0
		SavedData.max_hp = 16
		SavedData.hp = 8
		SavedData.weapons = []
		SavedData.equipped_weapon_index = 0
	
func change_scene() -> void:
	assert(get_tree().change_scene_to_file(new_scene) == OK)
