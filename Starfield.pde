int centerx = 250;
int centery = 250;
Particle[] particles;
Particle[] secondParticles;
Particle[] thirdParticles;
public void setup()
{
	size(500,500);
	background(255);
	particles = new Particle[150];
	particles[0] = new OddballParticle();
	particles[1] = new JumboParticle();
	for(int i = 2; i < particles.length; i++) {
		particles[i] = new NormalParticle();
	}
	secondParticles = new Particle[150];
	for(int i = 0; i < secondParticles.length; i++) {
		secondParticles[i] = new NormalParticle();
	}
	thirdParticles = new Particle[150];
	for(int i = 0; i < thirdParticles.length; i++) {
		thirdParticles[i] = new NormalParticle();
	}
}
public void draw()
{
	fill(255,255,255,40);
	rect(0,0,500,500);
	for(int i = 0; i < particles.length; i ++ ) {
		particles[i].move();
		particles[i].show();
	}
	if(millis() > 3000) {
		for(int i = 0; i < secondParticles.length; i++) {
			secondParticles[i].move();
			secondParticles[i].show();
		}
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
	double x,y,angle,speed;
	int red,green,blue;
	int size;

	OddballParticle() {
		x = (Math.random()*501);
		y = (Math.random()*501);
		angle = (Math.random())*(2*Math.PI);
		speed = 0.5;
		red = (int)(Math.random()*256);
		green = (int)(Math.random()*256);
		blue = (int)(Math.random()*256);
		size = 15;
	}

	public void move() {
		x += Math.cos(angle) * speed/Math.random();
		y += Math.sin(angle) * speed/Math.random();
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