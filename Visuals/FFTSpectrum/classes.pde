// class collection to generete the objects

class Star {
  float posX, posY, velX, velY, sizeX, sizeY, angle, rotation_step;

  Star(float velX, float velY, float rotation) {    // constructor: initialise the parameters to create a new star
    this.posX = width/2;
    this.posY = height/2;
    this.velX = velX;
    this.velY = velY;
    this.sizeX = 0;
    this.sizeY = 0;
    this.rotation_step = rotation;
    this.angle = 0;
  }

  void update (float sizeX, float sizeY ) {    // function inside the star object to update its position, size and rotation
    pushMatrix();    // use push/popMatrix to limit the translation and rotation just to the current star and not to the whole canvas
    noStroke();
    fill(255, 200);    // fill all the stars with white and a transparency
    this.posX += this.velX;    // increase the position of the star in X
    this.posY += this.velY;    // increase the position of the star in Y
    translate(this.posX, this.posY);    // move the star to the new position
    this.angle += this.rotation_step;    // update the rotation angle of the star
    rotate(this.angle);    // rotate it
    ellipse(0, 0, sizeX, sizeY);    // draw the star with the new sound level
    popMatrix();
  }
}