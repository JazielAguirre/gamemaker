//Dar velocidad de movimiento
if (estado=1) {
x+= hspeed; //Avanza el enemigo segun su velocidad horizontal

//Verificar la colision con las paredes


if (place_meeting (x + hspeed, y, obj_suelo))

{
hspeed = -hspeed; //Camine en sentido contrario
}

// Cambiar colision del sprite segun la direccion
if (hspeed >0 ) image_xscale =1;
else if (hspeed <0)  image_xscale = -1;
}

if  (estado == 0) {
	sprite_index = Spr_Enemigo_Muerto;
	hspeed = 0;
	vspeed = 0;
	alarm[0] = room_speed * 1; //1 segundo y desaparece
	estado = 3;
}
// AJUSTES DE ANIMACIÓN EN EL AIRE

if (!place_meeting(x, y + 1, obj_suelo)) {
    image_index = 0; // Frame neutral al estar en el aire
}

#region Collision enemigos desde arriba 
var enemigo = instance_place(x,y+1, Obj_Colision_Ene);
if (enemigo != noone && vspeed > 0)  {
	//Rebote del player al caer encima del enmigo 
	
	//enemigo aplastado
	with (enemigo) {
		if estado == 1 {
			estado =0;
		}
	}
}