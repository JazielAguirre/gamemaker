// 1. Configura la fuente, color y alineación
// (¡Asegúrate de usar la fuente que te guste, como Font2!)
draw_set_font(Font2); 
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// 2. Dibuja el texto en la posición actual del objeto
draw_text(x, y, texto);

// 3. Resetea la alineación para no afectar a otros objetos
draw_set_halign(fa_left);
draw_set_valign(fa_top);