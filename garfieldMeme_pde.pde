/*
Brett Hobbs
 Mr. Parchimowicz
 ICS 3U1
 Shows basic knowledge about 3D processing, uses meshing with cubes and spheres with the use of boxes and push/pop matrices.
 */
 
//vars
float x, y, z, preMouseX, preMouseY;// x,y and z of garf and mouseXY rotation
PImage garf, text, lightInMyLife;// images to be layed on 3D objects
PVector lasgPos, lasgSpeed, cam, camSpeed;
PShape lasaga;// globe

//setup vars and program
void setup() {
  size(500, 500, P3D);
  surface.setTitle("Shake your tail like this funny cat doe  s");// sets title of prgram
  x = width/2;// inits variables
  y = height/2;
  z = 0;
  preMouseX = mouseX - x;
  preMouseY = mouseY - y;
  garf = loadImage("garfief.jpg");// loads images
  text = loadImage("memeText.jpg");
  lightInMyLife = loadImage("lasaga.jpg");
  lasgPos = new PVector(mouseX, mouseY, z);// inits new pvectors (lasaga sphere)
  lasgSpeed = new PVector(0, 0, 0);
  cam = new PVector(250, 250, 10);// camera for scene
  camSpeed = new PVector(0, 0, 0);
  lasaga = createShape(SPHERE, 0.75);
  lasaga.setTexture(lightInMyLife);
  lasaga.setStrokeWeight(0);
  rectMode(CENTER);
}

void draw() {
  background(55);
  pushMatrix();
  scale(0.4125);//scales down image to smaller size
  translate(250, 50, 0);
  image(text, 0, 0);//top text
  translate(0, 800, 0);
  image(text, 0, 0);// bottom text
  popMatrix();
  scale(100);
  noStroke();
  draggedMouse();// rotation for the cube
  spotLight(255, 255, 255, lasgPos.x, lasgPos.y, lasgPos.z, 0, 0, -1, PI/0.75, 2);// spotlight directed at garfield
  ambientLight(135,135,135, lasgPos.x, lasgPos.y, lasgPos.z);// general lighting
  pushMatrix();
  scale(0.5);
  translate(5, 5, 0);
  rotateX(preMouseX);
  rotateY(preMouseY);
  texture(garf);
  drawShapeGarf();//garfield cube
  popMatrix();

  lasgPos = lasgPos.add(lasgSpeed);//updates positional vectors
  cam = cam.add(camSpeed);
  translate(lasgPos.x,lasgPos.y,lasgPos.z);
  shape(lasaga, lasgPos.x, lasgPos.y);// lasaga sphere
  translate(cam.x,cam.y,cam.z);
  camera(cam.x, cam.y, cam.z, 250, 250, 10, 0, 1, 0);
  
  
  
}
//heh
void keyPressed() {

  if (keyCode == 37) {// left
    lasgSpeed.x = -0.1;
  } else if (keyCode == 38) {// up
    lasgSpeed.y = -0.1;
  } else if (keyCode == 39) {// right
    lasgSpeed.x = 0.1;
  } else if (keyCode == 40) {// down
    lasgSpeed.y = 0.1;
  } else if (keyCode == 3) {//forward
    lasgSpeed.z = -0.1;
  } else if (keyCode == 26) {//backwards
    lasgSpeed.z = 0.1;
  } 
  if (keyCode == 81) {// cam forward X
    camSpeed.x = 10;
  } else if (keyCode == 65) {// cam backwards X
    camSpeed.x = -10;
  } else if (keyCode == 87) {//cam forwards Y
    camSpeed.y = 10;
  } else if (keyCode == 83) {// cam backwards Y
    camSpeed.y = -10;
  } else if (keyCode == 69) {// cam forwards Z
    camSpeed.z = 10;
  } else if (keyCode == 68) {// cam backwards Z
    camSpeed.z = -10;
  }
}

void keyReleased() {
  //stops the lasaga
  if (keyCode == 37 || keyCode == 39) {
    lasgSpeed.x = 0;
  }

  if (keyCode == 38 || keyCode == 40) {
    lasgSpeed.y = 0;
  }

  if (keyCode == 3 || keyCode == 26) {
    lasgSpeed.z = 0;
  }
  // stops the camera
  if (keyCode == 81 || keyCode == 65) {
    camSpeed.x = 0;
  }

  if (keyCode == 87 || keyCode == 83) {
    camSpeed.y = 0;
  }

  if (keyCode == 69 || keyCode == 68) {
    camSpeed.z = 0;
  }
}



void draggedMouse() {
  float rate = 0.01;
  preMouseX += (pmouseY-mouseY) * rate;
  preMouseY += (mouseX-pmouseX) * rate;
}

void drawShapeGarf() {// draws the cubr
  beginShape(QUADS);
  texture(garf); 
  // +Z front face
  vertex(-1, -1, 1, 0, 0);
  vertex( 1, -1, 1, 200, 0);
  vertex( 1, 1, 1, 200, 200);
  vertex(-1, 1, 1, 0, 200);

  // -Z back face
  vertex( 1, -1, -1, 0, 0);
  vertex(-1, -1, -1, 200, 0);
  vertex(-1, 1, -1, 200, 200);
  vertex( 1, 1, -1, 0, 200);

  // +Y bottom face
  vertex(-1, 1, 1, 0, 0);
  vertex( 1, 1, 1, 200, 0);
  vertex( 1, 1, -1, 200, 200);
  vertex(-1, 1, -1, 0, 200);

  // -Y top face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 200, 0);
  vertex( 1, -1, 1, 200, 200);
  vertex(-1, -1, 1, 0, 200);

  // +X right face
  vertex( 1, -1, 1, 0, 0);
  vertex( 1, -1, -1, 200, 0);
  vertex( 1, 1, -1, 200, 200);
  vertex( 1, 1, 1, 0, 200);

  // -X left face
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1, 1, 200, 0);
  vertex(-1, 1, 1, 200, 200);
  vertex(-1, 1, -1, 0, 200);

  endShape();
}
