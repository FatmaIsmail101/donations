package com.example.donations;

import androidx.annotation.NonNull;
import com.nearpay.sdk.NearPayConfig;
import com.nearpay.sdk.NearPayEnvironment;
import com.nearpay.sdk.NearPaySDK;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;



public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "nearpay_channel";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // إعداد الـ Credentials
        String clientKey = "32e19992-b164-492d-84d9-4ee89d6285d2";
        String apiKey = "gaNJsVCXVm8H2DTKzkRViCjJHtCXv3Glkye3PEDvZuL0sSOVokdxHa4s7SW7";
        String jwtKey = "JWT Key لو مطلوب";

        NearPayConfig config = new NearPayConfig.Builder()
                .clientKey(clientKey)
                .apiKey(apiKey)
                .jwtKey(jwtKey)
                .environment(NearPayEnvironment.SANDBOX) // أو PRODUCTION
                .build();

        NearPaySDK.initialize(this, config);

        // إعداد Platform Channel للتواصل مع Flutter
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("startPayment")) {
                                int amount = call.argument("amount");
                                String paymentResult = NearPaySDK.startPayment(amount); // استدعاء SDK
                                result.success(paymentResult);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}
