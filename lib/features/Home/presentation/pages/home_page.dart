import 'package:dance_fever/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dance_fever/features/auth/presentation/bloc/auth_event.dart';
import 'package:dance_fever/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticatedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 100,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Email: ${state.userEntity.email}'),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Name: ${state.userEntity.name}'),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
