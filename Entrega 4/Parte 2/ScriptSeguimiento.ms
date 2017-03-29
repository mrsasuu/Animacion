ball = sphere radius:10 wireColor:blue
ball2 = sphere radius:8 wireColor:red
ball3 = sphere radius:6 wireColor:orange
animate on
( 
	at time 0   ball.pos = [-100,0,0]
	at time 75   ball.pos = [-25,-100,0]
	at time 150   ball.pos = [25,100,0]		
	at time 200 ball.pos = [100,0,0]
)


sigPos = at time 0 ball.pos - [-10,-10,0]


animate on for t in 10 to 200 by 5 do
	at time t 
	(
		ball3.pos=sigPos 
		sigPos= ball.pos + random [-7,-7,0] [0,0,0]
		
	)

p1 = at time 10 ball.pos
p2 = at time 50 ball.pos
distance p2 p1   

