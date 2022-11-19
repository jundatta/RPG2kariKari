// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Spinning sphere pieces. Draw by openFrameworks
// https://junkiyoshi.com/2021/07/27/
//

class GameSceneCongratulations411 extends GameSceneCongratulationsBase {
  ArrayList<ofMeshFace> triangle_list = new ArrayList();
  ofMesh mesh = new ofMesh();
  ofMesh frame = new ofMesh();
  //--------------------------------------------------------------
  @Override void setup() {
    //var ico_sphere = ofIcoSpherePrimitive(300, 3);
    //triangle_list.insert(triangle_list.end(), ico_sphere.getMesh().getUniqueFaces().begin(), ico_sphere.getMesh().getUniqueFaces().end());
    Sphere sp = new Sphere(300, 3);
    ArrayList<PVector> vertices = sp.getVertices();
    for (int i = 0; i < vertices.size(); i+=3) {
      PVector t0 = vertices.get(i+0);
      PVector t1 = vertices.get(i+1);
      PVector t2 = vertices.get(i+2);
      ofMeshFace mf = new ofMeshFace(t0, t1, t2);
      triangle_list.add(mf);
    }
  }

  //--------------------------------------------------------------
  //     vertices.add(glm::normalize(triangle_list[i].getVertex(0)) * (radius + 2) - avg);
  PVector trans(PVector v, int rad, PVector avg) {
    PVector vv = v.copy();
    vv.normalize();
    vv.mult(rad);
    vv.sub(avg);
    return vv;
  }
  void update() {
    mesh.clear();
    frame.clear();

    int radius = 300;
    for (int i = 0; i < triangle_list.size(); i++) {
      ofMeshFace triangle = triangle_list.get(i);
      //PVector avg = (triangle.getVertex(0) + triangle.getVertex(1) + triangle.getVertex(2)) / 3;
      PVector avg = PVector.add(triangle.getVertex(0), triangle.getVertex(1));
      avg.add(triangle.getVertex(2));
      avg.div(3);

      var noise_value = openFrameworks.ofNoise(avg.x * 0.005, avg.y * 0.005, avg.z * 0.005, ofGetFrameNum() * 0.01);

      PMatrix3D rotation_xyz = new PMatrix3D();
      if (noise_value < 0.5) {
        float rad = map(noise_value, 0, 0.5, PI * 3, 0);
        rotation_xyz.rotate(rad);
      }

      ArrayList<PVector> vertices = new ArrayList();
      vertices.add(trans(triangle.getVertex(0), radius + 2, avg));
      vertices.add(trans(triangle.getVertex(1), radius + 2, avg));
      vertices.add(trans(triangle.getVertex(2), radius + 2, avg));

      vertices.add(trans(triangle.getVertex(0), radius - 2, avg));
      vertices.add(trans(triangle.getVertex(1), radius - 2, avg));
      vertices.add(trans(triangle.getVertex(2), radius - 2, avg));

      // もとは参照型でした。なのでverticesを書き換えるようにコーディングする
      //     for (auto& vertex : vertices) {
      ArrayList<PVector> newV = new ArrayList();
      for (var vertex : vertices) {
        //vertex = glm::vec4(vertex, 0) * rotation_z * rotation_y * rotation_x;
        //vertex += avg;
        vertex = rotation_xyz.mult(vertex, null);
        vertex.add(avg);
        newV.add(vertex);
      }
      vertices = newV;

      mesh.addVertices(vertices);
      frame.addVertices(vertices);

      mesh.addColor(color(239));
      mesh.addColor(color(239));
      mesh.addColor(color(239));

      mesh.addColor(color(39));
      mesh.addColor(color(39));
      mesh.addColor(color(39));

      frame.addColor(color(39));
      frame.addColor(color(39));
      frame.addColor(color(39));

      frame.addColor(color(239));
      frame.addColor(color(239));
      frame.addColor(color(239));

      mesh.addTriangle(mesh.getNumVertices() - 1, mesh.getNumVertices() - 2, mesh.getNumVertices() - 3);
      mesh.addTriangle(mesh.getNumVertices() - 4, mesh.getNumVertices() - 5, mesh.getNumVertices() - 6);

      mesh.addTriangle(mesh.getNumVertices() - 1, mesh.getNumVertices() - 2, mesh.getNumVertices() - 5);
      mesh.addTriangle(mesh.getNumVertices() - 1, mesh.getNumVertices() - 5, mesh.getNumVertices() - 4);

      mesh.addTriangle(mesh.getNumVertices() - 1, mesh.getNumVertices() - 3, mesh.getNumVertices() - 6);
      mesh.addTriangle(mesh.getNumVertices() - 1, mesh.getNumVertices() - 6, mesh.getNumVertices() - 4);

      mesh.addTriangle(mesh.getNumVertices() - 2, mesh.getNumVertices() - 3, mesh.getNumVertices() - 6);
      mesh.addTriangle(mesh.getNumVertices() - 2, mesh.getNumVertices() - 6, mesh.getNumVertices() - 5);

      frame.addIndex(frame.getNumVertices() - 1);
      frame.addIndex(frame.getNumVertices() - 2);
      frame.addIndex(frame.getNumVertices() - 2);
      frame.addIndex(frame.getNumVertices() - 3);
      frame.addIndex(frame.getNumVertices() - 1);
      frame.addIndex(frame.getNumVertices() - 3);

      frame.addIndex(frame.getNumVertices() - 4);
      frame.addIndex(frame.getNumVertices() - 5);
      frame.addIndex(frame.getNumVertices() - 5);
      frame.addIndex(frame.getNumVertices() - 6);
      frame.addIndex(frame.getNumVertices() - 4);
      frame.addIndex(frame.getNumVertices() - 6);

      frame.addIndex(frame.getNumVertices() - 1);
      frame.addIndex(frame.getNumVertices() - 4);
      frame.addIndex(frame.getNumVertices() - 2);
      frame.addIndex(frame.getNumVertices() - 5);
      frame.addIndex(frame.getNumVertices() - 3);
      frame.addIndex(frame.getNumVertices() - 6);
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);

    background(239);
    ofSetLineWidth(2);


    ofRotateX(ofGetFrameNum() * 0.37);
    ofRotateY(ofGetFrameNum() * 0.72);

    mesh.drawFaces();

    frame.drawWireframe(color(39));
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
