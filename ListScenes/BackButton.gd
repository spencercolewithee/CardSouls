extends TextureButton

func _on_BackButton_pressed():
	for Card in $'../Cards'.get_children():
		$'../Cards'.remove_child(Card)
		
	get_parent().hide()
	get_tree().get_root().get_children()[1].get_children()[0].show()
