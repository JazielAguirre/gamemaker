// 🔊 Reproduce la música de fondo si no está activa
if (!audio_is_playing(sonido_fondo)) {
    audio_play_sound(sonido_fondo, 10, true);
}

// 🧮 Inicializa variables globales
// ¡Quitamos los "if"! El controlador SIEMPRE establece
// los valores al iniciar la habitación.

global.score = 0;
global.vidas = 3;