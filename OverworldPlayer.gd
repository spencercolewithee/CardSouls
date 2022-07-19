extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var SPEED = 500
var ACCEL = 2000
var motion = Vector2()

func _physics_process(delta):
	var direction = get_input()
	#used to determine what angle to move
	if direction == Vector2.ZERO:
		apply_friction(ACCEL * delta)
	else:
		apply_movement(direction * ACCEL * delta)
	motion = move_and_slide(motion)

func get_input():
	#local dir var, will get passed into direction above
	var dir = Vector2.ZERO
	#take input from direction right and subtract from direction left and calc x angle
	dir.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	#take input from direction down and subtract from up left and calc y angle
	dir.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	#normalize vector so diagonals go the correct distance.
	return dir.normalized()

#amount being amount of friction allowed
func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(distance):
	motion += distance
	#if motion is going too fast, take the angle and multiply it by max speed
	if motion.length() > SPEED:
		motion = motion.normalized() * SPEED

func _on_Coin_area_entered(_area):
	#print("entered coin")
	Playerstats.money += 2
	get_parent().get_child(3).queue_free()



