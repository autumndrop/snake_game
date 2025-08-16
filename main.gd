extends Node2D

const GRID_SIZE := 16
var direction: Vector2 = Vector2.RIGHT
var snake: Array[Vector2] = [Vector2.ZERO]
var food: Vector2 = Vector2(5, 5)

func _ready() -> void:
    randomize()
    set_process(true)

func _process(delta: float) -> void:
    move_snake()
    update()

func move_snake() -> void:
    var new_head: Vector2 = snake[0] + direction
    snake.insert(0, new_head)
    snake.pop_back()
    
func _draw() -> void:
    for segment in snake:
        draw_rect(Rect2(segment * GRID_SIZE, Vector2(GRID_SIZE, GRID_SIZE)), Color(0,1,0))
    draw_rect(Rect2(food * GRID_SIZE, Vector2(GRID_SIZE, GRID_SIZE)), Color(1,0,0))
