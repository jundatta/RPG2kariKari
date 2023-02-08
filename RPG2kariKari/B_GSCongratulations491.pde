// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Jelly beans. Draw by openFrameworks
// https://junkiyoshi.com/openframeworks20230128/
//

class GameSceneCongratulations491 extends GameSceneCongratulationsBase {
  @Override void setup() {
  }
  @Override void draw() {
    push();
    colorMode(HSB, 255, 255, 255);
    translate(width * 0.5f, height * 0.5f);
    background(0, 0, 200);  // ちょっと暗めにしてみました
    noStroke();

    int numberOfActor = 255;

    ofSeedRandom(39);
    for (int i = 0; i < numberOfActor; i++) {
      PVector noise_seed = new PVector(random(1000), random(1000));

      fill(0, 0, 255);
      for (int k = 0; k < 35; k++) {
        PVector location = new PVector(
          map(openFrameworksNoise.ofNoise(noise_seed.x, k * 0.002 + ofGetFrameNum() * 0.001), 0, 1, -350, 350),
          map(openFrameworksNoise.ofNoise(noise_seed.y, k * 0.002 + ofGetFrameNum() * 0.001), 0, 1, -350, 350));
        circle(location.x, location.y, 12 * 2);
      }

      fill(random(255), 100, 255);
      for (int k = 0; k < 35; k++) {
        PVector location = new PVector(
          map(openFrameworksNoise.ofNoise(noise_seed.x, k * 0.002 + ofGetFrameNum() * 0.001), 0, 1, -350, 350),
          map(openFrameworksNoise.ofNoise(noise_seed.y, k * 0.002 + ofGetFrameNum() * 0.001), 0, 1, -350, 350));
        circle(location.x, location.y, 8 * 2);
      }
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
