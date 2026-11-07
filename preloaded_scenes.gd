extends Node

const crossbow = preload("res://Weapons/crossbow.tscn")

func _init() -> void:
	SaveFile.save_tools(crossbow)
