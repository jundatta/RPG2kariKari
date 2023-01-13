// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】whirlpool. draw by openFrameworks
// https://junkiyoshi.com/openframeworks20230109/
//

class GameSceneCongratulations483 extends GameSceneCongratulationsBase {
  ofMesh face = new ofMesh();
  ofMesh line = new ofMesh();

  FloatList radius_list = new FloatList();
  FloatList deg_list = new FloatList();

  @Override void setup() {
    for (int i = 0; i < 2000; i++) {
      radius_list.append(random(500));
      deg_list.append(random(360));
    }
  }
  //--------------------------------------------------------------
  void update() {
    ofSeedRandom(39);

    face.clear();
    int threshold_radius = 300;

    for (int radius = 0; radius <= 500; radius += 10) {
      int start_index = line.getNumVertices();
      int deg_start = radius;
      for (int deg = deg_start; deg < deg_start + 360; deg += 1) {
        int z = radius > threshold_radius ? 0 : (int)map(radius, 0, threshold_radius, -1 * pow(threshold_radius - radius, 1.1), 0);
        int next_radius = radius + 10;
        int next_z = next_radius > threshold_radius ? 0 : (int)map(next_radius, 0, threshold_radius, -1 * pow(threshold_radius - next_radius, 1.1), 0);

        ArrayList<PVector> vertices = new ArrayList();
        vertices.add(new PVector(radius * cos(deg * DEG_TO_RAD), radius * sin(deg * DEG_TO_RAD), z));
        vertices.add(new PVector(radius * cos((deg + 1) * DEG_TO_RAD), radius * sin((deg + 1) * DEG_TO_RAD), z));
        vertices.add(new PVector(next_radius * cos((deg + 1) * DEG_TO_RAD), next_radius * sin((deg + 1) * DEG_TO_RAD), next_z));
        vertices.add(new PVector(next_radius * cos(deg * DEG_TO_RAD), next_radius * sin(deg * DEG_TO_RAD), next_z));

        face.addVertices(vertices);

        face.addIndex(face.getNumVertices() - 1);
        face.addIndex(face.getNumVertices() - 2);
        face.addIndex(face.getNumVertices() - 3);
        face.addIndex(face.getNumVertices() - 1);
        face.addIndex(face.getNumVertices() - 3);
        face.addIndex(face.getNumVertices() - 4);
      }
    }

    line.clear();

    for (int i = 0; i < radius_list.size(); i++) {
      int speed = 5;
      int radius_start = ((int)(radius_list.get(i) + speed) % 500);
      int radius = 500 - radius_start;
      float deg_start = deg_list.get(i) + (radius > threshold_radius ? 1 : map(radius, 0, threshold_radius, pow(speed, map(radius, 0, threshold_radius, 2, 1)), 1));
      float deg = deg_start;
      int color_value = (int)random(64, 255);

      for (int k = 0; k < 5; k++) {
        radius = ((int)(radius_list.get(i) + speed * k) % 500);
        radius = 500 - radius;

        deg += (radius > threshold_radius ? 1 : map(radius, 1, threshold_radius, pow(speed, map(radius, 0, threshold_radius, 2, 1)), 1));

        int z = radius > threshold_radius ? 0 : (int)map(radius, 0, threshold_radius, -1 * pow(threshold_radius - radius, 1.1), 0);
        PVector vertex = new PVector(radius * cos(deg * DEG_TO_RAD), radius * sin(deg * DEG_TO_RAD), z + 2);
        line.addVertex(vertex);
        line.addColor(color(color_value));

        if (k > 0) {
          line.addIndex(line.getNumVertices() - 1);
          line.addIndex(line.getNumVertices() - 2);
        }
      }

      radius_list.set(i, radius_start);
      deg_list.set(i, deg_start);
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);
    scale(1, -1, 1);

    background(0);
    ofSetLineWidth(1);

    ofRotateX(-35);

    face.draw(color(0));
    line.drawWireframe(color(255));
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
