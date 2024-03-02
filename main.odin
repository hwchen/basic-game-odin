package game

import "core:log"
import rl "vendor:raylib"

main :: proc() {
    window_height := i32(720)

    platforms := []Platform{Platform{x1 = 320, x2 = 420, y = f32(window_height) - 32}}

    context.logger = log.create_console_logger(.Info)
    rl.InitWindow(1280, window_height, "My First Game")

    player_pos := rl.Vector2{640, f32(window_height) / 2}
    player_vel: rl.Vector2
    player_grounded: bool

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.BLUE)
        for p in platforms {
            rl.DrawRectangleV({p.x1, p.y}, {p.x2 - p.x1, 16}, rl.RED)
            rl.DrawPixelV({p.x1, p.y}, rl.ORANGE)
            rl.DrawPixelV({p.x2, p.y}, rl.ORANGE)
        }

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
        if rl.IsKeyPressed(.SPACE) && player_grounded {
            player_vel.y = -600
            player_grounded = false
        }

        // update position
        player_pos += player_vel * rl.GetFrameTime()

        // handle floor
        if player_pos.y > f32(rl.GetScreenHeight()) - 64 {
            player_pos.y = f32(rl.GetScreenHeight()) - 64
            player_grounded = true
        }

        // handle platform
        if p_y, is_on := on_platform(platforms, player_pos); is_on {
            player_pos.y = p_y - 64
            player_grounded = true
        }

        rl.DrawRectangleV(player_pos, {64, 64}, rl.GREEN)
        rl.EndDrawing()
    }
    rl.CloseWindow()
}

Platform :: struct {
    x1: f32,
    x2: f32,
    y:  f32,
}

on_platform :: proc(platforms: []Platform, player_pos: rl.Vector2) -> (f32, bool) {
    for p in platforms {
        is_y_bound := player_pos.y > p.y - 64 // account for player height
        is_x1_bound := player_pos.x > p.x1 - 64 // account for player width, leading edge
        is_x2_bound := player_pos.x < p.x2 // trailing edge, don't need to account for player width
        is_x_bound := is_x1_bound && is_x2_bound
        log.info("on_platform is_y_bound", is_y_bound)
        log.info("on_platform is_x1_bound", is_x1_bound)
        log.info("on_platform is_x2_bound", is_x2_bound)
        log.info("on_platform is_x_bound", is_x_bound)
        if is_y_bound && is_x_bound {
            return p.y, true
        }
    }
    return 0, false
}
