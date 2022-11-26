// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Reversal 20210406. Draw by openFrameworks
// https://junkiyoshi.com/2021/04/06/
//

class GameSceneCongratulations415 extends GameSceneCongratulationsBase {
  PGraphics fbo1, fbo2;
  PShader shader;
  //--------------------------------------------------------------
  @Override void setup() {
    strokeWeight(3*0.5f);

    fbo1 = createGraphics(width, height, P3D);

    fbo2 = createGraphics(width, height, P3D);
    fbo2.beginDraw();
    fbo2.clear();
    fbo2.noStroke();
    fbo2.fill(0);
    int spanW = int(fbo2.width * 0.25);
    int spanH = int(fbo2.height * 0.25);
    var flag = true;
    for (int x = 0; x < fbo2.width; x += spanW) {
      for (int y = 0; y < fbo2.height; y += spanH) {
        if (flag) {
          fbo2.rect(x, y, spanW, spanH);
        }
        flag = !flag;
      }
      flag = !flag;
    }
    fbo2.endDraw();

    shader = loadShader("data/415/shader.frag");
    shader.set("resolution", width, height);
  }

  //--------------------------------------------------------------
  void update() {
    fbo1.beginDraw();
    fbo1.clear();

    fbo1.translate(fbo1.width * 0.5, fbo1.height * 0.5);
    fbo1.rotateX(radians(ofGetFrameNum() * 0.37));
    fbo1.rotateY(radians(ofGetFrameNum() * 0.72));

    ofMesh face = new ofMesh();
    ofMesh frame = new ofMesh();

    float phi_deg_step = 5;
    float theta_deg_step = 3;
    float radius = 250;

    for (float phi_deg = 0; phi_deg < 360; phi_deg += phi_deg_step) {
      for (float theta_deg = 0; theta_deg < 180; theta_deg += theta_deg_step) {
        var noise_value = openFrameworks.ofNoise(radius * cos(phi_deg * DEG_TO_RAD) * 0.02, radius * sin(phi_deg * DEG_TO_RAD) * 0.02, radius * cos(theta_deg * DEG_TO_RAD) * 0.02, ofGetFrameNum() * 0.005);
        if (noise_value < 0.45) {
          continue;
        }

        var noise_1 = openFrameworks.ofNoise(radius * cos(phi_deg * DEG_TO_RAD) * 0.02, radius * sin(phi_deg * DEG_TO_RAD) * 0.02, radius * cos((theta_deg - theta_deg_step) * DEG_TO_RAD) * 0.02, ofGetFrameNum() * 0.005);
        var noise_2 = openFrameworks.ofNoise(radius * cos((phi_deg + phi_deg_step) * DEG_TO_RAD) * 0.02, radius * sin((phi_deg + phi_deg_step) * DEG_TO_RAD) * 0.02, radius * cos(theta_deg * DEG_TO_RAD) * 0.02, ofGetFrameNum() * 0.005);
        var noise_3 = openFrameworks.ofNoise(radius * cos((phi_deg - phi_deg_step) * DEG_TO_RAD) * 0.02, radius * sin((phi_deg - phi_deg_step) * DEG_TO_RAD) * 0.02, radius * cos(theta_deg * DEG_TO_RAD) * 0.02, ofGetFrameNum() * 0.005);
        var noise_4 = openFrameworks.ofNoise(radius * cos(phi_deg * DEG_TO_RAD) * 0.02, radius * sin(phi_deg * DEG_TO_RAD) * 0.02, radius * cos((theta_deg + theta_deg_step) * DEG_TO_RAD) * 0.02, ofGetFrameNum() * 0.005);

        var index = face.getNumVertices();
        ArrayList<PVector> vertices = new ArrayList();

        vertices.add(new PVector(
          radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
          radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
          radius * cos((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD)));
        vertices.add(new PVector(
          radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
          radius * sin((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
          radius * cos((theta_deg - theta_deg_step * 0.5) * DEG_TO_RAD)));
        vertices.add(new PVector(
          radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
          radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg + phi_deg_step * 0.5) * DEG_TO_RAD),
          radius * cos((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD)));
        vertices.add(new PVector(
          radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * cos((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
          radius * sin((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD) * sin((phi_deg - phi_deg_step * 0.5) * DEG_TO_RAD),
          radius * cos((theta_deg + theta_deg_step * 0.5) * DEG_TO_RAD)));

        face.addVertices(vertices);

        face.addIndex(index + 0);
        face.addIndex(index + 1);
        face.addIndex(index + 3);
        face.addIndex(index + 0);
        face.addIndex(index + 3);
        face.addIndex(index + 2);

        if (noise_1 < 0.45) {
          frame.addVertex(vertices.get(0));
          frame.addVertex(vertices.get(1));

          frame.addIndex(frame.getNumVertices() - 1);
          frame.addIndex(frame.getNumVertices() - 2);
        }

        if (noise_2 < 0.45) {
          frame.addVertex(vertices.get(0));
          frame.addVertex(vertices.get(2));

          frame.addIndex(frame.getNumVertices() - 1);
          frame.addIndex(frame.getNumVertices() - 2);
        }

        if (noise_3 < 0.45) {
          frame.addVertex(vertices.get(1));
          frame.addVertex(vertices.get(3));

          frame.addIndex(frame.getNumVertices() - 1);
          frame.addIndex(frame.getNumVertices() - 2);
        }

        if (noise_4 < 0.45) {
          frame.addVertex(vertices.get(2));
          frame.addVertex(vertices.get(3));

          frame.addIndex(frame.getNumVertices() - 1);
          frame.addIndex(frame.getNumVertices() - 2);
        }
      }
    }

    face.draw(fbo1, color(0));

    frame.drawWireframe(fbo1, color(255));

    fbo1.endDraw();
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    background(239);

    shader.set("tex1", fbo1);
    shader.set("tex2", fbo2);

    shader(shader);
    push();
    noStroke();
    rect(0, 0, width, height);
    pop();
    resetShader();
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
