extends Area2D
class_name Balloon

enum PopMode { FEET_AREA, BODY_OVERLAP }

@export_subgroup("Settings")
@export var pop_mode: PopMode = PopMode.FEET_AREA
@export var radius: float = 18.0
@export var color: Color = Color(0.9, 0.3, 0.4)

## The character this balloon belongs to. Contact from this character is ignored
## so a character never pops its own balloons.
var owner_character: Node2D

signal popped(balloon: Balloon)

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)
	queue_redraw()

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 24, Color.BLACK, 1.5)

func _on_area_entered(area: Area2D) -> void:
	if pop_mode != PopMode.FEET_AREA:
		return
	if area.owner == owner_character:
		return
	pop()

func _on_body_entered(body: Node2D) -> void:
	if pop_mode != PopMode.BODY_OVERLAP:
		return
	if body == owner_character:
		return
	pop()

func pop() -> void:
	popped.emit(self)
	queue_free()
