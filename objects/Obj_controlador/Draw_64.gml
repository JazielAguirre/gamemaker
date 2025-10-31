draw_set_color(c_white);
draw_set_font(Font2); // Fuente por defecto

// Muestra el puntaje
draw_text(16, 16, "Puntaje: " + string(global.score));

// Muestra las vidas
draw_text(16, 48, "Vidas: " + string(global.vidas));
