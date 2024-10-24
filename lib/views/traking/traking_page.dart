// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geotraking/core/models/member.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrakingPage extends StatefulWidget {
  const TrakingPage({
    Key? key,
  }) : super(key: key);

  @override
  _TrakingPageState createState() => _TrakingPageState();
}

class _TrakingPageState extends State<TrakingPage> {
  WebViewController? _controller;
  bool _isLoading = true;
  String _url = 'https://geotraking.com/#/login';
  final _authService = AuthService();
  MemberUser? _user;
  bool _isLoggedIn = false;

  _checkLoggedIn() async {
    final user = await _authService.getCurrentUser();

    if (user != null) {
      print(
          'Current User: ${user.id}, ${user.name}, ${user.email}, ${user.noHp}, ${user.isAdmin}, ${user.avatar}');
      setState(() {
        _isLoggedIn = true;
        _user = user;

        if (_user!.isAdmin == 2) {
          _url = 'https://apn.geotraking.com';
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            Future.delayed(const Duration(milliseconds: 500), () {
              if (_isLoggedIn && _user != null) {
                _controller!.runJavaScript("""
                  const emailInput = document.querySelector('input[name="email"]');
                  emailInput.value = "${_user!.email}";
                  """);
                // Uncomment to set the password field as readonly as well
                // _controller!.runJavaScript(
                //   "document.querySelector('input[name=\"password\"]').value = \"jakarta2023\"; document.querySelector('input[name=\"password\"]').readOnly = true;"
                // );
              }
            });

            // Future.delayed(const Duration(milliseconds: 500), () {
            //   if (_isLoggedIn && _user != null) {
            //     _controller!.runJavaScript(
            //       "document.querySelector('input[name=\"email\"]').value = \"${_user!.email}\";",
            //     );
            //   }
            //   // _controller!.runJavaScript(
            //   //   "document.querySelector('input[name=\"password\"]').value = \"jakarta2023\";",
            //   // );
            // });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    Future.delayed(Duration(milliseconds: 1000), () {
      _controller!.loadRequest(Uri.parse(_url));
    });

    // ..loadRequest(Uri.parse('https://geotraking.com/#/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(60.0),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(20.0),
      //       bottomRight: Radius.circular(20.0),
      //     ),
      //     child: AppBar(
      //       title: RichText(
      //         text: TextSpan(
      //           children: [
      //             TextSpan(
      //               text: 'Geo',
      //               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
      //                     color: Colors.black,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //             ),
      //             TextSpan(
      //               text: 'TrakingWeb',
      //               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
      //                     color: Color.fromARGB(255, 13, 124, 102),
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       automaticallyImplyLeading: false,
      //       backgroundColor: Colors.red,
      //       elevation: 0,
      //     ),
      //   ),
      // ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          // : Container(
          //     child: Column(
          //       children: [
          //         SizedBox(
          //           height: 15,
          //         ),
          //         WebViewWidget(controller: _controller!),
          //       ],
          //     ),
          //   ),
          // : Padding(
          //     padding: const EdgeInsets.only(top: 20),
          //     child: WebViewWidget(controller: _controller!),
          //   ),
          : SafeArea(child: WebViewWidget(controller: _controller!),)
      // : WebViewWidget(controller: _controller!),
    );
  }
}
