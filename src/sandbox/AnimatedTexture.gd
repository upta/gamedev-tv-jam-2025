class name AnimatedTextureRect extends TextureRect

@export var sprites : SpriteFrames
@export var current_animation = "default"
@export var frame_index := 0
@export_range(0.0, INF, 0.001) var speed_scale := 1.0
@export var auto_play := false
@export var playing := false
var refresh_rate = 1.0
var fps = 30
var frame_delta = 0

func _ready():
	fps = sprites.get_animation_speed(current_animation)
	refresh_rate = sprites.get_frame_duration(current_animation,frame_index )
	if(auto_play):
		play()
func play (animation_name: String= current_animation):
	frame_index = 0
	frame_delta = 0.0
	current_animation = animation_name
	get_animation_data(current_animation)
	playing =true
	
