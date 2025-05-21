extends CharacterBody2D

var gravidade = 500

func _physics_process(delta: float) -> void:
	velocity.y += gravidade * delta
	set_rotation(velocity.y / 100)
	move_and_slide()

func _input(event):
	if (event is InputEventKey and event.keycode == KEY_SPACE) and event.pressed:
		velocity.y = -gravidade / 2
