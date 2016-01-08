// Sonnenstube concert 29.01.2016
// Marco

import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 32;
float[] spectrum = new float[bands];
float[] spectrum_sum = new float[bands];

Star[] stars = new Star[500];  // the array containing the objects of the type "Star"

// global variabels
float bass_tones, hight_tones;
int old_millis;

void setup() {
  frameRate(60);
  size(displayWidth, displayHeight, P2D);

  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);

  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(in);

  // add the first star to the stars array

  println(stars.length);

  // initialise all the stars in the array
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star(i, random(-2, 2), random(-2, 2), random(-PI/2, PI/2));
  }
}      

void draw() {
  background(0);    // refresh the window

  fft.analyze(spectrum);    // analise the sound spectrum

  // calculate the level of the basses
  bass_tones = calc_block(basses_sel[0], basses_sel[1], basses_sel[2]);    // initial band, final band, amplification (config file)

  // calculate the level of the hight tones
  hight_tones = calc_block(heights_sel[0], heights_sel[1], heights_sel[2]);  // initial band, final band, amplification (config file)

  //draw_FFT();    // comment this line to hide the frequencies plot


  // each 200 milliseconds add the next star in the stars array
  if (millis() - old_millis > 1000) {
    for (Star star : stars) {
      if (star.active == false) {
        star.active = true;
        break;
      }
    }
    /*
   stars = (Star[]) expand(stars, stars.length + 1);  // add one empty space more at the end of the array
     stars[stars.length - 1] = new Star(random(-2, 2), random(-2, 2), random(-PI/2, PI/2));  // in the new empty space, add the new star
     old_millis = millis();
     */
  }


  // get each star from the stars array, and update it with the new level of the basses and hights
  for (Star star : stars) {
    //println(star.id);
    if (star.active == true) {
      star.update(hight_tones, bass_tones);
    }
  }
}


// calculate the level of the sound from/to the desired "frequencies" range
float calc_block (int start, int end, int amplification) {

  float block_val = 0.0;

  for (int i=start; i <= end; i++) {    // sum up the total level from/to the choosed frequences
    block_val += spectrum[i];
  }
  return block_val / (end - start) * amplification;  // return the average level for the range selected
}


// extra function to see the frequencies plot of the sound (just add it into the draw loop to see it: draw_FFT();
void draw_FFT() {

  stroke(255);
  strokeWeight(1);

  int step_bands = parseInt(width/bands);  // the distance between each bar

  for (int i = 0; i < bands; i++) {
    line(i*parseInt(width/bands), 0, i*parseInt(width/bands), height);
  }

  strokeWeight(6);
  for (int i = 0; i < bands; i++) {
    // The result of the FFT is normalized
    // draw the line for frequency band i scaling it up by 5 to get more amplitude.

    int x_line = i*step_bands;

    line(x_line, height, x_line, height - spectrum[i]*height*20);
    spectrum_sum[i] += spectrum[i];
    int freq_label = parseInt(i*22000/bands);

    textSize(12);
    fill(255);

    // freq label
    text(freq_label, x_line+2, 25);
    // i label
    text("i:" + i, x_line+2, 15);
  }
}