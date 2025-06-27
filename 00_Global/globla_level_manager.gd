extends Node

var current_tilemap_bound : Array[Vector2]

signal TileMapBoundChanged(bounds: Array[Vector2])

func ChangeTileMapBounds(bounds: Array[Vector2]) -> void:
	current_tilemap_bound = bounds
	TileMapBoundChanged.emit(bounds)
