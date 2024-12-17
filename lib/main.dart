import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:text_to_speech/config/supbase_service.dart';
import 'package:text_to_speech/src/count/bloc/count_bloc.dart';
import 'package:text_to_speech/src/count/events/count_event.dart';
import 'package:text_to_speech/src/count/states/count_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // get dotenv
  await dotenv.load(fileName: ".env");
  SupbaseConfig().initSupabase(
      dotenv.env['SUPABASE_URL'].toString(), dotenv.env['SUPABASE_CLIENT_API_KEY'].toString());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter Value:',
            ),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  '${state.count}',
                  // style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterBloc.add(IncrementEvent());
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
