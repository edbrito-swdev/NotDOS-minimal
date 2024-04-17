const raylib = @import("raylib");
const std = @import("std");

pub fn main() anyerror!void {
    const monitorWidth = raylib.getMonitorWidth(0);
    const monitorHeight = raylib.getMonitorHeight(0);

    const targetWidth: i32 = 320;
    const targetHeight: i32 = 240;

    const windowWidth = if (monitorWidth > targetWidth) monitorWidth else targetWidth;
    const windowHeight = if (monitorHeight > targetHeight) monitorHeight else targetHeight;

    raylib.initAudioDevice();
    defer raylib.closeAudioDevice();

    raylib.initWindow(windowWidth, windowHeight, "My Game");
    defer raylib.closeWindow();

    var coin = raylib.loadSound("assets/sfx/coin.wav");
    defer raylib.unloadSound(coin);

    var target = raylib.RenderTexture.init(targetWidth, targetHeight);
    defer target.unload();

    while (!raylib.windowShouldClose()) {
        // Handle input
        if (raylib.isKeyPressed(raylib.KeyboardKey.key_f)) {
            raylib.toggleFullscreen();
        }
        if (raylib.isKeyPressed(raylib.KeyboardKey.key_s)) {
            raylib.playSound(coin);
        }

        // Update

        target.begin();

        raylib.clearBackground(raylib.Color.blank);

        // Draw

        target.end();

        raylib.beginDrawing();
        raylib.clearBackground(raylib.Color.white);

        raylib.drawTexturePro(
            target.texture,
            raylib.Rectangle{ .x = 0, .y = 0, .width = targetWidth, .height = -targetHeight },
            raylib.Rectangle{ .x = 0, .y = 0, .width = @floatFromInt(windowWidth), .height = @floatFromInt(windowHeight) },
            raylib.Vector2{ .x = 0, .y = 0 },
            0.0,
            raylib.Color.white,
        );

        raylib.endDrawing();
    }
}
