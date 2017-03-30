delete $*
Box lengthsegs:1 widthsegs:1 heightsegs:1 length:12.7821 width:8.78257 height:1.27244 mapcoords:on pos:[-29.7494,158.576,0] isSelected:on
Box lengthsegs:1 widthsegs:1 heightsegs:1 length:7.65336 width:9.78358 height:0 mapcoords:on pos:[53.6213,105.129,0] isSelected:on
Box lengthsegs:1 widthsegs:1 heightsegs:1 length:7.1488 width:5.62287 height:0.555081 mapcoords:on pos:[-41.6874,52.5973,0] isSelected:on
Box lengthsegs:1 widthsegs:1 heightsegs:1 length:5.66026 width:7.29456 height:0 mapcoords:on pos:[24.0194,15.3159,0] isSelected:on



fn interpolacionAyuda t CP1 CP2 =(
	V1 = (CP2-CP1)
	
	CP1 + ((normalize V1)*(((length V1)/100)*t))
	
	)
	
fn interpolacionRecursiva t CP1 CP2 CP3 =(
	
	q0= interpolacionAyuda t CP1 CP2
	q1 = interpolacionAyuda t CP2 CP3
	
	interpolacionAyuda t q0 q1
	
	)

fn interpolacion Traveler CP1 CP2 CP3 = 
(

	
	

animate on
(
	for t in 0 to 100 by 1 do
	(
		at time t
		(
			Traveler.pos = interpolacionRecursiva t CP1 CP2 CP3 
		)
		
	)
)
)


interpolacion $Ball $Box001.pos $Box002.pos $Box003.pos