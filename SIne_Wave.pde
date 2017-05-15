int vertices = 10, loop = 50, period = 1, count = 0;
float sinCount = 0, waveHeight = 10;
boolean withPoints = false, saving = false;
void setup() {
  size(700, 700, P3D);
}

void draw () {
  ortho();
  translate(width / 2, height / 2);
  background(0);
  noFill();
  period = int(map(mouseX, 0, width, 0, 6));
  waveHeight = map(mouseY, 0, height, 10, 50);
  for ( int i = 0; i < loop; i++) {
    int polySize = (int) map (i, 0, loop, 0, 350);
    float waveFreq = map(i, 0, loop, 0, TWO_PI * period);
    float polyOffset = map(i, 0, loop, 0, PI / 2);
    float polyCol = sin(waveFreq + sinCount) * 255;
    poly(vertices, radians(60), polySize, 
      sin(waveFreq + sinCount) * waveHeight, 
      polyOffset, withPoints, polyCol);
  }
  sinCount += .05;
  if(saving)saveFrame(count+"output.png");
  count++;
}

void keyPressed() {
  if (key == 'w') {
    constrain(vertices++, 3, 1000);
  }
  if (key == 's') {
    constrain(vertices--, 3, 1000);
  }
  if (key == ' ') {
    withPoints = !withPoints;
  }
  if(key == 'd') saving = true;
}

void poly (int loop, float rot, int r, float z, float offset, boolean isPoint, float col) {
  stroke(col, 0, 255);
  pushMatrix();
  rotateX(rot);
  if (!isPoint) {
    beginShape();
  } else {
    beginShape(POINTS);
  }
  for ( int i = 0; i < loop; i ++) {
    float angle = map (i, 0, loop, 0 + offset, TWO_PI + offset);
    float x = cos(angle) * r;
    float y = sin(angle) * r;
    vertex(x, y, z);
  }
  endShape(CLOSE);
  popMatrix();
}