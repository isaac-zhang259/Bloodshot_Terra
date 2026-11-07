extends Node2D

func _ready() -> void:
	SavedData.reset_data() 
	SaveFile.save_tools(PreloadedScenes.crossbow)
	SavedData.fetch_data()
