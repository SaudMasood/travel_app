import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../block/info_bloc.dart';
import '../block/info_event.dart';
import '../block/info_state.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    super.initState();

    context.read<InfoBloc>().add(
      const LoadInfo(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      appBar: AppBar(
        backgroundColor: const Color(0xFF172554),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Travel Info',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<InfoBloc, InfoState>(
        builder: (context, state) {
          if (state is InfoLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4F46E5),
              ),
            );
          }

          if (state is InfoError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            );
          }

          if (state is InfoLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'My Location',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFBAE6FD),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'IP: ${state.ipLocation.ip}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'City: ${state.ipLocation.city}',
                      ),
                      Text(
                        'Country: ${state.ipLocation.countryName}',
                      ),
                      Text(
                        'Region: ${state.ipLocation.region}',
                      ),
                      Text(
                        'Timezone: ${state.ipLocation.timezone}',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Countries',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 10),

                for (var country in state.countries.take(10))
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 45,
                        height: 35,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F7FA),
                          borderRadius:
                          BorderRadius.circular(8),
                        ),
                        child: Image.network(
                          country['flags']?['png'] ?? '',
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stack) {
                            return const Icon(
                              Icons.flag,
                              color: Color(0xFF0891B2),
                            );
                          },
                        ),
                      ),
                      title: Text(
                        country['name']?['common'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF172554),
                        ),
                      ),
                      subtitle: Text(
                        country['region'] ?? '',
                      ),
                    ),
                  ),

                const SizedBox(height: 25),

                const Text(
                  'Travel Photos',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 10),

                for (var photo in state.photos)
                  Container(
                    height: 180,
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F7FA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        photo.downloadUrl,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stack) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 45,
                              color: Color(0xFF0891B2),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                const SizedBox(height: 25),

                const Text(
                  'Travelers',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 10),

                for (var user in state.users)
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: ClipOval(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.network(
                            user.image,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stack) {
                              return const Icon(
                                Icons.person,
                                size: 40,
                                color: Color(0xFF4F46E5),
                              );
                            },
                          ),
                        ),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF172554),
                        ),
                      ),
                      subtitle: Text(
                        '${user.country}\n${user.email}',
                      ),
                    ),
                  ),

                const SizedBox(height: 25),

                const Text(
                  'Travel Pets',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 10),

                for (var dog in state.dogs)
                  Container(
                    height: 180,
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F7FA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        dog.image,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stack) {
                          return const Center(
                            child: Icon(
                              Icons.pets,
                              size: 45,
                              color: Color(0xFF0891B2),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            );
          }

          return const Center(
            child: Text('Loading...'),
          );
        },
      ),
    );
  }
}