package game

import "core:log"
import rl "vendor:raylib"

main :: proc() {
    context.logger = log.create_console_logger(.Info)
    rl.InitWindow(1280, 720, "My First Game")
    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.BLUE)
        rl.EndDrawing()
    }
    rl.CloseWindow()
}
