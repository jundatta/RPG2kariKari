// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Richard Bourneさん
// 【作品名】Dark City
// https://openprocessing.org/sketch/1380184
//

class GameSceneCongratulations417 extends GameSceneCongratulationsBase {
  ArrayList<Building> buildings = new ArrayList();
  float buildingCount = 150 * 0.125f;
  PVector v1;
  float gradient = 100 * 0.5f;

  boolean isScale;

  @Override void setup() {
    push();
    isScale = width <= 1112;
    buildingCount = max(floor(width/15.0f), 100);
    //pixelDensity(2);
    rotate(PI);
    translate(-width, -height);
    colorMode(HSB, 360, 100, 100, 1.0);
    noStroke();
    //background(220, 60, 70, 1);
    push();
    fill(220, 60, 70, 1);
    rect(0, 0, width, height);
    pop();
    rectMode(CENTER);

    push();
    //fill('red');
    fill(0, 100, 100);
    v1 = new PVector(0, height);
    translate(width, height);
    rotate(PI);

    for (float i=0; i<buildingCount; i++) {
      float size = 1;

      float w = 45*random(size*2.5, size*3.5);
      float h = 60*random(size*3, size*15);
      float x = random(width);

      // outer lower
      float y = height - h*0.25 + (abs(width*0.5-x)/(float)width)*100;
      PVector v2 = new PVector(x, y);

      buildings.add(new Building(v2, w, h));
    }
    // 何基準やろ？
    //buildings = buildings.sort((b1, b2)=> {
    //}
    //);
    bgGradient(width/2, height*0.6);
    drawMoon(width*0.5, height*0.5);
    for (Building b : buildings) {
      b.update();
      b.draw();
    }
    pop();
    pop();
  }
  @Override void draw() {
    push();
    rotate(PI);
    pop();

    logoRightLower(#ff0000);
  }

  class Building {
    float x, y;
    float w, h;
    float wBtn, mBtn;
    float col;
    float m;
    float deg;
    float inclination;
    float offset;
    boolean inclineDir;
    PVector v;
    float ang;
    Building(PVector p, float w, float h) {
      this.x = p.x;
      this.y = p.y;
      this.w = w;
      this.h = h;
      this.wBtn = this.w*0.8;
      this.mBtn = (this.w-this.wBtn)/2.0f;
      this.m = 5;
      this.deg = 10;
      this.inclination = random(
        -TWO_PI * this.deg/360.0f,
        TWO_PI * this.deg/360.0f
        );
      this.offset = this.inclination*360/2.0f;
      this.inclineDir = (abs(this.inclination) == this.inclination);
      this.col=random(180, 270);
      this.v = new PVector(this.x - width/2.0f, this.y + height);
      //this.ang = PVector.angleBetween(v1, this.v);
    }

    void update() {
      this.v = new PVector(this.x - width/2.0f, this.y + height);
      this.ang = PVector.angleBetween(v1, this.v);
      if (0.0f < v.x) {
        this.ang = -this.ang;
      }
      this.inclination = max(min(this.ang *1, 0.2), -0.2);
      this.offset = this.inclination > 0? max(this.inclination*360, 5): min(this.inclination*360, -5);
      //this.inclineDir = (abs(this.inclination) == this.inclination ? 1 : -1);
      float inc;
      if (this.inclination != 0.0f) {
        inc = 1.0f;
      } else {
        inc = -1.0f;
      }
      if (abs(this.inclination) == inc) {
        //this.inclineDir = true;
        this.inclineDir = false;
      } else {
        //this.inclineDir = false;
        this.inclineDir = false;
      }
    }
    void draw() {
      float n = (this.w/150.0f) * 0.85;

      push();

      translate(this.x, this.y);
      if (isScale)scale(0.5);
      translate(0, this.h);
      rotate(-this.ang);
      translate(0, -this.h);

      shearX(this.inclination);

      // outline
      if (random(1)>0) {
        fill(0, 0.5);
        float borderW = 0.3;
        quad(
          -this.w/2-borderW, -this.h/2-borderW,
          this.w/2+borderW, -this.h/2-borderW,
          this.w/2-this.mBtn+borderW, this.h/2+borderW,
          -this.w/2+this.mBtn-borderW, this.h/2+borderW
          );
        quad(
          -this.w/2-this.offset-borderW, -this.h/2-abs(this.offset*n)-borderW,
          this.w/2-this.offset+borderW, -this.h/2-abs(this.offset*n)-borderW,
          this.w/2-this.offset-this.mBtn*2+borderW, this.h/2-abs(this.offset*n)+borderW,
          -this.w/2-this.offset+this.mBtn*2-borderW, this.h/2-abs(this.offset*n)+borderW
          );
        quad(
          -this.w/2-this.offset-borderW, -this.h/2 -abs(this.offset*n)-borderW,
          this.w/2 - this.offset+borderW, -this.h/2 -abs(this.offset*n)-borderW,
          this.w/2 +borderW, -this.h/2-borderW,
          -this.w/2-borderW, -this.h/2-borderW
          );
      }

      // side and bottomback
      fill(this.col, 35, 30);
      quad(
        -this.w/2-this.offset, -this.h/2-abs(this.offset*n),
        this.w/2-this.offset, -this.h/2-abs(this.offset*n),
        this.w/2-this.offset-this.mBtn*2, this.h/2-abs(this.offset*n),
        -this.w/2-this.offset+this.mBtn*2, this.h/2-abs(this.offset*n)
        );

      quad(
        -this.w/2-this.offset+this.mBtn*2, this.h/2-abs(this.offset*n)-1,
        this.w/2-this.offset-this.mBtn*2, this.h/2-abs(this.offset*n)-1,
        this.w/2-this.mBtn, this.h/2,
        -this.w/2+this.mBtn, this.h/2
        );

      // top
      fill(this.col, 35, 50);
      quad(
        -this.w/2-this.offset, -this.h/2 -abs(this.offset*n),
        this.w/2 - this.offset, -this.h/2 -abs(this.offset*n),
        this.w/2, -this.h/2,
        -this.w/2, -this.h/2
        );

      //body
      fill(this.col, 30, 20);
      quad(
        -this.w/2, -this.h/2,
        this.w/2, -this.h/2,
        this.w/2-this.mBtn, this.h/2,
        -this.w/2+this.mBtn, this.h/2
        );

      drawBtnDarkLayer(0, 0, 0.000005);

      //windows
      color windowClr = color(random(30, 65), 100, 100);
      for (float i=30; i<this.w-this.m*4; i+=20) {
        float h = random(4, 8);
        for (float j=20; j<this.h-this.m*6; j+=15) {
          //random(1)>0.8 ? fill(windowClr): fill(0, 60, 10);
          if (random(1)>0.8) {
            fill(windowClr);
          } else {
            fill(0, 60, 10);
          }
          float iD = 0.0f;
          if (this.inclineDir) {
            iD = 1.0f;
          }
          rect(
            i - this.w/2 + iD*this.m + 2,
            j - this.h/2 + iD*this.m + 2*j/(float)(this.w-this.m*6),
            10, h);
        }
      }

      shearX(-this.inclination);
      pop();
    }
  }

  void drawArrow(PVector base, PVector vec, color myColor) {
    push();
    stroke(myColor);
    strokeWeight(3);
    fill(myColor);
    translate(base.x, base.y);
    line(0, 0, vec.x, vec.y);
    rotate(vec.heading());
    float arrowSize = 7;
    translate(vec.mag() - arrowSize, 0);
    triangle(0, arrowSize / 2.0f, 0, -arrowSize / 2.0f, arrowSize, 0);
    pop();
  }
  void drawMoon(float x, float y) {
    push();
    translate(x, y);
    for (var moonlight = gradient; moonlight > 0; moonlight = moonlight - 1) {
      var moonlightSize = map(moonlight, gradient*1, 0, min(width*0.8, 800), 10); //size of moonlight
      moonlightSize += sin(frameCount/100.0f)*50;
      noStroke();
      fill(60, 60, 85, 1 - moonlight / gradient);
      ellipse(0, 0, moonlightSize, moonlightSize); //position of moonlight
    } //moonlight
    pop();
  }
  void bgGradient(float x, float y) {
    push();
    translate(x, y);
    scale(2);

    for (var moonlight = gradient; moonlight > 0; moonlight = moonlight - 1) {
      var moonlightSize = map(moonlight*1.5, gradient*1, 0, width/2, 100); //size of moonlight
      noStroke();
      fill(220, 60, 85, 1 - moonlight / gradient);
      ellipse(0, 0, moonlightSize, moonlightSize); //position of moonlight
    } //moonlight
    pop();
  }

  void drawBtnDarkLayer(float x, float y, float fade) {
    push();
    translate(x, y);
    scale(2);
    float a = 1;
    for (var moonlight = gradient; moonlight > 0; moonlight = moonlight - 1) {
      var moonlightSize = map(moonlight*1.5, gradient*1, 0, 100, width); //size of moonlight
      noStroke();
      fill(5, fade*a);
      ellipse(0, 0, moonlightSize*2, moonlightSize); //position of moonlight
      a+=3;
    } //moonlight
    pop();
  }

  void drawGradientLayer(float x, float y) {
    push();
    translate(x, y);
    scale(2);
    float a = 1;
    for (var moonlight = gradient; moonlight > 0; moonlight = moonlight - 1) {
      var moonlightSize = map(moonlight*1.5, gradient*1, 0, 100, max(height, width)); //size of moonlight
      noStroke();
      fill(100, 0.00003*a);
      ellipse(0, 0, moonlightSize, moonlightSize); //position of moonlight
      a+=3;
    } //moonlight
    pop();
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
