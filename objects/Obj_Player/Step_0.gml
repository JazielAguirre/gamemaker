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
}

// Solo procesar colisiones si hay movimiento vertical
if (vsp != 0) {
    // Si hay colisión abajo o arriba
    if (place_meeting(x, y + vsp, obj_suelo) || place_meeting(x, y + vsp, Obj_tub)) {
        // Empujar justo hasta tocar el suelo/techo
        while (!place_meeting(x, y + sign(vsp), obj_suelo) && !place_meeting(x, y + sign(vsp), Obj_tub)) {
            y += sign(vsp);
        }
        vsp = 0;
    } else {
        y += vsp;
    }
}
#endregion


#region Colisiones con enemigo

// Detectar colisión con enemigo
var enemigo = instance_place(x, y + vsp, Obj_Ene_1);

if (enemigo != noone) {
    // Si el jugador cae sobre el enemigo (lo aplasta)
    if (vsp > 0 && bbox_bottom <= enemigo.bbox_top + 8) {
        // Rebote del jugador
        vsp = -8;

        // Cambiar enemigo a su versión muerta
        with (enemigo) {
            instance_change(Obj_Ene_Muerto, true);
        }

    } else {
        // Si el enemigo toca al jugador → el jugador muere
        instance_change(Obj_Player_Muerto, true);
    }
}
#endregion
