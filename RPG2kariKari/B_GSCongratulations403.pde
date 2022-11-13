// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Random work is curry. openFrameworks
// https://junkiyoshi.com/2020/12/18/
//

class GameSceneCongratulations403 extends GameSceneCongratulationsBase {
  ArrayList<PVector> location_list = new ArrayList();
  ArrayList<IntList> next_index_list = new ArrayList();
  IntList destination_list = new IntList();

  ArrayList<Actor> actor_list = new ArrayList();

  ofMesh face = new ofMesh();
  ofMesh frame = new ofMesh();
  //--------------------------------------------------------------
  class Actor {
    int select_index;
    int next_index;

    PVector location = new PVector(0, 0, 0);

    Actor(ArrayList<PVector> location_list, IntList destination_list) {
      select_index = (int)ofRandom(location_list.size());
      while (true) {
        if (!destination_list.hasValue(select_index)) {
          destination_list.append(select_index);
          break;
        }
        select_index = (select_index + 1) % location_list.size();
      }
      next_index = select_index;
    }

    //--------------------------------------------------------------
    void update(int frame_span, ArrayList<PVector> location_list, ArrayList<IntList> next_index_list, IntList destination_list) {
      if (ofGetFrameNum() % frame_span == 0) {
        var tmp_index = select_index;
        select_index = next_index;
        IntList ni = next_index_list.get(select_index);
        int retry = ni.size();
        next_index = ni.get((int)ofRandom(ni.size()));
        while (--retry > 0) {
          if (!destination_list.hasValue(next_index)) {
            if (tmp_index != next_index) {
              destination_list.append(next_index);
              break;
            }
          }
          next_index = ni.get((next_index + 1) % ni.size());
        }
        if (retry <= 0) {
          destination_list.append(select_index);
          next_index = select_index;
        }
      }

      var param = ofGetFrameNum() % frame_span;
      PVector locN = location_list.get(next_index);
      PVector locS = location_list.get(select_index);
      var distance = PVector.sub(locN, locS);
      distance.div(frame_span);
      distance.mult(param);
      location = PVector.add(locS, distance);
    }

    //--------------------------------------------------------------
    PVector getLocation() {
      return location;
    }
  }

  //--------------------------------------------------------------
  @Override void setup() {
    PGraphics fbo = createGraphics(width, height);
    fbo.beginDraw();
    fbo.clear();
    fbo.translate(width * 0.5, height * 0.45);
    fbo.fill(0);

    PFont font = createFont("data/HuiFont29.ttf", 195 * 1.2, true);
    fbo.textFont(font);
    fbo.text("風花", -250, 120);
    fbo.text("雪月", -250, 360);
    fbo.endDraw();

    var span = 10;
    for (int x = 0; x < fbo.width; x += span) {
      for (int y = 0; y < fbo.height; y += span) {
        color col = fbo.get(x, y);
        if (col != color(0, 0)) {
          for (int z = span * -1; z <= span; z += span) {
            location_list.add(new PVector(x - fbo.width * 0.5, fbo.height - y - fbo.width * 0.25, z));
          }
        }
      }
    }

    for (var location : location_list) {
      IntList next_index = new IntList();
      int index = -1;
      for (var other : location_list) {
        index++;
        if (location == other) {
          continue;
        }
        float distance = PVector.dist(location, other);
        if (distance <= span) {
          next_index.append(index);
        }
      }
      next_index_list.add(next_index);
    }

    for (int i = 0; i < 350 * 2.5; i++) {
      actor_list.add(new Actor(location_list, destination_list));
    }
  }

