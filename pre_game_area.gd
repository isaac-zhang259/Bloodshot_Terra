extends Node2D

func _init() -> void:
	SavedData.fetch_data()
	SavedData.reset_data() 
	print(SavedData.per_save_currency)
	
