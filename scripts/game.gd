extends Node
## Global game state: level progression, audio settings, and persistence.
## Registered as the "Game" autoload singleton.

const SAVE_PATH := "user://savegame.cfg"

const MAIN_MENU := "res://scenes/ui/main_menu.tscn"
const LEVEL_SELECT := "res://scenes/ui/level_select.tscn"

# Level registry. Append entries here to add more levels; the rest of the
# progression system scales automatically.
var levels := [
	{ "id": "level_1", "name": "Level 1", "scene": "res://scenes/game_space.tscn" },
]

var completed := {}        # id (String) -> true
var master_volume := 1.0   # linear 0..1


func _ready() -> void:
	_load()
	apply_master_volume(master_volume)


# --- progression ---------------------------------------------------------

func is_completed(id: String) -> bool:
	return completed.get(id, false)


func mark_completed(id: String) -> void:
	completed[id] = true
	_save()


## First registered level that hasn't been completed. If every level is
## complete, falls back to the last level so Play always has a destination.
func get_earliest_uncompleted() -> Dictionary:
	for level in levels:
		if not is_completed(level.id):
			return level
	return levels[-1]


func play_level(id: String) -> void:
	for level in levels:
		if level.id == id:
			get_tree().change_scene_to_file(level.scene)
			return
	push_error("Game.play_level: unknown level id '%s'" % id)


func play_earliest() -> void:
	play_level(get_earliest_uncompleted().id)


# --- audio ---------------------------------------------------------------

func apply_master_volume(v: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(maxf(v, 0.0001)))


func set_master_volume(v: float) -> void:
	master_volume = clampf(v, 0.0, 1.0)
	apply_master_volume(master_volume)
	_save()


# --- persistence ---------------------------------------------------------

func _save() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("progress", "completed_ids", completed.keys())
	cfg.set_value("audio", "master", master_volume)
	cfg.save(SAVE_PATH)


func _load() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) != OK:
		return
	completed.clear()
	for id in cfg.get_value("progress", "completed_ids", []):
		completed[id] = true
	master_volume = cfg.get_value("audio", "master", 1.0)
