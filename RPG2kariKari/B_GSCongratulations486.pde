// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】kikpondさん
// 【作品名】Illuminated trees #2
// https://openprocessing.org/sketch/1348215
//

class GameSceneCongratulations486 extends GameSceneCongratulationsBase {
  float range;
  int treeNum;
  int treeHue;
  float treesWidth, treesHeight;
  int isCoolColor;
  float roadWidth, roadHeight;
  PImage illumiImg;
  ArrayList<Particle> particles = new ArrayList();

  @Override void setup() {
    illumiImg = createImage(width, height, ARGB);
    strokeWeight(10);
    range = 8;
    roadWidth = width / 10.0f;
    roadHeight = height / 1.2f;
    treeNum = 30;
    treesWidth = (width / 2 - roadWidth) / (float)treeNum;
    treesHeight = (height - roadHeight) / (float)treeNum;
    initIlluminatedImage();
    particleInit();
  }
  @Override void draw() {
    push();
    background(0);
    image(illumiImg, 0, 0);
    for (Particle p : particles) {
      p.update();
      p.display();
    }
    pop();

    logoRightLower(#ff0000);
  }

  void particleInit() {
    particles.clear();

    int y = 0;
    int parHeight = 40;
    float blinkSeppd = 0.05;
    for (int i = 0; i < width; i += 100) {
      if (i < width / 2) y += parHeight;
      else y -= parHeight;

      // 犯人は私でした＼(^_^)／
      // 一生懺悔します
      for (int l = 0; l < 200; l++) {
        //for (int l = 0; l < particles.size(); l++) {
        float lx = random(i, i + 100);
        float ly = random(y, height);
        float lr = random(10);
        int rand = setRandomColor();
        Particle p = new Particle(lx, ly, lr, lr, rand, blinkSeppd);
        particles.add(p);
      }
    }
  }

  void kirakira() {
    push();
    noStroke();
    int y = 0;
    for (int i = 0; i < width; i += 100) {
      if (i < width / 2) y += 70;
      else y -= 70;
      for (int l = 0; l < 300; l++) {
        float lx = random(i, i + 100);
        float ly = random(y, height);
        float lr = random(7);
        int rand = setRandomColor();
        int lightness = int(random(50, 100));

        //fill('hsla(' + rand + ', 100%,' + lightness + '%, 1)');
        fill(P5JS.hsla2rgba(rand, 100, lightness, 1.0f));
        ellipse(lx, ly, lr, lr);
      }
    }
    pop();
  }

  void initIlluminatedImage() {
    background(0, 10, 40, 250);
    starLight();
    isCoolColor = int(random(1, 5.1));
    road();
    //redCarpet();
    for (int i = treeNum; i > 0; i--) {
      treeHue = setRandomColor();
      float treeLien = map(i, treeNum, 0, 2, 10);
      push();
      translate((width) - i * treesWidth, height - i * treesHeight);
      tree(0, treeLien, treeHue);
      pop();

      push();
      translate(i * treesWidth, height - i * treesHeight);
      tree(0, treeLien, treeHue);
      pop();
    }
    //kirakira();
    bigTree(2000, roadHeight - 300, roadHeight);
    illumiImg = get();
  }

  void tree(int depth, float _treeH, int _hue) {
    int lightness = int(random(50, 100));
    //stroke('hsla(' + _hue + ', 100%,' + lightness + '%, 0.9)');
    stroke(P5JS.hsla2rgba(_hue, 100, lightness, 0.9f));

    push();
    scale(_treeH / 10.0f);
    if (depth < 10) {
      line(0, 0, 0, -height / 3.0f);
      push();
      {
        translate(0, -height / 5.0f);
        rotate(random(-PI / range, PI / range));
        scale(0.7);
        tree(depth + 1, 10, treeHue);
      }
      pop();

      push();
      {
        translate(0, -height / 3.0f);
        rotate(random(-PI / range, PI / range));
        scale(0.7);
        tree(depth + 1, 10, treeHue);
      }
      pop();
    }
    pop();
  }

  void road() {
    push();
    noStroke();
    fill(255, 100);
    quad(0, height, width / 2 - roadWidth, roadHeight,
      width / 2 + roadWidth, roadHeight, width, height);
    pop();

    push();
    strokeWeight(1);
    stroke(0);
    for (float y = roadHeight; y < height; y += treesHeight) {
      line(0, y, width, y);
    }
    pop();
  }

  void redCarpet() {
    push();
    noStroke();
    fill(255, 50, 50, 200);
    quad(100, height, width / 2 - roadWidth, roadHeight,
      width / 2 + roadWidth, roadHeight, width - 100, height);
    pop();
  }


  int setRandomColor() {
    if (isCoolColor == 1) return int(random(180, 300));
    else if (isCoolColor == 2) return int(random(50, 70));
    else if (isCoolColor == 3) return int(random(0, 50));
    else if (isCoolColor == 4) return int(random(0, 150));
    else if (isCoolColor == 5) return int(random(0, 360));
    return 0;
  }

  void starLight() {
    push();
    float rand = random(100, 300);
    float dir = random(1, 3);
    for (int i = 0; i < rand; i++) {
      float x = random(0, width);
      float y = random(0, 300);
      noStroke();
      fill(255);
      ellipse(x, y, dir, dir);
    }
    pop();
  }

  void bigTree(int num, float y1, float y2) {
    noStroke();
    for (int i = 0; i < num; i++) {
      float y = random(y1, y2);
      float w = map(y, y1, y2, 1, 300);
      float x = random(width / 2 - (w / 2), width / 2 + (w / 2));
      //fill('hsla(' + int(random(360)) + ', 100%,' + int(random(50, 90)) + '%, 1)');
      fill(P5JS.hsla2rgba(int(random(360)), 100, int(random(50, 90)), 1.0f));
      ellipse(x, y, 3, 3);
    }
  }

  class Particle {
    float x, y, w, h;
    int parHue, parLightness;
    float parAlpha;
    float alphaSpeed;

    Particle(float _x, float _y, float _w, float _h, int _hue, float _alphaSpeed) {
      this.x = _x;
      this.y = _y;
      this.w = _w;
      this.h = _h;

      this.parHue = _hue;
      this.parLightness = int(random(50, 90));
      this.parAlpha = random(0.1, 1);
      this.alphaSpeed = _alphaSpeed;
    }

    void update() {
      //------pattern1 (Lightness) ------
      // if (this.parLightness <= 50 || 100 <= this.parLightness) {
      //     this.lightPower *= -1;
      // }
      // this.parLightness += this.lightPower;

      //------pattern2 (lightAlpha) ------
      if (this.parAlpha < 0.1 || 0.9 < this.parAlpha) {
        this.alphaSpeed *= -1;
      }
      this.parAlpha += this.alphaSpeed;
    }

    void display() {
      push();
      noStroke();
      //fill('hsla(' + this.parHue + ', 100%, ' + int(this.parLightness) + '%, ' + this.parAlpha + ')');
      fill(P5JS.hsla2rgba(this.parHue, 100, int(this.parLightness), this.parAlpha));
      ellipse(this.x, this.y, this.w, this.h);
      pop();
    }
  }
  
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
