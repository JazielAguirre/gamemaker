// --- Configuración inicial del jugador ---
sprite_index = Spr_Player;
image_speed = 0;
image_index = 0;

// --- Propiedades de movimiento ---
velocidad = 5;
jump_speed = -15;
grav = 0.5;
vsp = 0;

// --- Variables globales ---
if (!variable_global_exists("score")) global.score = 0;

// --- Invulnerabilidad ---
invulnerable = false;
inv_timer = 0; // Contador del tiempo de invulnerabilidad




