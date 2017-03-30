delete $*
ball = sphere radius:10 wireColor:blue
ball2 = sphere radius:8 wireColor:red
ball3 = sphere radius:6 wireColor:orange
lengua = plane 
animate on
( 
	at time 0   ball.pos = [-100,0,0] 
	at time 0   ball2.pos =ball.pos + [-20,0,0]
	at time 0   ball3.pos =ball.pos + [-40,0,0]
	at time 20 ball.pos = [-80,0,0]
	at time 25 ball.pos = [-75,0,30]
	at time 30 ball.pos = [-70,0,0]
	at time 40 ball.pos = [-60,0,0]
	at time 45 ball.pos = [-55,0,30]
	at time 50 ball.pos = [-50,0,0]
	at time 75   ball.pos = [-25,0,0]
	at time 150   ball.pos = [25,0,0]		
	at time 200 ball.pos = [100,0,0]
)


sigPos = at time 0 ball.pos - [-20,-20,0]
sigPos2 = at time 0 ball2.pos - [-10,-10,0]


animate on for t in 10 to 200 by 5 do
	at time t 
	(
		ball3.pos=sigPos2 + [-10,0,0]
		ball2.pos = sigPos + [-20,0,0]
		sigPos= ball.pos + random [-7,-7,0] [0,0,0]
		sigPos2= ball2.pos + random [-10,-10,0] [0,0,0]
		
		ball.pos = ball.pos + random [0,-5,0] [0,5,0]
		
	)
	
animate on for in 0 to 200 by 5 do
	at time t{
		
	}

p1 = at time 10 ball.pos
p2 = at time 50 ball.pos
distance p2 p1   

