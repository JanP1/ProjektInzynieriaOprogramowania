extends Label

func _ready():
	self.connect("item_rect_changed", Callable(self, "_on_item_rect_changed"))

