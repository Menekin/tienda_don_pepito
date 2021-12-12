
import 'dart:async';
Future<String> firstAsync() async {
  await Future<String?>.delayed(const Duration(seconds: 8));
  return "Proceso largo No. 1 completado!";
}

Future<String> secondAsync() async {
  await Future<String?>.delayed(const Duration(seconds: 4));
  return "Proceso medianamente largo No. 2 completado!";
}

Future<String> thirdAsync() async {
  await Future<String?>.delayed(const Duration(seconds: 1));
  return "Proceso corto No. 3. completado!";
}

void main() async {
  //var f =  firstAsync();
  //print(f);
  //firstAsync().then((value) => print(value));
  var f =  await firstAsync();
  print(f);
  var s = await secondAsync();
  print(s);
  var t = await thirdAsync();
  print(t);
  print('done');
}