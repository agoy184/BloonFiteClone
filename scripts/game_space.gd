extends Node2D

@export_subgroup("Nodes")
@export var player_hurtbox: HurtboxComponent
@export var enemy_hurtbox: HurtboxComponent
@export var game_over_screen: GameOverScreen

var _game_ended: bool = false

func _ready() -> void:
	player_hurtbox.died.connect(_on_player_died)
	enemy_hurtbox.died.connect(_on_enemy_died)

func _on_player_died() -> void:
	_end_game("Game Over")

func _on_enemy_died() -> void:
	_end_game("You Win!")

func _end_game(text: String) -> void:
	if _game_ended:
		return
	_game_ended = true
	game_over_screen.show_result(text)

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
