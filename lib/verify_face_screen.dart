import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VerifyFaceScreen extends StatefulWidget {
  // late String _urlVerify;
  final String urlVerify;

  @override
  State<VerifyFaceScreen> createState() => _VerifyFaceState();

  VerifyFaceScreen({required this.urlVerify, Key? key}) : super(key: key);
}

Color primaryColor = Color(0xFF233970); // 0xFFA42037 - 0xFF2C399F

class _VerifyFaceState extends State<VerifyFaceScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  InAppWebViewSettings settings = InAppWebViewSettings(
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  bool loaded = false;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: Text("Verificación biométrica"),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            fit: StackFit.expand,
            children: [WebView()],
          ),
        ),
      ),
    );
  }

  Widget WebView() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () async {
            Navigator.of(context)..pop();
          },
          child: const Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () async {
            Navigator.of(context)..pop();
          },
        ),
      ),
      body: InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: WebUri(widget.urlVerify)),
          initialUserScripts: UnmodifiableListView<UserScript>([]),
          initialSettings: settings,
          onWebViewCreated: (controller) async {
            webViewController = controller;
          },
          onLoadStart: (controller, url) async {},
          onPermissionRequest: (controller, request) async {
            return PermissionResponse(
                resources: request.resources,
                action: PermissionResponseAction.GRANT);
          },
          onLoadStop: (controller, url) async {
            // Serializa el objeto MyDataClass a JSON
            //   // String dataJson = jsonEncode(widget.data.toJson());

            //   // Inyecta los datos en la página web
            //   await controller.evaluateJavascript(source: """
            //   window.flutterData = $dataJson;
            // """);

            //   controller.addJavaScriptHandler(
            //       handlerName: 'resultHandler',
            //       callback: (args) {
            //         Navigator.pop(context, "OK");
            //       });

            //   await controller.evaluateJavascript(source: """
            //                     window.addEventListener( "onFinalResult", (e) => { window.flutter_inappwebview.callHandler('resultHandler', e.detail); });
            //                     """);
          },
          onReceivedError: (controller, request, error) async {},
          onReceivedHttpError: (controller, request, error) async {},
          onProgressChanged: (controller, progress) {}),
    );
  }
}

Widget LoadingWidget(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: Text("Cargando..."),
  );
}

Widget ErrorWidget(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: Text("Error!"),
  );
}
