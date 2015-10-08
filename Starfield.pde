int centerx = 250;
int centery = 250;
int countOdd = 0;

int oneseclastTime;
int twoseclastTime;
int fourseclastTime;

float heartSize = 1;
int heartR = 251;
int heartG = 174;
int heartB;


Particle[] particles;
Particle[] oddparticles;
Particle[] thirdParticles;
Particle[] jumboparticles;

public void setup()
{
	size(500,500);
	background(255);
	particles = new Particle[150];
	for (int i=0; i < 10; i++) {
		particles[i] = new JumboParticle(i);
	}
	for(int i = 10; i < particles.length; i++) {
		particles[i] = new NormalParticle(false);
	}
	oddparticles = new Particle[10];
	for(int i = 1; i <= oddparticles.length; i++) {
		oddparticles[i-1] = new OddballParticle((i/10));
	}
	thirdParticles = new Particle[150];
	for(int i = 0; i < thirdParticles.length; i++) {
		thirdParticles[i] = new NormalParticle(true);
	}
	jumboparticles = new Particle[10];
	for(int i=0; i< jumboparticles.length; i++) {
		jumboparticles[i] = new JumboParticle();
	}
	oneseclastTime = millis();
	twoseclastTime = millis();
	fourseclastTime = millis();
}
public void draw()
{
	fill(0,0,0,15);
	rect(0,0,500,500);

	if (countOdd < oddparticles.length) {
		if ( millis() - oneseclastTime > 1000 ) {
		    oneseclastTime = millis();
		    countOdd++;
		    heartSize+= 0.8;
   //  		heartR = (int)(Math.random()*86+174);
			// heartG = (int)(Math.random()*256);
			heartB = (int)(Math.random()*86+174);
		}
	}

	if (millis() - fourseclastTime > 5000) {
	    for(int i=0; i < 10;i++) {
	    	((JumboParticle)particles[i]).x = 250;
	    	((JumboParticle)particles[i]).y = 250;
	    	((JumboParticle)particles[i]).spin = false;
	    }
		fourseclastTime = millis();
		twoseclastTime = millis();
	}
	if (millis() - twoseclastTime > 1500) {
		for(int i = 0; i < 10; i++) {
			((JumboParticle)particles[i]).spin = true;
		}
	}

	for(int i = 0; i < particles.length; i ++ ) {
		particles[i].move();
		particles[i].show();
	}

	for(int i = 0; i < jumboparticles.length; i++) {
		particles[i].move();
		particles[i].show();
	}
	for(int i = 0; i < countOdd; i++) {
		oddparticles[i].move();
		oddparticles[i].show();
	}


	for(int i = 0; i < thirdParticles.length; i++) {
		thirdParticles[i].move();
		thirdParticles[i].show();
	}
}
class NormalParticle implements Particle
{
	double x,y,angle,speed,size;
	int red,green,blue;
	boolean ismoving;
	boolean direction;

	NormalParticle(boolean spinDirection) {
		ismoving = true;
		x = 250;
		y = 250;
		angle = (Math.random())*(2*Math.PI);
		speed = 0.5;
		red = (int)(Math.random()*256);
		green = (int)(Math.random()*256);
		blue = (int)(Math.random()*256);
		size = 5;
		direction = spinDirection;
	}
	NormalParticle() {
		ismoving = true;
		x = 250;
		y = 250;
		angle = (Math.random())*(2*Math.PI);
		speed = 0.5;
		red = (int)(Math.random()*256);
		green = (int)(Math.random()*256);
		blue = (int)(Math.random()*256);
		size = 5;
	}
	public void move() {
		if (direction == true) {
			angle -= ((Math.PI)/100);
		}
		else {
			angle += ((Math.PI)/100);
		}
		
		x += Math.cos(angle) * speed*8;
		y += Math.sin(angle) * speed*8;
	}

	public void show() {
		pushMatrix();
		fill(red,green,blue);
		strokeWeight(0);
		ellipse((float)x,(float)y,(float)size,(float)size);
		popMatrix();
	}
}
interface Particle
{
	public void show();
	public void move();
}
class OddballParticle implements Particle
{
	double x,y,angle,speed,cosAngle,sinAngle;
	int red,green,blue;
	int size;
	float t = -1;
	boolean directionT = true;
	OddballParticle(int initialAngle) {
		x = 250;
		y = 250;
		angle = initialAngle*(2*Math.PI);
		speed = 0.5;
		red = (int)(Math.random()*256);
		green = (int)(Math.random()*256);
		blue = (int)(Math.random()*256);
		size = 15;
		cosAngle = angle;
		sinAngle = angle;
	}

	public void move() {

		t += 0.5;
		// x += Math.cos(cosAngle) * speed*10;
		// y += Math.sin(sinAngle) * speed*10;
		float sin3 = pow((float)Math.sin(t), (int)3);
		x = (16*sin3)*heartSize+250;
		y = -((13*(Math.cos(t)))-(5*(Math.cos(2*t)))-(2*(Math.cos(3*t)))-((Math.cos(4*t))))*heartSize+250;
	}
	public void show() {
		strokeWeight(1);
		fill(heartR,heartG,heartB);
		ellipse((float)x,(float)y,(float)size,(float)size);
		ellipse((float)x,(float)y,(float)size/3*2,(float)size/3*2);
		ellipse((float)x,(float)y,(float)size/3,(float)size/3);
	}
}
class JumboParticle extends NormalParticle
{
	boolean spin = false;
	JumboParticle() {

	}
	JumboParticle(int angleSet){
		angle = (Math.PI*2)/10 * angleSet;
	}
	public void move() {

		if (spin == true) {
			angle += ((Math.PI)/100);
			x += Math.cos(angle)*8;
			y += Math.sin(angle)*8;
		}
		else {
			x += Math.cos(angle);
			y += Math.sin(angle);
		}

	}
	public void show() {
		strokeWeight(0);
		fill(heartR,heartG,heartB);
		ellipse((float)x,(float)y,(float)size*5,(float)size*5);
	}
}