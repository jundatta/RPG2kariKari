// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Ivan Rudnickiさん
// 【作品名】Atari Joystick
// https://openprocessing.org/sketch/1548176
//

class GameSceneCongratulations471 extends GameSceneCongratulationsBase {
  MinimAssistance ma;

  float unit;
  float xa = 0;
  float za = 0;
  PVector orient, otarget;
  //let clicky;
  float buttony = 0;
  PImage wood;
  PGraphics cg;
  PImage logo;
  PFont font;
  boolean stabilize = false;

  PShape cy3_13;
  PShape cy5_100;
  PShape cy15_8;
  PShape cy_20;
  PShape cy_5;
  PShape cy15;
  PShape tr18;
  PShape cy15_20_9_1;
  PShape box;
  PShape sphere;

  PGraphics silver;
  PGraphics black;
  PGraphics white;
  PGraphics red;

  PShape plane;

  void preload() {
    //soundFormats('mp3', 'wav');
    ma = new MinimAssistance(gApplet);
    //clicky = loadSound('myclick2.wav');
    //fire = loadSound('fire.wav');
    //blop = loadSound('death.wav');
    //blomp = loadSound('fastinvader1.wav');
    ma.entry("clicky", "data/471/myclick2.wav");
    ma.entry("fire", "data/471/fire.wav");
    ma.entry("blop", "data/471/death.wav");
    ma.entry("blomp", "data/471/fastinvader1.wav");

    wood = loadImage("data/471/walnut.jpg");
    logo = loadImage("data/471/atari.png");
    font = createFont("data/471/Minecraft.ttf", 50, true);
  }

  class Timer {
    int lastT;
    Timer() {
      lastT = millis();
    }
    boolean kick() {
      return false;  // ワンショット
    }
  }
  ArrayList<Timer> at = new ArrayList();

  class PlayBlomp extends Timer {
    boolean kick() {
      int nowT = millis();
      if (nowT < lastT + 1000) {
        return true;  // 継続する
      }
      lastT = nowT;
      if (!gameStarted) return true;  // ひきつづき監視する
      //blomp.play();
      ma.playAndRewind("blomp");
      return true;  // ひきつづき監視する
    }
  }
  class LaunchGame extends Timer {
    boolean kick() {
      int nowT = millis();
      if (nowT < lastT + 500) {
        return true;  // 継続する
      }
      lastT = nowT;
      // 再ゲームのために初期化する
      hitCount = 0;
      restartGame();
      gameStarted = true;
      return false;  // ワンショットで終わる
    }
  }