  //--------------------------------------------------------------
  void update() {
    int frame_span = 30;
    int prev_index_size = 0;
    if (ofGetFrameNum() % frame_span == 0) {
      prev_index_size = destination_list.size();
    }

    for (var actor : actor_list) {
      actor.update(frame_span, location_list, next_index_list, destination_list);
    }

    if (prev_index_size != 0) {
      for (int i = 0; i < prev_index_size; i++) {
        destination_list.remove(0);
      }
    }

    face.clear();
    frame.clear();

    for (var actor : actor_list) {
      setBoxToMesh(face, frame, actor.getLocation(), 10, 10, 10);
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);
    scale(1, -1, 1);

    // いい感じにするための適当な位置合わせ＼(^_^)／
    translate(width * 0.025, -height * 0.2);
    ofBackground(239);
    ofSetLineWidth(2);

    face.draw(color(239));

    frame.drawWireframe(color(39));
    pop();

    logoRightLower(#ff0000);
  }

  //--------------------------------------------------------------
  PVector vert(PVector loc, float x, float y, float z) {
    return PVector.add(loc, new PVector(x, y, z));
  }
  void setBoxToMesh(ofMesh face_target, ofMesh frame_target, PVector location, float h, float w, float depth) {
    int index = face_target.getVertices().size();

    face_target.addVertex(vert(location, w * -0.5 * 0.99, h * 0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(vert(location, w * 0.5 * 0.99, h * 0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(vert(location, w * 0.5 * 0.99, h * 0.5 * 0.99, depth * 0.5 * 0.99));
    face_target.addVertex(vert(location, w * -0.5 * 0.99, h * 0.5 * 0.99, depth * 0.5 * 0.99));

    face_target.addVertex(vert(location, w * -0.5 * 0.99, h * -0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(vert(location, w * 0.5 * 0.99, h * -0.5 * 0.99, depth * -0.5 * 0.99));
    face_target.addVertex(vert(location, w * 0.5 * 0.99, h * -0.5 * 0.99, depth * 0.5 * 0.99));
    face_target.addVertex(vert(location, w * -0.5 * 0.99, h * -0.5 * 0.99, depth * 0.5 * 0.99));

    face_target.addIndex(index + 0);
    face_target.addIndex(index + 1);
    face_target.addIndex(index + 2);
    face_target.addIndex(index + 0);
    face_target.addIndex(index + 2);
    face_target.addIndex(index + 3);

    face_target.addIndex(index + 4);
    face_target.addIndex(index + 5);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 7);

    face_target.addIndex(index + 0);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 1);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 5);
    face_target.addIndex(index + 1);

    face_target.addIndex(index + 1);
    face_target.addIndex(index + 5);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 2);
    face_target.addIndex(index + 1);

    face_target.addIndex(index + 2);
    face_target.addIndex(index + 6);
    face_target.addIndex(index + 7);
    face_target.addIndex(index + 7);
    face_target.addIndex(index + 3);
    face_target.addIndex(index + 2);

    face_target.addIndex(index + 3);
    face_target.addIndex(index + 7);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 4);
    face_target.addIndex(index + 0);
    face_target.addIndex(index + 3);

    frame_target.addVertex(vert(location, w * -0.5, h * 0.5, depth * -0.5));
    frame_target.addVertex(vert(location, w * 0.5, h * 0.5, depth * -0.5));
    frame_target.addVertex(vert(location, w * 0.5, h * 0.5, depth * 0.5));
    frame_target.addVertex(vert(location, w * -0.5, h * 0.5, depth * 0.5));

    frame_target.addVertex(vert(location, w * -0.5, h * -0.5, depth * -0.5));
    frame_target.addVertex(vert(location, w * 0.5, h * -0.5, depth * -0.5));
    frame_target.addVertex(vert(location, w * 0.5, h * -0.5, depth * 0.5));
    frame_target.addVertex(vert(location, w * -0.5, h * -0.5, depth * 0.5));

    frame_target.addIndex(index + 0);
    frame_target.addIndex(index + 1);
    frame_target.addIndex(index + 1);
    frame_target.addIndex(index + 2);
    frame_target.addIndex(index + 2);
    frame_target.addIndex(index + 3);
    frame_target.addIndex(index + 3);
    frame_target.addIndex(index + 0);

    frame_target.addIndex(index + 4);
    frame_target.addIndex(index + 5);
    frame_target.addIndex(index + 5);
    frame_target.addIndex(index + 6);
    frame_target.addIndex(index + 6);
    frame_target.addIndex(index + 7);
    frame_target.addIndex(index + 7);
    frame_target.addIndex(index + 4);

    frame_target.addIndex(index + 0);
    frame_target.addIndex(index + 4);
    frame_target.addIndex(index + 1);
    frame_target.addIndex(index + 5);
    frame_target.addIndex(index + 2);
    frame_target.addIndex(index + 6);
    frame_target.addIndex(index + 3);
    frame_target.addIndex(index + 7);
  }
  
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}
