// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Fixed distance. Draw by openFrameworks
// https://junkiyoshi.com/2023/02/03/
//

class GameSceneCongratulations494 extends GameSceneCongratulationsBase {
  ArrayList<PVector> location_list = new ArrayList();
  IntList color_list = new IntList();
  IntList index_list = new IntList();

  ArrayList<ArrayList<ofOutlineCoord>> path_list = new ArrayList();
  //--------------------------------------------------------------
  @Override void setup() {
    ArrayList<ofOutline> outlineWords = openFrameworksOutline.ofOutline();
    String word = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    char[] charArray = word.toCharArray();
    for (char c : charArray) {
      for (ofOutline out : outlineWords) {
        if (c == out.code) {
          path_list.add(out.coord);
          break;
        }
      }
    }

    // ちょっと字がでかすぎるのでちっちゃくしてやろーじゃねーか＼(^_^)／
    float s = 0.2f;
    for (ArrayList<ofOutlineCoord> coord : path_list) {
      for (ofOutlineCoord ooc : coord) {
        for (PVector v : ooc.vertices) {
          v.mult(s);
        }
      }
    }

    colorMode(HSB, 255, 255, 255, 255);
    for (int x = -400 - 15; x <= 400 - 15; x += 15) {
      for (int y = -400 + 15; y <= 400 + 15; y += 20) {
        location_list.add(new PVector(x + 10, y - 10));
        color_list.append(color(random(255), 255, 255));
        index_list.append((int)random(word.length()));
      }
    }
  }

  //--------------------------------------------------------------
  void update() {
    randomSeed(39);
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();

    translate(width * 0.5f, height * 0.5f);
    scale(1, -1, 1);

    background(255);
    ofSetLineWidth(2);

    ofRotateX(120);

    float x = map(openFrameworksNoise.ofNoise(random(1000), ofGetFrameNum() * 0.01), 0, 1, -200, 200);
    float y = map(openFrameworksNoise.ofNoise(random(1000), ofGetFrameNum() * 0.01), 0, 1, -200, 200);
    PVector noise_location = new PVector(x, y, 30);
    noStroke();
    fill(0);
    push();
    //sphere(noise_location - glm::vec3(0, 0, 30), 10);
    translate(noise_location.x, noise_location.y, noise_location.z - 30);
    sphere(10);
    pop();
    for (int i = 0; i < location_list.size(); i++) {
      PVector loc = location_list.get(i);
      float distance = PVector.dist(noise_location, new PVector(loc.x, loc.y, 0));
      PVector deg = new PVector(0, 0, 0);
      PVector noise_seed = new PVector(random(1000), random(1000), random(1000));

      pushMatrix();
      if (distance < 150) {
        //auto gap = glm::vec3(location_list[i], 0) - noise_location;
        PVector gap = new PVector(loc.x - noise_location.x, loc.y - noise_location.y, 0 - noise_location.z);
        //auto location = noise_location + glm::normalize(gap) * 150;
        gap.normalize();
        gap.mult(150);
        PVector location = PVector.add(noise_location, gap);

        deg.x = map(openFrameworksNoise.ofNoise(noise_seed.x, ofGetFrameNum() * 0.02), 0, 1, -180, 180);
        deg.y = map(openFrameworksNoise.ofNoise(noise_seed.y, ofGetFrameNum() * 0.02), 0, 1, -180, 180);
        deg.z = map(openFrameworksNoise.ofNoise(noise_seed.z, ofGetFrameNum() * 0.02), 0, 1, -180, 180);

        translate(location.x, location.y, location.z);
        ofRotateZ(deg.z);
        ofRotateY(deg.y);
        ofRotateX(deg.x);

        //index_list[i] = (index_list[i] + 1) % word.size();
        int ind = index_list.get(i);
        ind = (ind + 1) % path_list.size();
        index_list.set(i, ind);
      } else {
        translate(loc.x, loc.y, loc.z);
        ofRotateZ(deg.z);
        ofRotateY(deg.y);
        ofRotateX(deg.x);
      }

      ArrayList<ofOutlineCoord> outline = path_list.get(index_list.get(i));

      color c = color_list.get(i);
      stroke(c);
      fill(red(c), green(c), blue(c), 128);
      beginShape();
      for (int outline_index = 0; outline_index < outline.size(); outline_index++) {
        beginContour();
        ArrayList<PVector> vertices = outline.get(outline_index).vertices;
        for (PVector v : vertices) {
          //ofVertex(vertex + glm::vec2(-6, 8));
          float vx = v.x + (-6);
          float vy = v.y + 8;
          float vz = v.z;
          vertex(vx, vy, vz);
        }
        endContour();
      }
      endShape(CLOSE);
      popMatrix();
    }
    pop();

    logoRightLower(#ff0000);
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
