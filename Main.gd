extends Node2D

const TILE_SIZE := 20
const GRID_SIZE := Vector2i(32, 24)
const MOVE_DELAY := 0.15

var snake := [Vector2i(5, 5)]
var direction := Vector2i(1, 0)
var food := Vector2i.ZERO
var move_timer := MOVE_DELAY

func _ready() -> void:
    randomize()
    spawn_food()

func spawn_food() -> void:
    while true:
        var pos := Vector2i(randi_range(0, GRID_SIZE.x - 1), randi_range(0, GRID_SIZE.y - 1))
        if not snake.has(pos):
            food = pos
            break

func _process(delta: float) -> void:
    move_timer -= delta
    if move_timer <= 0.0:
        move_snake()
        move_timer = MOVE_DELAY
    update()

func move_snake() -> void:
    var new_head := snake[0] + direction
    if new_head.x < 0 or new_head.y < 0 or new_head.x >= GRID_SIZE.x or new_head.y >= GRID_SIZE.y:
        reset_game()
        return
    if snake.has(new_head):
        reset_game()
        return
    snake.insert(0, new_head)
    if new_head == food:
        spawn_food()
    else:
        snake.pop_back()

func reset_game() -> void:
    snake = [Vector2i(GRID_SIZE.x / 2, GRID_SIZE.y / 2)]
    direction = Vector2i(1, 0)
    spawn_food()

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventKey and event.pressed and not event.echo:
        match event.keycode:
            KEY_UP:
                if direction != Vector2i(0, 1):
                    direction = Vector2i(0, -1)
            KEY_DOWN:
                if direction != Vector2i(0, -1):
                    direction = Vector2i(0, 1)
            KEY_LEFT:
                if direction != Vector2i(1, 0):
                    direction = Vector2i(-1, 0)
            KEY_RIGHT:
                if direction != Vector2i(-1, 0):
                    direction = Vector2i(1, 0)

func _draw() -> void:
    for segment in snake:
        draw_rect(Rect2(segment * TILE_SIZE, Vector2(TILE_SIZE, TILE_SIZE)), Color.GREEN)
    draw_rect(Rect2(food * TILE_SIZE, Vector2(TILE_SIZE, TILE_SIZE)), Color.RED)