  @Override void setup() {
    preload();

    unit = height / 50.0f;
    cy3_13 = createCan(3 * unit, 13 * unit, 24, true, false);
    cy5_100 = createCan(5, 100 * unit);
    cy15_8 = createCan(15, 8);
    cy_20 = createCan(unit, 20 * unit);
    cy_5 = createCan(unit, 5 * unit);
    cy15 = createCan(1.5 * unit, unit, 24, false, true);
    cy15_20_9_1 = createCan(1.5 * unit, 20 * unit, 9, false, true);
    tr18 = createTorus(1.8 * unit, unit / 2.0f);

    // fill()ではp5.jsの発色に負けるのであえてPShapeに変える
    box = createShape(BOX, 1.0f, 1.0f, 1.0f);
    box.setStroke(false);
    sphere = createShape(SPHERE, 1);
    sphere.setStroke(false);

    // setFill()は色がくすぶるのであえて1x1のテクスチャで色を貼る
    // ※speculer()が効かない？分pointLight()をきつめに当てているので
    // 　色味を色見本の値からいい感じ？に変えている
    silver = createGraphics(1, 1);
    silver.beginDraw();
    silver.background(#606060);
    silver.endDraw();
    black = createGraphics(1, 1);
    black.beginDraw();
    black.background(#202020);
    black.endDraw();
    white = createGraphics(1, 1);
    white.beginDraw();
    white.background(#ffffff);
    white.endDraw();
    red = createGraphics(1, 1);
    red.beginDraw();
    red.background(#ff0000);
    red.endDraw();

    // テレビ画面が左右逆になるのでboxから自前の板ポリゴンを作って貼るように変えた＼(^_^)／
    plane = createShape();
    plane.beginShape();
    plane.vertex(-0.5f, -0.5f, 0.0f, 0.0f, 0.0f);
    plane.vertex(+0.5f, -0.5f, 0.0f, 1.0f, 0.0f);
    plane.vertex(+0.5f, +0.5f, 0.0f, 1.0f, 1.0f);
    plane.vertex(-0.5f, +0.5f, 0.0f, 0.0f, 1.0f);
    plane.endShape(CLOSE);
    plane.setStroke(false);

    cg = createGraphics((int)(80 * unit), (int)(60 * unit));
    logo.resize((int)(3.5 * unit), 0);
    setupGame();
    orient = new PVector(0, 0, 0);
    otarget = new PVector(0, -PI / 12.0f, 0);
    imageMode(CENTER);
    at.add(new PlayBlomp());
  }
  @Override void draw() {
    push();
    ArrayList newAt = new ArrayList();
    for (Timer t : at) {
      if (t.kick()) {
        newAt.add(t);
      }
    }
    at = newAt;

    camera(0, -height / 4.0f, (height / 2.0) / tan(PI * 20.0 / 180.0), 0, 0, 0, 0, 1, 0);

    background(0);
    if (!stabilize) {
      otarget.x = map(mouseY, 0, height, PI / 6.0f, -PI / 6.0f);
      otarget.y = map(mouseX, 0, width, PI / 24.0f, -PI / 24.0f);
    }
    orient.lerp(otarget, 0.1);
    rotateX(orient.x);
    rotateY(orient.y);
    ambientLight(100, 100, 100);
    pointLight(255, 255, 255, width, -height, 0);
    pointLight(255, 255, 255, width, -height, 0);
    //pointLight(255, 255, 255, width, -height, 0);
    float lamp = 120*noise(frameCount/20.0f);
    if (gameStarted) pointLight(lamp/2.0f, 0, lamp, 0, 0, 0);

    //specular(0);
    noStroke();
    translate(0, 10 * unit, 20 * unit);
    rotateX(-PI / 12.0f);
    drawGame();
    drawTV();
    drawAntenna();
    rotateY(-3*orient.y);
    drawBase();
    drawBaffles();
    drawStick();
    drawButton();
    pop();

    logoRightLower(#ff0000);
  }

  void drawTV() {
    push();
    //texture(wood);
    translate(0, 0, -200 * unit);
    //box(110 * unit, 70 * unit, 70 * unit);
    box.setTexture(wood);
    push();
    scale(110 * unit, 70 * unit, 70 * unit);
    shape(box);
    pop();
    translate(0, -36 * unit, 0);
    //box(120 * unit, 3 * unit, 74 * unit);
    push();
    scale(120 * unit, 3 * unit, 74 * unit);
    shape(box);
    pop();
    translate(0, 36 * unit, 0);

    //texture(cg);
    translate(7 * unit, 0, 35.5 * unit);
    //box(80 * unit, 60 * unit, 2 * unit);
    //box.setTexture(cg);
    plane.setTexture(cg);
    push();
    scale(80 * unit, 60 * unit, 2 * unit);
    //shape(box);
    shape(plane);
    pop();
    translate(-48 * unit, 0, 0);
    //specular(20);
    box.setTexture(silver);
    //box(12 * unit, 60 * unit, 2 * unit);
    push();
    scale(12 * unit, 60 * unit, 2 * unit);
    shape(box);
    pop();
    translate(0, 12 * unit, unit);
    rotateX(HALF_PI);
    cy3_13.setTexture(white);
    for (int i = 0; i < 3; i++) {
      //specular(#c0c0c0);  // 'silver'
      //cylinder(3 * unit, 13 * unit);
      shape(cy3_13);
      translate(0, 0, 12 * unit);
    }
    pop();
    box.setTexture(wood);
    for (float x = -45 * unit; x <= 45 * unit; x += 90 * unit) {
      //texture(wood);
      push();
      translate(x, 45 * unit, -190 * unit);
      //box(35 * unit, 20 * unit, 10 * unit);
      scale(35 * unit, 20 * unit, 10 * unit);
      shape(box);
      pop();
    }
  }

  void drawAntenna() {
    push();
    translate(0, -35 * unit, -200 * unit);
    //specular(#000000);  // 'black'
    //sphere(15 * unit);
    sphere.setTexture(black);
    push();
    scale(15 * unit);
    shape(sphere);
    pop();
    push();
    rotateZ(PI / 12.0f);
    translate(0, -50 * unit, 0);
    specular(#c0c0c0);  // 'silver'
    //cylinder(5, 100 * unit);
    shape(cy5_100);
    translate(0, -50*unit, 0);
    //cylinder(15, 8);
    shape(cy15_8);
    pop();
    push();
    rotateZ(-PI / 12.0f);
    translate(0, -50 * unit, 0);
    specular(#c0c0c0);  // 'silver'
    //cylinder(5, 100 * unit);
    shape(cy5_100);
    translate(0, -50*unit, 0);
    //cylinder(15, 8);
    shape(cy15_8);

    pop();
    pop();
  }

  void drawBase() {
    //specular(0);
    box.setTexture(black);
    //box(22 * unit, 5 * unit, 20 * unit);
    push();
    scale(22 * unit, 5 * unit, 20 * unit);
    shape(box);
    pop();
    //box(20 * unit, 5 * unit, 22 * unit);
    push();
    scale(20 * unit, 5 * unit, 22 * unit);
    shape(box);
    pop();
    //box(20 * unit, 7 * unit, 20 * unit);
    push();
    scale(20 * unit, 7 * unit, 20 * unit);
    shape(box);
    pop();
    cy_20.setTexture(black);
    for (float x = -10 * unit; x <= 10 * unit; x += 20 * unit) {
      push();
      rotateY(HALF_PI);
      translate(x, -2.5 * unit, 0);
      rotateX(HALF_PI);
      //cylinder(unit, 20 * unit);
      shape(cy_20);
      translate(0, 0, -5 * unit);
      //cylinder(unit, 20 * unit);
      shape(cy_20);
      pop();
      push();
      translate(x, -2.5 * unit, 0);
      rotateX(HALF_PI);
      //cylinder(unit, 20 * unit);
      shape(cy_20);
      translate(0, 0, -5 * unit);
      //cylinder(unit, 20 * unit);
      shape(cy_20);
      pop();
      cy_5.setTexture(black);
      sphere.setTexture(black);
      for (float z = -10 * unit; z <= 10 * unit; z += 20 * unit) {
        push();
        translate(x, 0, z);
        //cylinder(unit, 5 * unit);
        shape(cy_5);
        translate(0, -2.5 * unit, 0);
        //sphere(unit);
        push();
        scale(unit);
        shape(sphere);
        pop();
        translate(0, 5 * unit, 0);
        //sphere(unit);
        push();
        scale(unit);
        shape(sphere);
        pop();
        pop();
      }
    }
  }

  void drawBaffles() {
    push();
    translate(0, -3 * unit, 0);
    rotateX(HALF_PI);
    for (float r = 7 * unit; r > 2 * unit; r -= unit) {
      translate(0, 0, unit / 5.0f);
      rotateX(xa / 5.0f);
      rotateY(za / 5.0f);
      //torus(r, unit);
      PShape torus = createTorus(r, unit);
      torus.setTexture(black);
      shape(torus);
    }
    pop();
  }

  void drawStick() {
    za = map(mouseX, 0, width, -PI / 18.0f, PI / 18.0f);
    xa = map(mouseY, 0, height, PI / 18.0f, -PI / 18.0f);
    push();
    translate(0, -2 * unit, 0);
    rotateX(xa);
    rotateZ(za);
    translate(0, -10 * unit, 0);
    //cylinder(1.5 * unit, 20 * unit, 9, 1);
    cy15_20_9_1.setTexture(black);
    shape(cy15_20_9_1);
    pop();
  }

  void drawButton() {
    push();
    translate(-7.5 * unit, -3.5 * unit - buttony, -7.5 * unit);
    //specular(#ff0000);  // 'red'
    cy15.setTexture(red);
    //cylinder(1.5 * unit, unit);
    shape(cy15);
    pop();
    push();
    translate(-7.5 * unit, -3.5 * unit, -7.5 * unit);
    rotateX(HALF_PI);
    //specular(#000000);  // 'black'
    //torus(1.8 * unit, unit / 2.0f);
    tr18.setTexture(black);
    shape(tr18);
    translate(15 * unit, 0, 1);
    image(logo, 0, 0);

    pop();
  }

  ArrayList<Alien> aliens = new ArrayList();
  ArrayList<Missile> missiles = new ArrayList();
  Ship ship;
  boolean gameStarted = false;
  int hitCount = 0;
  float alienXpos = 0;
  float alienYpos = 0;
  float alienMove;
  //let blop, fire, blomp;

  void setupGame() {
    cg.beginDraw();
    cg.textFont(font);
    cg.rectMode(CENTER);
    cg.textAlign(CENTER, CENTER);
    cg.textSize(cg.height/10.0f);
    cg.fill(0);
    cg.noStroke();
    alienMove = cg.width/600.0f;
    ship = new Ship(cg.width / 2.0f, cg.height - 20);
    // createAliens()はLaunchGame.kick()のタイミングでまとめる
    //createAliens();
    for (Alien a : aliens) {
      a.show();
    }
    ship.show();
    cg.endDraw();
  }

  void createAliens() {
    // ゲームオーバー後の再ゲームで初期化できるようにaliansを空にする
    aliens.clear();

    float xw = cg.width/20.0f;
    float yh = cg.height/20.0f;
    int pv = 20;
    for (float y = 4*yh; y < 9*yh; y += 1.5*yh) {
      for (float x = xw; x < cg.width - 6*xw; x += 1.5*xw) {
        aliens.add(new Alien(x, y, xw, yh, pv));
      }
      pv-=5;
    }
  }

  void checkStick() {
    ship.move(za*500);
  }

  void restartGame() {
    alienXpos = 0;
    alienYpos = 0;
    //alienMove = 1;
    hitCount = 0;
    createAliens();
  }

  void drawGame() {
    cg.beginDraw();
    if (!gameStarted) {
      cg.background(50);
    } else {
      cg.background(10);
      cg.fill(255);
      cg.text("Score: " + hitCount, cg.width / 2, cg.height/16);
      for (int i = missiles.size() - 1; i >= 0; i--) {
        Missile m = missiles.get(i);
        m.show();
        m.move();
        if (m.y < 0) {
          missiles.remove(i);
        }
      }
      for (int i = aliens.size() - 1; i >= 0; i--) {
        Alien a = aliens.get(i);
        a.show();
        a.move();
        if (a.intersects(ship)) {
          gameStarted = false;
        }
        for (int j = missiles.size() - 1; j >= 0; j--) {
          Missile m = missiles.get(j);
          if (a.intersects(m)) {
            hitCount += a.pv;
            aliens.remove(i);
            missiles.remove(j);
            //blop.play();
            ma.playAndRewind("blop");
            if (aliens.size() < 1) {
              restartGame();
            }
            break;
          }
        }
      }
      checkStick();
      alienXpos += alienMove;
      if (aliensRight() >= cg.width || aliensLeft() <= 0) {
        alienXpos -= alienMove;
        alienMove *= -1;
        alienYpos += 25;
      }
      ship.show();
    }
    cg.endDraw();
  }

  float aliensRight() {
    float max = 0;
    for (Alien a : aliens) {
      float re = a.x + a.w / 2.0f;
      if (re > max) {
        max = re;
      }
    }
    return max;
  }

  float aliensLeft() {
    float min = width;
    for (Alien a : aliens) {
      float le = a.x - a.w / 2.0f;
      if (le < min) {
        min = le;
      }
    }
    return min;
  }

  class Alien {
    float x, y;
    float startx, starty;
    float w, h;
    color col;
    int pv;
    Alien(float x, float y, float w, float h, int pv) {
      this.x = x;
      this.y = y;
      this.startx = x;
      this.starty = y;
      this.w = w;
      this.h = h;
      // オリジナルのテレビ画面（cg）の高さで色（.col）をマップする
      final int OrgCgH = 442;
      //this.col = color(this.y, 255-this.y, 255);
      int cgY = (int)map(this.y, 0, height, 0, OrgCgH);
      this.col = color(cgY, 255-cgY, 255);
      this.pv = pv;
    }
    void show() {
      cg.fill(this.col);
      cg.rect(this.x, alienYpos + this.y, this.w, this.h);
      cg.fill(0);
      cg.rect(this.x - this.w/4.0f, alienYpos + this.y, this.w/5.0f, this.h/5.0f);
      cg.rect(this.x + this.w/4.0f, alienYpos + this.y, this.w/5.0f, this.h/5.0f);
    }
    boolean intersects(Ship s) {
      return (abs(this.x - s.x) < this.w / 2.0f && abs(alienYpos + this.y - (s.y - s.h)) < this.h);
    }
    boolean intersects(Missile m) {
      return (abs(this.x - m.x) < this.w / 2.0f && abs(alienYpos + this.y - m.y) < this.h);
    }
    void move() {
      this.x += alienMove;
    }
  }

  class Ship {
    float x, y;
    float h;
    Ship(float x, float y) {
      this.x = x;
      this.y = y;
      this.h = cg.height/20.0f + cg.height/12.0f;
    }
    void show() {
      cg.fill(255);
      cg.rect(this.x, this.y - cg.width/20.0f, cg.width/10.0f, cg.height/20.0f); //60,6
      cg.rect(this.x, this.y - cg.height/12.0f, cg.width/96.0f, cg.height/12.0f); //10,30
    }
    void move(float amount) {
      this.x += amount;
      if (this.x>cg.width-35) this.x = cg.width-35;
      if (this.x<35) this.x = 35;
    }
  }

  class Missile {
    float x, y;
    float yvel;
    Missile(float x, float y) {
      this.x = x;
      this.y = y;
      this.yvel = -cg.height/45.0f;
    }
    void show() {
      cg.fill(255);
      cg.rect(this.x, this.y, cg.width/128.0f, cg.height/24.0f);
    }
    void move() {
      this.y += this.yvel;
    }
  }

  @Override void mousePressed() {
    //userStartAudio();
    buttony = -unit / 4.0f;
    if (gameStarted) {
      //fire.play();
      ma.playAndRewind("fire");
      missiles.add(new Missile(ship.x, ship.y-cg.height/12.0f));
    } else {
      //clicky.play();
      ma.playAndRewind("clicky");
      at.add(new LaunchGame());
    }
  }
  @Override void mouseReleased() {
    buttony = unit / 4.0f;
  }
  @Override void keyPressed() {
    super.keyPressed();

    if (keyCode == 32) {
      stabilize = !stabilize;
      return;  // 終わらないようにreturnする
    }
    // ゲームオーバー後の再ゲーム（初期化）をgameStatedで判別できるようにしたいので
    // ここのENTERキーでgameStartedをトグルする機能はやめる
    //if (key == ENTER) {
    //  //clicky.play();
    //  ma.playAndRewind("clicky");
    //  gameStarted = !gameStarted;
    //}

    gGameStack.change(new GameSceneTitle());
  }
  @Override void cleanup() {
    ma.allRemove();
  }
}
