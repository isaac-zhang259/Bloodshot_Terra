extends Label

func _process(_delta: float) -> void:
	text = str(SavedData.per_save_currency)
