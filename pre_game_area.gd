extends Node2D

func _ready() -> void:
	SavedData.reset_data() 
	SavedData.fetch_data()
	SaveFile.fetch_safe_area()
