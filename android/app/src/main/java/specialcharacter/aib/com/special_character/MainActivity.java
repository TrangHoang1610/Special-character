package specialcharacter.aib.com.special_character;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import vn.aib.ratedialog.RatingDialog;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements RatingDialog.RatingDialogInterFace {
  private static final String CHANNEL = "app";


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                String filePath = methodCall.argument("filePath");

                switch(methodCall.method) {
                  case "rate":
                    showRateDialog();
                    break;
                  case "showRate":
                    showRate();
                }
              }
            }
    );

  }


  public void showRate() {

      RatingDialog ratingDialog = new RatingDialog(this);
      ratingDialog.setRatingDialogListener(this);
      ratingDialog.showDialog();

  }
  public void showRateDialog() {
    int count = SharedPrefsUtils.getInstance(this).getInt("rate");
    if (count < 2) {
      RatingDialog ratingDialog = new RatingDialog(this);
      ratingDialog.setRatingDialogListener(this);
      ratingDialog.showDialog();
    }
  }

  @Override
  public void onDismiss() {

  }

  @Override
  public void onSubmit(float rating) {
    if(rating > 3)
    {
      int count = SharedPrefsUtils.getInstance(this).getInt("rate");
      count++;
      SharedPrefsUtils.getInstance(this).putInt("rate", count);
      rateApp(this);
    }
  }

  @Override
  public void onRatingChanged(float v) {

  }

  public static void rateApp(Context context) {
    Intent intent = new Intent(new Intent(Intent.ACTION_VIEW,
            Uri.parse("http://play.google.com/store/apps/details?id=" + context.getPackageName())));
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    context.startActivity(intent);
  }

}

