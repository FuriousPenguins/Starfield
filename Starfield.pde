int centerx = 250;
int centery = 250;
int countOdd = 0;
int lastTime;

Particle[] particles;
Particle[] oddparticles;
Particle[] thirdParticles;
public void setup()
{
	size(500,500);
	background(255);
	particles = new Particle[150];
	particles[0] = new JumboParticle();
	for(int i = 1; i < particles.length; i++) {
		particles[i] = new NormalParticle();
	}
	oddparticles = new Particle[10];
	for(int i = 1; i <= oddparticles.length; i++) {
		oddparticles[i-1] = new OddballParticle((i/10));
	}
	thirdParticles = new Particle[150];
	for(int i = 0; i < thirdParticles.length; i++) {
		thirdParticles[i] = new NormalParticle();
	}
	lastTime = millis();
}
public void draw()
{
	fill(255,255,255,40);
	rect(0,0,500,500);

	if (countOdd < oddparticles.length) {
		if ( millis() - lastTime > 1000 ) {
		    println( "do things every 1 seconds");
		    lastTime = millis();
		    countOdd++;
		}
	}


	for(int i = 0; i < particles.length; i ++ ) {
		particles[i].move();
		particles[i].show();
	}

	for(int i = 0; i < countOdd; i++) {
		oddparticles[i].move();
		oddparticles[i].show();
	}

	if(millis() > 6000) {
		for(int i = 0; i < thirdParticles.length; i++) {
			thirdParticles[i].move();
			thirdParticles[i].show();
		}
	}
}
class NormalParticle implements Particle
{
	double x,y,angle,speed,size;
	int red,green,blue;
	boolean ismoving;

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
		angle += ((Math.PI)/100);
		x += Math.cos(angle) * speed*10;
		y += Math.sin(angle) * speed*10;
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
		// cosAngle += (Math.PI)/100;
		// sinAngle += (Math.PI)/100;

		// if(t > 1) {
		// 	directionT = false;
		// }
		// else if(t < -1) {
		// 	directionT = true;
		// }

		// if(directionT == true) {
		// 	t += .05;
		// }
		// else if(directionT == false) {
		// 	t -= .05;
		// }
		t += 0.5;
		println(t);
		// x += Math.cos(cosAngle) * speed*10;
		// y += Math.sin(sinAngle) * speed*10;
		float sin3 = pow((float)Math.sin(t), (int)3);
		x = (16*sin3)*4+250;
		y = -((13*(Math.cos(t)))-(5*(Math.cos(2*t)))-(2*(Math.cos(3*t)))-((Math.cos(4*t))))*4+250;
	}
	public void show() {
		strokeWeight(0);
		ellipse((float)x,(float)y,(float)size,(float)size);
		ellipse((float)x,(float)y,(float)size/3*2,(float)size/3*2);
		ellipse((float)x,(float)y,(float)size/3,(float)size/3);
	}
}
class JumboParticle extends NormalParticle
{
	public void show() {
		strokeWeight(0);
		ellipse((float)x,(float)y,(float)size*2,(float)size*2);
	}
}