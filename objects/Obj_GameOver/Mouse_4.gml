// --- Detección de clic ---
if (mouse_check_button_pressed(mb_left)) {
    // Reiniciar
    if (mx > btn_restart_x1 && mx < btn_restart_x2 && my > btn_restart_y1 && my < btn_restart_y2) {
        
        // 🔧 ¡LA SOLUCIÓN ESTÁ AQUÍ! 🔧
        // Reseteamos las vidas (y el score) a su valor inicial
        // (O el número de vidas con el que empiezas)
        global.score = 0;
        
        // Ahora sí, reiniciamos la habitación
        room_restart();
    }

    // Salir
    if (mx > btn_exit_x1 && mx < btn_exit_x2 && my > btn_exit_y1 && my < btn_exit_y2) {
        game_end();
    }
}