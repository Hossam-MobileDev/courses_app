import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/routes/bloc_observer.dart';
import 'package:ulearning_app/common/service/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';


class Global{
  static late StorageService storageService;
  static Future init() async{
    WidgetsFlutterBinding.ensureInitialized();

   // Bloc.observer = MyGlobalObserver();
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
    storageService = await StorageService().init();

  }
}