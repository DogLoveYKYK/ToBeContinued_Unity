using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class CaptureGameView : MonoBehaviour
{
    public void Capture()
    {

        // GameViewを取得してくる
        var assembly = typeof(EditorWindow).Assembly;
        var type = assembly.GetType("UnityEditor.GameView");
        var gameview = EditorWindow.GetWindow(type);
        // GameViewを再描画
        gameview.Repaint();


        // 現在時刻からファイル名を決定
        var filename = "ToBeContinued_" + System.DateTime.Now.ToString("yyyyMMdd-HHmmss") + ".png";
        // キャプチャを撮る
        ScreenCapture.CaptureScreenshot(filename); // ← GameViewにフォーカスがない場合、この時点では撮られない

    }

}
