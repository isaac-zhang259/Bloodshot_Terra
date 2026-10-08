extends CharacterBody2D

var speed : float = 150

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	move_and_collide(velocity * delta)
