rollout Animar "Animar"
(
	label EActor "Actor:" 
	pickbutton UI_SelectorActor "Selecciona Actor"
	label EP2 "Terreno:" 
	pickbutton UI_SelectorTerrain "Selecciona el terreno"
	
	button UI_Animar "Animar"
	
	on UI_SelectorActor picked obj do
	(
		global Traveler = obj
		UI_SelectorActor.text = obj.name
	)
	
	on UI_SelectorPatron picked obj do
	(
		global pathS = obj
		UI_SelectorPatron.text = obj.name
	)
	
	on UI_SelectorTerrain picked obj do
	(
		global terrainS = obj
		UI_SelectorTerrain.text = obj.name
	)

	
	on UI_Animar pressed do
	(
		
		


		  if Traveler!= undefined do
		  (
			copia = Sphere radius:42 smooth:on segs:32 chop:0 slice:off sliceFrom:0 sliceTo:0 mapcoords:on recenter:off pos:[-67.6253,22.6053,0]
			copia.material = meditMaterials[2]
			  
		Animate on 
		(
			for i in 0 to 100 by 1 do
			(
				at time i 
				(
					
					DirVector = Traveler.pos - (at time( i - 1 )(Traveler.pos))
					
					Rayo = ray Traveler.pos [0,0,-1]

				-- Calculo de colisión
					Colision = IntersectRay terrainS Rayo	
						
					--Traveler.pos =[0,0,Traveler.radius]  + Colision.pos
					copia.pos = ((normalize Colision.dir) * Traveler.radius) + Colision.pos
						
					RotVector = cross DirVector Colision.dir
					
					RotAngle = ((length DirVector)/(copia.radius*pi))*180
					
					Quaternion = quat RotAngle (normalize RotVector)
					
					RotEuler = QuatToEuler Quaternion
					
					rotate copia RotEuler
					
					
					
				)
					
			)
			
			
		)
				copia.showtrajectory = on
				delete Traveler
				)
		  )
    )
	



createDialog Animar