extends Area2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")

@export var opul: bool = false
@export var anima: bool = false
@export var acceleration: int = 2
@export var max_speed: int = 10

var follow_player: bool = false

var direction: Vector2 = Vector2.ZERO
var speed: int = 0

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		collision_shape.set_deferred("disabled", true)
		if opul:
			SavedData.per_run_currency += 1
		elif anima:
			SavedData.per_save_currency += 1
		self.queue_free()
		
func _physics_process(_delta: float) -> void:
	if speed > 0:
		speed -= 1
	if follow_player:
		direction = (Game.player.position - global_position).normalized()
		speed = 4
	position += direction * speed * 0.1
	

func launch() -> void:
	direction = Vector2.from_angle(randf_range(0, 2 * PI))
	rotation_degrees = randi_range(0, 360)
	speed = randi_range(10, 15)


func _on_player_detector_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		follow_player = true
		self.set_collision_layer_value(1, false)
		self.set_collision_mask_value(1, false)
