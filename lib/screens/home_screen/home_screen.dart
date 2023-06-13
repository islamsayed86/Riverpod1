import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_1/screens/home_screen/home_provider.dart';
import 'package:riverpod_1/screens/stream_screen/stream_screen.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'weather',
          ),
        ),
      ),
      body: Column(
        children: [
          currentWeather.when(
            data: (data) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                data,
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            error: (object, _) => const Text('Error 😥'),
            loading: () => const Padding(
              padding: EdgeInsetsDirectional.all(
                50,
              ),
              child: CircularProgressIndicator(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,
              itemBuilder: (context, index) {
                final city = City.values[index];
                final isSelected = city == ref.watch(currentCityProvider);
                return ListTile(
                  title: Text(
                    city.toString(),
                  ),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () =>
                      ref.read(currentCityProvider.notifier).state = city,
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const StreamScreen(),
                ),
              );
            },
            child: const Text(
              'Stream',
            ),
          ),
          const SizedBox(
            height: 200,
          ),
        ],
      ),
    );
  }
}
