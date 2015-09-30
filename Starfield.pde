int centerx = 250;
int centery = 250;
Particle[] particles;

public void setup()
{
	size(500,500);
	background(0);
	particles = new Particle[40];
	particles[0] = new OddballParticle();
	particles[1] = new JumboParticle();
	for(int i = 2; i < particles.length; i++) {
		particles[i] = new NormalParticle();
	}
}
public void draw()
{
	background(0);
	for(int i = 0; i < particles.length; i ++ ) {
		particles[i].move();
		particles[i].show();
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
		speed = 0.1;
		red = (int)(Math.random()*256);
		green = (int)(Math.random()*256);
		blue = (int)(Math.random()*256);
		size = 5;
	}
	public void move() {
		x += Math.cos(angle) * speed;
		y += Math.sin(angle) * speed;
	}

	public void show() {
		pushMatrix();
		fill(red,green,blue);
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
		ellipse((float)x,(float)y,(float)size,(float)size);
		ellipse((float)x,(float)y,(float)size/3*2,(float)size/3*2);
		ellipse((float)x,(float)y,(float)size/3,(float)size/3);
	}
}
class JumboParticle extends NormalParticle
{
	public void show() {
		ellipse((float)x,(float)y,(float)size*2,(float)size*2);
	}
}