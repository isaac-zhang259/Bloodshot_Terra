extends CanvasLayer

const MIN_HEALTH: int = 1

var max_hp: int = 20
var local_hp: int = 20

var boss: CharacterBody2D
var past_check: CharacterBody2D
@onready var health_bar: TextureProgressBar = get_node("BossHealthBar")

func _ready() -> void:
	health_bar.hide()
	
func _process(_delta: float) -> void:
	boss = Game.boss
	if boss != null:
		if boss.dead:
			health_bar.hide()
	if boss != null and past_check == null:
		_update_health_bar(100)
		health_bar.show()
	past_check = boss
	if boss != null:
		if boss.hp != local_hp:
			var new_health: int = int((100 - MIN_HEALTH) * float(boss.hp) / max_hp) + MIN_HEALTH
			_update_health_bar(new_health)
	
	
func _update_health_bar(new_value: int) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(health_bar, "value", new_value, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
