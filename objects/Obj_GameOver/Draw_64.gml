/// DRAW GUI - Pantalla Game Over con botones funcionales

// 🔧 --- 1. Definimos el centro de la PANTALLA GUI ---
var _cx = display_get_gui_width() / 2;
var _cy = display_get_gui_height() / 2;

// Fondo negro
draw_set_color(c_black);
draw_set_font(Font2);
// 🔧 Usamos las funciones de GUI
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

// 🔧 --- 2. Establecemos la ALINEACIÓN ---
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Texto principal
draw_set_color(c_white);
draw_text(_cx, _cy - 100, "GAME OVER");

// Definimos posiciones de botones (usando las variables del centro)
var _btn_exit_cy = _cy + 80;

var btn_restart_x1 = _cx - 100;
var btn_restart_y1 = _cy - 20;
var btn_restart_x2 = _cx + 100;
var btn_restart_y2 = _cy + 20;

var btn_exit_x1 = _cx - 100;
var btn_exit_y1 = _btn_exit_cy - 20;
var btn_exit_x2 = _cx + 100;
var btn_exit_y2 = _btn_exit_cy + 20;

// Obtener posición del mouse en GUI
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// --- Detección Hover ---
var col_restart = c_dkgray;
var col_exit = c_dkgray;

if (mx > btn_restart_x1 && mx < btn_restart_x2 && my > btn_restart_y1 && my < btn_restart_y2) {
    col_restart = c_lime; // color de hover
}
if (mx > btn_exit_x1 && mx < btn_exit_x2 && my > btn_exit_y1 && my < btn_exit_y2) {
    col_exit = c_red; // color de hover
}

// Dibujamos botones
draw_set_color(col_restart);
draw_rectangle(btn_restart_x1, btn_restart_y1, btn_restart_x2, btn_restart_y2, false);

draw_set_color(col_exit);
draw_rectangle(btn_exit_x1, btn_exit_y1, btn_exit_x2, btn_exit_y2, false);

// Textos de los botones
draw_set_color(c_white);
draw_text(_cx, _cy, "Reiniciar");
draw_text(_cx, _btn_exit_cy, "Salir");

// --- Detección de clic ---
if (mouse_check_button_pressed(mb_left)) {
    // Reiniciar
    if (mx > btn_restart_x1 && mx < btn_restart_x2 && my > btn_restart_y1 && my < btn_restart_y2) {
        room_restart();
    }

    // Salir
    if (mx > btn_exit_x1 && mx < btn_exit_x2 && my > btn_exit_y1 && my < btn_exit_y2) {
        game_end();
    }
}

// 🔧 --- 3. Reseteamos la alineación ---
// (Esta era la parte que se había cortado)
draw_set_halign(fa_left);
draw_set_valign(fa_top);