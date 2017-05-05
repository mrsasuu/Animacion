Function Lineal Traveler CP1  CP2 Inicio Fin   =
(
	VectorSalto =CP2-CP1
	CP3 = (CP1 + CP2)/2
	
	mitad = Fin - Inicio
	
	Format "Inicio es: %\n" Inicio
	Format "Fin es: %\n" Fin
	
	Format "P1 es: %\n" CP1
	Format "P2 es: %\n" CP2
	
	CP3 = CP3 + [0,0,50]
	animate on
	(		
		at time Inicio
		(
			Traveler.modifiers[#Stretch].Stretch = -0.25
			Traveler.rotation = quat 0 0 0 1
			Traveler.pos=CP1
		)
		at time (Inicio+1)
		(
			Traveler.modifiers[#Stretch].Stretch = 0.5
			Traveler.rotation = quat 0 -0.173648 0 0.984808
		)
		
		at time (mitad/2)
		(
			Traveler.rotation = quat 0 0 0 1
			Traveler.modifiers[#Stretch].Stretch = 0
		)
		
		at time (Fin-1)
		(
			Traveler.modifiers[#Stretch].Stretch = 0.5
			Traveler.rotation = quat 0 0.173648 0 0.984808
		)
		

		
		for t in Inicio to Fin by 1 do
		(
			at time t
			(		
				Format "t vale: %\n" t
				 VectorSalto = (CP3-CP1)
	
				q0 =CP1 + ((normalize VectorSalto)*(((length VectorSalto)/(Fin-Inicio))*(t-Inicio)))
				
				VectorSalto = (CP2-CP3)
	
				q1 =CP3 + ((normalize VectorSalto)*(((length VectorSalto)/(Fin-Inicio))*(t-Inicio)))
	
				VectorSalto = (q1-q0)
	
				Traveler.pos = q0 + ((normalize VectorSalto)*(((length VectorSalto)/(Fin-Inicio))*(t-Inicio)))

			)
		)
		
		
		at time Fin 
		(
			Traveler.modifiers[#Stretch].Stretch = -0.25
			Traveler.rotation = quat 0 0 0 1
			Traveler.pos = CP2
		)
		
	)
)

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
			  
			  animate on
	(
			  for i = 0 to final by 1 do
				(
					at time i
					(	
						-- Creación de un rayo
				Rayo = ray Traveler.pos [0,0,-1]

				-- Calculo de colisión
				Colision = IntersectRay terrainS Rayo

				-- Cuaternio A [x y x]
				--Quaternion = quat RotAngle (normalize RotVector)

				-- Uso de Cuaternio
				--RotEuler = QuatToEuler Quaternion
				--rotate ObjToRotate RotEuler
					Traveler.pos = Colision.pos + [0,0,Traveler.radius]
					Format "Posicion es: %\n" Colision.pos
						)
					
				)
				)
			  
					  
				  Traveler.showtrajectory = on
					  
				  

				  
				)
		  )
    )


createDialog Salto