// 🔧 ¡EL CAMBIO MÁS IMPORTANTE!
// NO reiniciamos el juego. MOSTRAMOS la pantalla de Game Over.

if (!instance_exists(Obj_GameOver)) {
    instance_create_layer(0, 0, "GUI", Obj_GameOver);
}

// Y ahora, el objeto del jugador muerto se destruye a sí mismo
instance_destroy();