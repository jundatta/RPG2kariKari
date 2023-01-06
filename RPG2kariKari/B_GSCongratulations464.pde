// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】P_Malinさん
// 【作品名】Spout
// https://www.shadertoy.com/view/lsXGzH
//

class GameSceneCongratulations464 extends GameSceneCongratulationsBase {
  PShader sd;
  int startMillis;
  int startCount;

  @Override void setup() {
    noStroke();
    textureWrap(REPEAT);

    sd = loadShader("data/464/Shadertoy.glsl");
    sd.set("iResolution", (float)width, (float)height, 0.0f);
    sd.set("iChannel0", loadImage("data/464/iChannel0.jpg"));
    //sd.set("iChannel1", loadImage("iChannel1.png"));
    //sd.set("iChannel2", loadImage("iChannel2.png"));

    // 最初のミリ秒を取り込んでおく
    startMillis = millis();
    startCount = frameCount;
  }
  @Override void draw() {
    push();
    // ※Shadertoyの場合、透明度は指定しても反映されない
    // void mainImage( out vec4 fragColor, in vec2 fragCoord )の
    // fragCoordの透明度の指定は反映されない
    // なのでfragCoordの透明度は1.0（不透明）固定で返すように注意する
    //  background(0);
    // 最初からのミリ秒として渡したいのでstartMillisをmillis()から引く
    sd.set("iTime", (millis() - startMillis) / 1000.0f);
    //sd.set("iFrame", frameCount - startCount);
    // iMouseのz,wはそれぞれマウスドラッグ時のx,y座標になるが
    // シミュレートをあきらめる
    // このためz,wにはそれぞれ0.0fを固定で渡す
    sd.set("iMouse", (float)mouseX, (float)mouseY, 0.0f, 0.0f);
    shader(sd);
    rect(0, 0, width, height);
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
