// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】flowing character. Draw by openFrameworks
// https://junkiyoshi.com/openframeworks20221208/
//

class GameSceneCongratulations468 extends GameSceneCongratulationsBase {
  class ShereUnit {
    PVector location;
    float size;
    ShereUnit(PVector location, float size) {
      this.location = location;
      this.size = size;
    }
  }
  ArrayList<ShereUnit> sphere_list = new ArrayList();
  ArrayList<PVector> deg_list = new ArrayList();
  int number_of_sphere;

  //--------------------------------------------------------------
  class ofPolyline {
    PVector[] v;
  }
  ArrayList<ofPolyline[]> word;

  final int source[] = {
    // openFrameworks側で取ったフォント0～9のアウトラインのxy座標をファイルにしたので
    // それをProcessing側で読み込む。
    // フォント：J  u  n  K  i  y  o  s  h  iのそれぞれのアウトラインの数を定義する。
    1, 1, 1, 1, 2, 1, 2, 1, 1, 2,
  };
  ofPolyline loadOutline(String path) {
    ofPolyline vertices = new ofPolyline();
    String[] lines = loadStrings(path);
    PVector[] v = new PVector[lines.length];
    for (int i = 0; i < v.length; i++) {
      String s = lines[i];
      String[] units = splitTokens(s, ", ");
      PVector p = new PVector(float(units[0]), float(units[1]));
      v[i] = p;
    }
    vertices.v = v;
    return vertices;
  }

  void preload() {
    // アウトラインのxy座標を定義した0_x.txt～9_x.txtを読み込む。
    word = new ArrayList();
    for (int i = 0; i < source.length; i++) {
      int outlineNum = source[i];
      ofPolyline[] outline = new ofPolyline[outlineNum];
      for (int outline_index = 0; outline_index < outlineNum; outline_index++) {
        String path = "data/468/";
        path += i + "_" + outline_index + ".txt";
        ofPolyline vertices = loadOutline(path);
        outline[outline_index] = vertices;
      }
      word.add(outline);
    }
  }

  @Override void setup() {
    preload();
    number_of_sphere = (int)(3600 * 0.5f);
    while (sphere_list.size() < number_of_sphere) {
      PVector tmp_location = make_point(280, random(0, 50), random(360), random(360));
      float radius = sphere_list.size() < 100 ? random(10, 50) : random(3, 20);

      boolean flag = true;
      for (int i = 0; i < sphere_list.size(); i++) {
        ShereUnit su = sphere_list.get(i);
        if (PVector.dist(tmp_location, su.location) < su.size + radius) {
          flag = false;
          break;
        }
      }
      if (flag) {
        float size = (radius * 2) / sqrt(3);
        ShereUnit su = new ShereUnit(tmp_location, size);
        sphere_list.add(su);
        deg_list.add(new PVector(random(360), random(360), random(360)));
      }
    }
  }

  //--------------------------------------------------------------
  void update() {
    ofSeedRandom(39);

    for (int i = 0; i < sphere_list.size(); i++) {
      PVector step = new PVector(random(1, 3), random(1, 3), random(-3, 3));
      if (ofGetFrameNum() % 60 < 30) {
        //deg_list[i] += step * ofMap(ofGetFrameNum() % 60, 0, 30, 15, 0);
        step.mult(map(ofGetFrameNum() % 60, 0, 30, 15, 0));
        PVector deg = deg_list.get(i);
        deg.add(step);
        deg_list.set(i, deg);
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);

    background(0);
    //ofSetLineWidth(1);

    ofRotateX(270);

    translate(280, -560, 0);
    ofRotateZ(ofGetFrameNum() * 0.5);

    for (int i = 0; i < sphere_list.size(); i++) {
      ShereUnit su = sphere_list.get(i);
      PVector location = su.location;
      float size = su.size * 1.2;

      pushMatrix();
      translate(location.x, location.y, location.z);

      PVector deg = deg_list.get(i);
      ofRotateZ(deg.z);
      ofRotateY(deg.y);
      ofRotateX(deg.x);

      //ofPath chara_path = font.getCharacterAsPoints(word[ofRandom(word.size())], true, false);
      //vector<ofPolyline> outline = chara_path.getOutline();
      ofPolyline[] outline = word.get((int)random(word.size()));

      fill(0);
      stroke(255);
      //beginShape();
      for (int outline_index = 0; outline_index < outline.length; outline_index++) {
        //ofNextContour(true);
        beginShape();
        PVector[] vertices = outline[outline_index].v;
        for (PVector vertex : vertices) {
          //glm::vec2 location = vertex / 100 * size;
          //location -= glm::vec2(size * 0.5, -size * 0.5);
          //ofVertex(location);
          PVector loc = PVector.div(vertex, 100.0f);
          loc.mult(size);
          loc.x -= (size * 0.5);
          loc.y -= (-size * 0.5);
          vertex(loc.x, loc.y);
        }
        endShape(CLOSE);
      }
      //endShape(CLOSE);
      popMatrix();
    }
    pop();

    logoRightLower(#ff0000);
  }

  //--------------------------------------------------------------
  PVector make_point(float R, float r, float u, float v) {

    // 数学デッサン教室 描いて楽しむ数学たち　P.31

    u *= DEG_TO_RAD;
    v *= DEG_TO_RAD;

    float x = (R + r * cos(u)) * cos(v);
    float y = (R + r * cos(u)) * sin(v);
    float z = r * sin(u);

    return new PVector(x, y, z);
  }
  
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
