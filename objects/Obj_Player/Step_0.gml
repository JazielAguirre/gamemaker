#region Movimiento Horizontal
var move = keyboard_check(vk_right) - keyboard_check(vk_left);

// Sprite según dirección
if (move > 0) {
    sprite_index = Spr_Player;
} else if (move < 0) {
    sprite_index = Spr_Player_izq;
}

// Movimiento horizontal con colisión
if (move != 0) {
    var newX = x + move * velocidad;
    if (!place_meeting(newX, y, obj_suelo) && !place_meeting(newX, y, Obj_tub)) {
        x = newX;
        image_speed = 1;
    } else {
        image_speed = 0;
    }
} else {
    image_speed = 0;
}
#endregion


#region Gravedad + Salto
// Aplicar gravedad
vsp += grav;

// Salto (solo si está sobre el suelo o la tubería)
if (keyboard_check_pressed(vk_up) && (place_meeting(x, y + 1, obj_suelo) || place_meeting(x, y + 1, Obj_tub))) {
    vsp = jump_speed;
	// 🔧 --- ¡AQUÍ ESTÁ LA CORRECCIÓN! --- 🔧
    
    // 1. Toca el sonido Y guarda su ID en una variable temporal
    var _instancia_sonido = audio_play_sound(sonido_salto, 10, false);
    
    // 2. Usa ese ID para bajarle el volumen
    // (1.0 es 100% de volumen. 0.5 es 50%. ¡Prueba 0.3 o 0.2!)
    audio_sound_gain(_instancia_sonido, 0.3, 0);
}

// Solo procesar colisiones si hay movimiento vertical
if (vsp != 0) {
    if (place_meeting(x, y + vsp, obj_suelo) || place_meeting(x, y + vsp, Obj_tub)) {
        while (!place_meeting(x, y + sign(vsp), obj_suelo) && !place_meeting(x, y + sign(vsp), Obj_tub)) {
            y += sign(vsp);
        }
        vsp = 0;
    } else {
        y += vsp;
    }
}
#endregion

#region Colisión con Monedas
// 1. Comprueba si estamos tocando una moneda en nuestra posición actual
var moneda = instance_place(x, y, Obj_Coin);

// 2. Si "moneda" NO está vacío (es decir, SÍ estamos tocando una)
if (moneda != noone) {
    
    // 3. 💰 Sumamos puntos
    global.score += 50;
	
	// 🔧 --- ¡AQUÍ ESTÁ LA MAGIA! --- 🔧
    // 1. Creamos el texto flotante
    var _texto = instance_create_layer(moneda.x, moneda.y, "Instances", Obj_Texto_Flotante);
    
    // 2. Le "pasamos" el texto que debe mostrar
    _texto.texto = "+50";
    
    // 4. 🎵 Reproducimos el sonido
    // (¡Asegúrate de tener un sonido llamado 'sonido_moneda'!)
    audio_play_sound(sonido_coin, 10, false);
    
    // 5. 💥 Destruimos la moneda que tocamos
    // "with (moneda)" ejecuta el código en la instancia específica que tocamos
    with (moneda) {
        instance_destroy();
    }
}
#endregion


// 🔧 --- AÑADE ESTA NUEVA REGIÓN --- 🔧
#region Colisión con Vida Extra
// 1. Comprueba si estamos tocando una vida extra
var vida_extra = instance_place(x, y, Obj_Vida_Extra);

// 2. Si "vida_extra" NO está vacío (es decir, SÍ estamos tocando una)
if (vida_extra != noone) {
    
    // 3. 💚 Sumamos una vida
    global.vidas += 1;
    
    // 4. 🎵 Reproducimos el sonido (con volumen)
    var _sonido_vida = audio_play_sound(sonido_vida_extra, 10, false);
    audio_sound_gain(_sonido_vida, 0.7, 0); // Ajusta el volumen (0.7 = 70%)
	
	
	
	// 🔧 --- ¡ARREGLAMOS ESTO! --- 🔧
    // 1. Creamos el texto
    var _texto = instance_create_layer(vida_extra.x, vida_extra.y, "Instances", Obj_Texto_Flotante);
    
    // 2. Le decimos qué texto mostrar
    _texto.texto = "1-UP"; // <-- Lo ponemos aquí ahora
    
    // 5. 💥 Destruimos el objeto de vida extra
    with (vida_extra) {
        instance_destroy();
    }
}
#endregion

