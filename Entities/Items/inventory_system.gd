extends Node

signal item_added(item: Item)
signal item_removed(item: Item)

@export var recipes: Array[Recipe] = []

var items = {} #Idiomatic set

# Named item fields so that items can be referenced from dialogues
var BOOZE_CLOSED: Item = preload("res://Entities/Items/Booze_Closed.tres")
var BOOZE_OPEN: Item = preload("res://Entities/Items/Booze_Open.tres")
var BOOZE_SCREWED: Item = preload("res://Entities/Items/Booze_ScrewInCork.tres")
var CANDLES: Item = preload("res://Entities/Items/Candles.tres")
var COAT_HANGER: Item = preload("res://Entities/Items/CoatHanger.tres")
var FLASHLIGHT: Item = preload("res://Entities/Items/Flashlight.tres")
var HAMMER: Item = preload("res://Entities/Items/Hammer.tres")
var KAZOO: Item = preload("res://Entities/Items/Kazoo.tres")
var KNIFE: Item = preload("res://Entities/Items/Knife.tres")
var LIGHTER: Item = preload("res://Entities/Items/Lighter.tres")
var CANDLES_LIT: Item = preload("res://Entities/Items/LitCandles.tres")
var PORKRINDS: Item = preload("res://Entities/Items/PorkRinds.tres")
var RITUAL_TAPE: Item = preload("res://Entities/Items/RitualTape.tres")
var ROAD_FLARE: Item = preload("res://Entities/Items/RoadFlare.tres")
var SAFE_NOTE: Item = preload("res://Entities/Items/SafeNote.tres")
var SAFE_NOTE_TRANSLATED: Item = preload("res://Entities/Items/SafeNote_Translated.tres")
var SCREW: Item = preload("res://Entities/Items/Screw.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_recipes("res://Entities/Items/Recipes/")

func has_item(item: Item) -> bool:
	return items.has(item)
	
func clear():
	#Emit remove signals? Probably not needed since this is mainly for restarting the game
	items.clear()

func add_item(item: Item):
	items[item] = true
	emit_signal("item_added", item)
	print("Item %s added" % item.DisplayName)
	
func remove_item(item: Item):
	items.erase(item)
	emit_signal("item_removed", item)
	print("Item %s removed" % item.DisplayName)

func can_combine_items(first: Item, other: Item) -> bool:
	return _find_recipe(first, other) != null
# Attempts to combine the given items, return true if successful, otherwise false, and emits signals for any changes to inventory content
func combine_items(first: Item, other: Item) -> bool:
	var recipe = _find_recipe(first, other)
	if recipe == null:
		return false
	
	# Remove consumed ingredients (ie not outputs)
	if not recipe.produces.has(first):
		remove_item(first)
	if not recipe.produces.has(other):
		remove_item(other)
	
	# Add produced outputs (ie not ingredients)
	for item in recipe.produces:
		if item != first and item != other:
			add_item(item)
	return true

func _load_recipes(path: String):
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	
	var file_name = dir.get_next()
	while file_name != "":
		var file_path = path + "/" + file_name
		var resource = ResourceLoader.load(file_path)
		if resource is Recipe:
			recipes.append(resource)
		file_name = dir.get_next()
	
	dir.list_dir_end()
	
func _find_recipe(first: Item, other: Item) -> Recipe:
	for recipe in recipes:
		if recipe.matches(first, other):
			return recipe
	return null
