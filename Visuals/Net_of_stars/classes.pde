// class collection to generete the objects

class Star {
  float posX, posY, velX, velY, sizeX, sizeY, angle, rotation_step, center_distance, dimension_factor, intensity, size_hights, size_basses;
  int id, connection_to_star_id, colour;
  boolean active, display;
  color star_color;
  Line line;

  Star(int id, float velX, float velY, float rotation) {    // constructor: initialise the parameters to create a new star
    this.id = id;
    this.active = false;
    this.posX = width/2;
    this.posY = height/2;
    this.velX = velX;
    this.velY = velY;
    this.sizeX = 0;
    this.sizeY = 0;
    this.rotation_step = rotation;
    this.angle = 0;
    this.display = false;
    this.center_distance = 0;
    this.dimension_factor = 0;
    this.connection_to_star_id = 0;
    this.line = new Line();
    this.intensity = 0;
    this.size_hights = 0;
    this.size_basses = 0;
    this.colour = 1;
    this.star_color = newColor();
  }

  void update (float size_hights, float size_basses, float intensity) {    // function inside the star object to update its position, size and rotation
    this.posX += this.velX;    // increase the position of the star in X
    this.posY += this.velY;    // increase the position of the star in Y
    this.angle += this.rotation_step;    // update the rotation angle of the star
    this.center_distance = sqrt((pow((this.posX - width/2), 2) + pow((this.posY - height/2), 2)));
    this.dimension_factor = pow((this.center_distance / diagonal * 2), 2);    // parabolic value from 0 to 1
    this.intensity = intensity;

    this.size_hights = size_hights;
    this.size_basses = size_basses;

    // debugging
    this.intensity = 255;

    //println("id: " + this.id + ", posX: " + this.posX + ", posY: " + this.posY + ", center_distance: " + center_distance);

    if (this.posX > width || this.posX < 0  || this.posY > height || this.posY < 0) {
      this.colour = 1 - this.colour;
      init();    // if the star is out of the canvas, reset it
    }
  }

  void display() {
    if (this.display == true) {
      pushMatrix();    // use push/popMatrix to limit the translation and rotation just to the current star and not to the whole canvas
      translate(this.posX - width/2, this.posY - height/2);    // move the star to the new position

      fill(255);
      rotate(0);
      text(this.id, 0, 0);

      rotate(this.angle);    // rotate it
      //fill(this.star_color);
      noFill();
      //fill(this.star_color);
      //stroke(this.intensity);
      stroke(this.star_color);
      strokeWeight(map(this.dimension_factor, 0, 1, .5, 3));
      //noStroke();
      float circle_size_factor = map(this.dimension_factor, 0, 1, .1, 2);
      ellipse(0, 0, this.size_basses * circle_size_factor, this.size_basses * circle_size_factor);

      ellipse(0, 0, this.size_hights * circle_size_factor, this.size_hights * circle_size_factor);
      //ellipse(0, 0, circle_size_factor * 20, circle_size_factor * 20);

      popMatrix();
    }
  }

  void updateLine() {
    this.line.update(this);
    //this.line.display();
  }

  void init() {
    this.size_hights = 0;
    this.size_basses = 0;
    this.posX = width/2;
    this.posY = height/2;
    this.velX = random(-2, 2);
    this.velY = random(-2, 2);
    this.rotation_step = random(-PI/2, PI/2);
    this.star_color = newColor();
    this.center_distance = 0;
    this.dimension_factor = 0;
    this.line.active = true;
    starBinder(this);
  }

  color newColor() {
    return color(random(85, 190), random(85, 190), random(85, 190));
  }
}

class Line {

  float[] coordinates;
  boolean active;
  float intensity;

  Line() {
    this.coordinates = new float [] {0.0, 0.0, 0.0, 0.0};
    this.active = true;
    this.intensity = 100;
  }

  void update(Star star) {
    float to_posX, to_posY;
    if (star.connection_to_star_id == -1) {
      to_posX = width/2;
      to_posY = height/2;
    } else {
      to_posX = stars[star.connection_to_star_id].posX;
      to_posY = stars[star.connection_to_star_id].posY;
    }
    this.coordinates = new float[]  { 
      star.posX, star.posY, to_posX, to_posY
    };
  }

    void display() {
    if (this.active) {
      pushMatrix();
      stroke(255, this.intensity);
      strokeWeight(1);
      translate(-width/2, -height/2);
      line(this.coordinates[0], this.coordinates[1], this.coordinates[2], this.coordinates[3]);
      popMatrix();
    }
  }
}