// 🔧 --- AÑADE ESTA NUEVA REGIÓN --- 🔧
#region Colision con Meta
// 1. Comprueba si estamos tocando la meta
var meta = instance_place(x, y, Obj_Meta);

if (meta != noone) {
    
    // 2. 🏁 ¡Nos transformamos en el jugador victorioso!
    // (true) significa que ejecutará su propio Evento Create
    instance_change(Obj_Player_Victoria, true);
    
    // 3. (Opcional) Destruimos la meta por si acaso
    with (meta) {
        instance_destroy();
    }
}
#endregion

// 🔧 --- AÑADE ESTA NUEVA REGIÓN AQUÍ --- 🔧
#region Colisión con Obstáculos
// 1. Comprueba si estamos tocando un obstáculo (pinchos)
var pinchos = instance_place(x, y, Obj_Pinchos);

// 2. Si tocamos pinchos Y NO somos invulnerables
if (pinchos != noone && !invulnerable) {
    
    // 3. 💔 Restamos una vida
    global.vidas -= 1;
    
    // 4. 🛡️ Nos volvemos invulnerables (parpadeo)
    invulnerable = true;
    inv_timer = room_speed * 1.5; 

    // 5. 🎵 Sonido de herido
    // (¡Asegúrate de tener un 'sonido_herido'!)
    var _sonido_ouch = audio_play_sound(sonido_herido, 10, false);
    audio_sound_gain(_sonido_ouch, 0.6, 0); // Ajusta el volumen

    // 6. 💀 Comprobamos si morimos (reutilizamos la lógica de muerte)
    if (global.vidas <= 0) {
        audio_stop_sound(sonido_fondo); 
        instance_change(Obj_Player_Muerto, true);
    }
}
#endregion


#region Colisiones con enemigo
var enemigo = instance_place(x, y + vsp, Obj_Ene_1);

if (enemigo != noone) {
    // Si el jugador cae sobre el enemigo (lo aplasta)
    if (vsp > 0 && bbox_bottom <= enemigo.bbox_top + 8) {
        vsp = -8;
		// 🔧 --- ¡AQUÍ VA EL SONIDO! --- 🔧
        // 1. Toca el sonido y guarda su ID
        var _sonido_stomp = audio_play_sound(sonido_muerte_ene, 10, false);
        // 2. Ajusta el volumen (0.7 = 70%)
        audio_sound_gain(_sonido_stomp, 0.9, 0);
		
		// 🔧 --- ¡AQUÍ VA EL TEXTO FLOTANTE! --- 🔧
        // 1. Creamos el texto en la posición del enemigo
        var _texto_flotante = instance_create_layer(enemigo.x, enemigo.y, "Instances", Obj_Texto_Flotante);
        // 2. Le decimos que muestre "+100"
        _texto_flotante.texto = "+100";
		
        with (enemigo) {
            instance_change(Obj_Ene_Muerto, true);
        }
        global.score += 100;

    } else if (!invulnerable) {
        // Si el jugador no está invulnerable y el enemigo lo toca
        global.vidas -= 1;
        invulnerable = true;
        inv_timer = room_speed * 1.5; // 3 segundos de invulnerabilidad

        // 🔧 --- ¡AQUÍ ESTÁ EL CAMBIO! --- 🔧
        // Si ya no le quedan vidas → muere
        if (global.vidas <= 0) { 
            // 🔧 1. Detenemos la música de fondo (¡asumiendo que se llama 'sonido_fondo'!)
            audio_stop_sound(sonido_fondo); 
            
            // 🔧 2. Nos transformamos en el objeto de muerte
            instance_change(Obj_Player_Muerto, true);
        }
    }
}
#endregion


#region Invulnerabilidad
if (invulnerable) {
    inv_timer -= 1;
    // Parpadeo visual
    image_alpha = (image_alpha == 1) ? 0.5 : 1;
    if (inv_timer <= 0) {
        invulnerable = false;
        image_alpha = 1;
    }
}
#endregion