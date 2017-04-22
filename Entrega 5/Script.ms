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
	global Array_1 = #()
	label EActor "Actor:" 
	pickbutton UI_SelectorActor "Selecciona Actor"
	label EP1 "Selecciona las huellas:" 
	pickbutton UI_SelectorP1 "Añadir"
	button MostrarSeleccion "Mostrar selección"
	button UI_SelectorP2 "Borrar selección"
	
	label EP3 "Borrar claves:" 
	pickbutton UI_SelectorP3 "Selecciona el actor"
	
	spinner UI_IF "Comienzo" range:[0,1000,0] type:#Integer
	button UI_CrearSalto "Crear"
	
	on UI_SelectorActor picked obj do
	(
		global Traveler = obj
		UI_SelectorActor.text = obj.name
	)
	on UI_SelectorP1 picked obj do
	(
		append Array_1 obj
		select Array_1
		
	)
	on UI_SelectorP2 pressed do
	(
		free Array_1
		clearSelection()
	)
	
		on MostrarSeleccion pressed do
	(
		select Array_1
	)
	
	on UI_SelectorP3 picked obj do
	(
		deletekeys obj
	)
	
	on UI_CrearSalto pressed do
	(
		Format "MyArray contains: %\n" Array_1


		  if Traveler!= undefined and UI_SelectorActor.text !="Selecciona Actor" do
		  (
			  if  Array_1.count >= 2 do
			  (
				Traveler.dir = [0,0,1]
			  
				  intervalo = UI_IF.value
				  intervaloP
				  duracion = 0
				  distancia = 0
				  
				  
				  --Añadimos el modificador a nuestro objeto
				  modificador = false
				  
				  for i = 1 to Traveler.modifiers.count by 1 do 
				(
					 if ((ClassOf Traveler.modifiers[i]) == Stretch) do
					 (
						modificador = true
					)
				)
				
				  
				  if (modificador == false) do
					(
					addModifier Traveler (Stretch())
					)			  
					  
						for i = 2 to Array_1.count by 1 do 
						(
							
							distancia = sqrt ((pow (Array_1[i].pos - Array_1[i-1].pos)[1] 2) + (pow (Array_1[i].pos - Array_1[i-1].pos)[2] 2))
							duracion = distancia * 0.5
							duracion = floor duracion
							Format "Intervalo antes es: %\n" intervalo
							Format "Duracion antes es: %\n" duracion
							intervaloP = intervalo + duracion
							Lineal Traveler Array_1[i-1].pos Array_1[i].pos intervalo (intervaloP)
							
							intervalo = intervalo + duracion
							Format "Intervalo es: %\n" intervalo
							Format "Duracion es: %\n" duracion
						)
					  
				  Traveler.showtrajectory = on

				  
				)
		  )
    )
)

createDialog Salto