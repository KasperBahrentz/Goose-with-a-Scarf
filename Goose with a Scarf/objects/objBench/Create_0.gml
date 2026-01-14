var _handle = instance_create_depth(x, y, depth, objBenchHandle);
_handle.image_xscale = image_xscale;

if (get_tileset_name() == "tlsGroundWinterNight"){
	image_index++;
	_handle.image_index++;
}