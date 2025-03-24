extends CanvasLayer

@onready var score = $Score
@onready var health = $Health

var current_score = 0

func _ready() -> void:
	score.text = "%06d" % current_score
	health.max_value = 100
	health.value = health.max_value


func _on_bubble_bot_was_hit(damage: Variant) -> void:
	health.value -= damage


func _on_spawner_enemy_died(points: Variant) -> void:
	current_score += points
	score.text = "Score: %06d" % current_score
