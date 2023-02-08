// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Splitting apple. openFrameworks
// https://junkiyoshi.com/openframeworks20191210/
//

class GameSceneCongratulations432 extends GameSceneCongratulationsBase {
  ofMesh mesh = new ofMesh();

  //--------------------------------------------------------------
  @Override void setup() {
  }

  //--------------------------------------------------------------
  void update() {
    ofSeedRandom(39);
    mesh.clear();

    int span = 8;
    int scale, index;
    for (int v = 0; v < 360; v += span) {
      for (int u = -170; u < 250; u += span) {
        //PVector noise_seed = (make_apple_point(u - span * 0.5, v - span * 0.5) + make_apple_point(u - span * 0.5, v + span * 0.5) + make_apple_point(u + span * 0.5, v + span * 0.5)) / 3;
        PVector p0 = make_apple_point(u - span * 0.5, v - span * 0.5);
        PVector p1 = make_apple_point(u - span * 0.5, v + span * 0.5);
        PVector p2 = make_apple_point(u + span * 0.5, v + span * 0.5);
        PVector ppp = PVector.add(p0, p1);
        ppp.add(p2);
        PVector noise_seed = PVector.div(ppp, 3.0f);
        //float noise_value = openFrameworks.ofNoise(glm::vec4(noise_seed * 0.25, ofGetFrameNum() * 0.008));
        float noise_value = openFrameworksNoise.ofNoise(noise_seed.x * 0.25f, noise_seed.y * 0.25f, noise_seed.z * 0.25f, ofGetFrameNum() * 0.008f);
        scale = 30;
        if (noise_value > 0.65) {
          scale = (int)map(noise_value, 0.65, 1, 30, 50);
        }
        index = mesh.getNumVertices();

        p0 = make_apple_point(u - span * 0.5, v - span * 0.5);
        p0.mult(scale);
        mesh.addVertex(p0);
        p1 = make_apple_point(u - span * 0.5, v + span * 0.5);
        p1.mult(scale);
        mesh.addVertex(p1);
        p2 = make_apple_point(u + span * 0.5, v + span * 0.5);
        p2.mult(scale);
        mesh.addVertex(p2);

        mesh.addIndex(index);
        mesh.addIndex(index + 1);
        mesh.addIndex(index + 2);

        //      noise_seed = (make_apple_point(u - span * 0.5, v - span * 0.5) + make_apple_point(u + span * 0.5, v - span * 0.5) + make_apple_point(u + span * 0.5, v + span * 0.5)) / 3;
        p0 = make_apple_point(u - span * 0.5, v - span * 0.5);
        p1 = make_apple_point(u + span * 0.5, v - span * 0.5);
        p2 = make_apple_point(u + span * 0.5, v + span * 0.5);
        ppp = PVector.add(p0, p1);
        ppp.add(p2);
        noise_seed = PVector.div(ppp, 3.0f);
        //noise_value = openFrameworks.ofNoise(glm::vec4(noise_seed * 0.25, ofGetFrameNum() * 0.008));
        noise_value = openFrameworksNoise.ofNoise(noise_seed.x * 0.25f, noise_seed.y * 0.25f, noise_seed.z * 0.25f, ofGetFrameNum() * 0.008f);
        scale = 30;
        if (noise_value > 0.65) {
          scale = (int)map(noise_value, 0.65, 1, 30, 50);
        }
        index = mesh.getNumVertices();

        p0 = make_apple_point(u - span * 0.5, v - span * 0.5);
        p0.mult(scale);
        mesh.addVertex(p0);
        p1 = make_apple_point(u + span * 0.5, v - span * 0.5);
        p1.mult(scale);
        mesh.addVertex(p1);
        p2 = make_apple_point(u + span * 0.5, v + span * 0.5);
        p2.mult(scale);
        mesh.addVertex(p2);

        mesh.addIndex(index);
        mesh.addIndex(index + 1);
        mesh.addIndex(index + 2);
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);

    background(239);
    //background(255, 0, 0);

    ofRotateZ(ofGetFrameNum() * 0.5);
    //ofRotateY(ofGetFrameNum() * 0.5);

    fill(39);
    mesh.drawFaces();

    stroke(239);
    mesh.drawWireframe();
    pop();

    logoRightLower(#ff0000);
  }

  //--------------------------------------------------------------
  float log10 (float x) {
    //x = abs(x); NaNは気にしなくてもよさそう＼(^_^)／
    return (log(x) / log(10));
  }
  PVector make_apple_point(float u, float v) {

    // 数学デッサン教室 描いて楽しむ数学たち リンゴ局面 apple surface P.33

    u *= DEG_TO_RAD;
    v *= DEG_TO_RAD;

    float x = (4 + 3.8 * cos(u)) * cos(v);
    float y = (4 + 3.8 * cos(u)) * sin(v);
    float z = -5 * log10(1 - 0.315 * u) + 5 * sin(u) + 2 * cos(u);

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
