extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	await RenderingServer.frame_post_draw
	var image := get_viewport().get_texture().get_image()
	var error := image.save_png("user://tilemap.png")
	
	
	
	if error == OK:
		print("Saved to: ", ProjectSettings.globalize_path("user://tilemap.png"))
	else:
		push_error("Failed to save image: " + str(error))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
