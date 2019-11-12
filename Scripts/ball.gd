extends RigidBody2D

export var maxspeed = 300

signal lives
signal score
signal dupe
signal lifeHelper

func _ready():
 contact_monitor = true
 set_max_contacts_reported(4)
 var WorldNode = get_node("/root/World")
 connect("score", WorldNode, "increase_score")
 connect("lives", WorldNode, "decrease_lives")
 connect("dupe", WorldNode, "duplicateBall")
 var PaddleNode = get_node("/root/World/Paddle")
 connect("lifeHelper", PaddleNode, "lifeTracker")

func _physics_process(delta):
 var bodies = get_colliding_bodies()
 for body in bodies:
  if body.is_in_group("Tiles"):
   emit_signal("score",body.score)
   if body.name == "ExplodePowerUp":
     emit_signal("dupe", body.position)
     emit_signal("lifeHelper")
   body.queue_free()
  if body.get_name() == "Paddle":
   pass
  
 if position.y > get_viewport_rect().end.y:
     emit_signal("lives")
     queue_free()