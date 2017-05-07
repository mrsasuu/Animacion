rollout Salto "Salto"
(
	label EActor "Actor:" 
	pickbutton UI_SelectorActor "Selecciona Actor"
	label EP1 "Patrón:" 
	pickbutton UI_SelectorPatron "Selecciona el patrón"
	label EP2 "Terreno:" 
	pickbutton UI_SelectorTerrain "Selecciona el terreno"

	
	spinner UI_IF "Comienzo" range:[0,1000,0] type:#Integer
	spinner UI_IF_END "Final" range:[0,1000,0] type:#Integer
	
	spinner UI_IF_KEY "Keyframes" range:[0,1000,0] type:#Integer
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
			  inicio = UI_IF.value
			  
			  final = UI_IF_END.value
			  
		Animate on 
		(
			for i in inicio to final by 1 do
			(
				DirVector = Traveler.pos - (at time( i - 1 )(Traveler.pos))
					
					Rayo = ray Traveler.pos [0,0,-1]

				-- Calculo de colisión
					Colision = IntersectRay terrainS Rayo	
						
					Traveler.pos = ((normalize Colision.dir) * Traveler.radius) + Colision.pos
						
					RotVector = cross DirVector Colision.dir
					
					RotAngle = ((length DirVector)/(Traveler.radius*pi))*180
					
					Quaternion = quat RotAngle (normalize RotVector)
					
					RotEuler = QuatToEuler Quaternion
					
					rotate Traveler RotEuler
					
			)
		)
			 
			  
			  Traveler.showtrajectory = on
				)
		  )
    )
	



createDialog Salto