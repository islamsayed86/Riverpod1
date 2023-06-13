import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_1/screens/stream_screen/ticker_stream_provider.dart';

class StreamScreen extends ConsumerWidget {
  const StreamScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final names = ref.watch(namesProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Stream',
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => ref.refresh(tickerProvider),
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: Center(
          child: names.when(
              data: (names) => Center(
                    child: ListView.builder(
                      itemCount: names.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                          names.elementAt(index),
                        ),
                      ),
                    ),
                  ),
              error: (object, _) => const Text(
                    'Reatched The End Of The List',
                  ),
              loading: () => const Padding(
                    padding: EdgeInsetsDirectional.all(
                      50,
                    ),
                    child: CircularProgressIndicator(),
                  )),
        ));
  }
}
