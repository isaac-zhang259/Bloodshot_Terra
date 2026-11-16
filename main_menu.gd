extends Control
	
@onready var main_theme: Theme = preload("res://main_theme.tres")
	
@onready var options_popup: PopupPanel = get_node("OptionsPopup")

var fonts: Array = [preload("res://Art/my own art :thumbsup:/smart guy font.ttf"), preload("res://Art/my own art :thumbsup:/more legible font.ttf")]
var chosen_font: int = 0

func _ready() -> void:
	chosen_font = SaveFile.fetch_font_choice()
	main_theme.default_font = fonts[chosen_font]

func _on_start_pressed() -> void:
	if SaveFile.is_tutorial_complete():
		SceneTransistor.start_transition_to("res://pre_game_area.tscn")
		#SceneTransistor.start_transition_to("res://game.tscn")
	else:
		SceneTransistor.start_transition_to("res://tutorial.tscn")
	
func _on_options_pressed() -> void:
	options_popup.popup_centered()
	
func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_default_pressed() -> void:
	chosen_font = 0

func _on_legible_pressed() -> void:
	chosen_font = 1
	
func _on_apply_pressed() -> void:
	main_theme.default_font = fonts[chosen_font]
	SaveFile.save_font_choice(chosen_font)

func _on_close_pressed() -> void:
	options_popup.hide()
