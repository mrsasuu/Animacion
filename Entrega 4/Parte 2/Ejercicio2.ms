delete $*
ball = sphere radius:10 wireColor:blue
caja = Box lengthsegs:1 widthsegs:1 heightsegs:1 length:28.4564 width:20.2592 height:14.7453 mapcoords:on pos:[0.20682,-67.86,0] isSelected:on
camino = Circle radius:88.7675 pos:[9.19216,123.107,0] isSelected:on
cilindro = Cylinder smooth:on heightsegs:5 capsegs:1 sides:18 height:27.735 radius:17.1417 mapcoords:on pos:[60.320156,-46.8901,0] isSelected:on

animate on
( 
	at time 0 ball.pos = [-100,0,0]
	at time 100 ball.pos = [100,0,0]
	)
	
caja.pos.controller = Path_Constraint ()
caja.pos.controller.follow = on
caja.pos.controller.axis = 0
theConstraint = path_constraint()

caja.position.controller = theConstraint
theConstraint.path = camino

