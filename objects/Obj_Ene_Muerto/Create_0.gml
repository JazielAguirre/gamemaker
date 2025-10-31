// Esto le dice al objeto: "Activa la Alarma 0 en medio segundo"
// (room_speed es 1 segundo. Si tu juego va a 60FPS, room_speed = 60)

alarm[0] = room_speed / 2; 

// Opcional: si quieres que se quede quieto y no se mueva.
vspeed = 0;
hspeed = 0;
gravity = 0;