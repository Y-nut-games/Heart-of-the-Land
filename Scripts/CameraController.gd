extends Camera2D

@onready var camera_2d: Camera2D = $"."

var zoomTarget : Vector2

var dragStartMousePos = Vector2.ZERO
var dragStartCameraPos = Vector2.ZERO
var isDragging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zoomTarget = zoom;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Zoom(delta)
	simplePan(delta)
	clickAndDrag()
	
func Zoom(delta):
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoomTarget *= 1.1
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoomTarget *= 0.9
	zoom = zoom.slerp(zoomTarget, 10*delta)
	
func simplePan(delta):
	var MoveAmount = Vector2.ZERO
	if Input.is_action_pressed("camera_right"):
		MoveAmount.x +=1
	if Input.is_action_pressed("camera_left"):
		MoveAmount.x -= 1
	if Input.is_action_pressed("camera_up"):
		MoveAmount.y -= 1
	if Input.is_action_pressed("camera_down"):
		MoveAmount.y += 1
	
	MoveAmount = MoveAmount.normalized()
	position += MoveAmount * delta * 1000 * (1/zoom.y)
		
func clickAndDrag():
	if !isDragging and Input.is_action_just_pressed("camera_pan"):
		dragStartMousePos = get_viewport().get_mouse_position()
		dragStartCameraPos = position
		isDragging = true
		
	if isDragging and Input.is_action_just_released("camera_pan"):
		isDragging = false
		
	if isDragging:
		var moveVector = get_viewport().get_mouse_position() - dragStartMousePos
		position = dragStartCameraPos - moveVector * 1/zoom.x
