// 1. Detiene TODOS los sonidos (música de fondo, etc.)
audio_stop_all();

// 2. Toca el sonido de victoria
// (¡Asegúrate de tener un 'sonido_victoria'!)
var _sonido_win = audio_play_sound(sonido_victoria, 10, false);
audio_sound_gain(_sonido_win, 0.7, 0);

// 3. Configura la animación
image_speed = 1; // O la velocidad que necesite tu sprite

// 4. (Opcional) Si Mario debe caminar solo hacia la derecha
// speed = 3;

// 5. Pone la alarma para pasar al siguiente nivel
// (Dale unos 3-4 segundos para que se vea la animación)
alarm[0] = room_speed * 3;