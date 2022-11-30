// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Dot or Line. Draw by openFrameworks
// https://junkiyoshi.com/2022/01/20/
//

class GameSceneCongratulations420 extends GameSceneCongratulationsBase {
  ofMesh line = new ofMesh();
  ofMesh draw_line = new ofMesh();
  final int kRadius = 150;
  //--------------------------------------------------------------
  @Override void setup() {
    Sphere sp = new Sphere(kRadius, 3);
    ArrayList<PVector> triangles = sp.getVertices();
    for (int i = 0; i < triangles.size(); i+=3) {
      //var avg = new PVector(triangle.getVertex(0) + triangle.getVertex(1) + triangle.getVertex(2)) / 3;
      PVector t0 = triangles.get(i+0);
      PVector t1 = triangles.get(i+1);
      PVector t2 = triangles.get(i+2);
      PVector avg = PVector.add(t0, t1);
      avg.add(t2);
      avg.div(3.0f);
      line.addVertex(avg);
    }

    for (int i = 0; i < line.getNumVertices(); i++) {
      for (int k = i + 1; k < line.getNumVertices(); k++) {
        var location = line.getVertex(i);
        var other = line.getVertex(k);
        if (PVector.dist(location, other) < 15) {
          line.addIndex(i);
          line.addIndex(k);
        }
      }
    }
  }

  //--------------------------------------------------------------
  void update() {
    draw_line = line;

    for (var vertex : draw_line.getVertices()) {
      float x = vertex.x * 0.0015f;
      float y = vertex.y * 0.0015f;
      float z = vertex.z * 0.0015f;
      float w = ofGetFrameNum() * 0.01;
      var noise_value = openFrameworks.ofNoise(x, y, z, w);

      vertex.normalize();
      if (noise_value > 0.5 && noise_value < 0.55) {
        vertex.mult(map(noise_value, 0.5, 0.55, 200, 300));
      } else if (noise_value > 0.55) {
        vertex.mult(300);
      } else {
        vertex.mult(200);
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);

    background(0);
    stroke(255);
    fill(255);
    ofSetLineWidth(1.5 * 1.5f);

    ofRotateY(ofGetFrameNum());

    translate(-320, 0, 0);

    draw_line.drawWireframe(color(255));

    translate(640, 0, 0);

    final float SW = 3.5f;
    for (var vertex : draw_line.getVertices()) {
      push();
      // （視点から見た感じじゃなくてしかも回転しているので世界座標でもないので
      //　なんちゃってすぎてゴメンw
      //　ちょっと大きさに遠近感？があったほうがいいかな。と思ったんですよん
      //　視点から見た世界座標のzを逆算すればいいんでしょうけどw）
      //translate(vertex.x, vertex.y, vertex.z);
      //sphere(3.5);
      float sw = map(vertex.z, -kRadius, +kRadius, SW*2.0f, SW*3.5f);
      strokeWeight(sw);
      translate(0, 0, vertex.z);
      point(vertex.x, vertex.y);
      pop();
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
