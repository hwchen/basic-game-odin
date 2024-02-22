package game

import "core:log"
import rl "vendor:raylib"

main :: proc() {
    context.logger = log.create_console_logger(.Info)
    rl.InitWindow(1280, 720, "My First Game")
    player_pos := rl.Vector2{640, 320}
    player_vel: rl.Vector2
    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.BLUE)

        // handle x mvmt
        if rl.IsKeyDown(.LEFT) {
            player_vel.x = -400
        } else if rl.IsKeyDown(.RIGHT) {
            player_vel.x = 400
        } else {
            player_vel.x = 0
        }

        // handle y mvmt
        player_vel.y += 2000 * rl.GetFrameTime()
        if rl.IsKeyPressed(.SPACE) {
            player_vel.y = -600
        }

        // update position
        player_pos += player_vel * rl.GetFrameTime()

        // handle floor
        if player_pos.y > f32(rl.GetScreenHeight()) - 64 {
            player_pos.y = f32(rl.GetScreenHeight()) - 64
        }

        rl.DrawRectangleV(player_pos, {64, 64}, rl.GREEN)
        rl.EndDrawing()
    }
    rl.CloseWindow()
}
