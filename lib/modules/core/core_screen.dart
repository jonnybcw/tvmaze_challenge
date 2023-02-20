import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvmaze_challenge/modules/core/bloc/core_bloc.dart';
import 'package:tvmaze_challenge/modules/favorites/favorites_tab.dart';
import 'package:tvmaze_challenge/modules/home/home_tab.dart';
import 'package:tvmaze_challenge/modules/search/search_tab.dart';
import 'package:tvmaze_challenge/util/components/error_component.dart';

class CoreScreen extends StatefulWidget {
  const CoreScreen({Key? key}) : super(key: key);

  @override
  State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  late CoreBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CoreBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state) {
          if (state is CoreFirstAccess) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 104,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Please set up a 6-digit PIN to secure the application:',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    _pinTextField(
                      controller: state.pinController,
                    ),
                    if (state.canAuthenticateWithBiometrics)
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                                'Use fingerprint authentication to sign in'),
                          ),
                          Switch(
                            value: state.useFingerprintAuthentication,
                            onChanged: (value) {
                              bloc.add(AllowFingerprintToggled(value: value));
                            },
                            inactiveTrackColor: Colors.grey,
                          ),
                        ],
                      )
                  ],
                ),
              ),
            );
          } else if (state is CoreUnauthenticated) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 104,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome again!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Please enter your 6-digit PIN:',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    _pinTextField(
                      controller: state.pinController,
                    ),
                    if (state.wrongPin)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Wrong PIN. Please try again.',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.red,
                                  ),
                        ),
                      ),
                    if (state.canAuthenticateWithBiometrics &&
                        state.useFingerprintAuthentication)
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: InkWell(
                          onTap: () {
                            bloc.add(FingerprintIconTapped());
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: const Icon(
                            Icons.fingerprint,
                            size: 56,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          } else if (state is GetPixBoxFailed) {
            return Scaffold(
              body: ErrorComponent(
                onTapRetry: () {
                  bloc.add(RetryTapped());
                },
              ),
            );
          } else if (state is CoreAuthenticated) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.currentIndex,
                onTap: (newIndex) {
                  bloc.add(NavigationBarItemPressed(newIndex: newIndex));
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search_rounded),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'My Favorites',
                  ),
                ],
              ),
              body: _getBody(context, state),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, CoreState state) {
    if (state.currentIndex == 0) {
      return const HomeTab();
    } else if (state.currentIndex == 1) {
      return const SearchTab();
    } else {
      return const FavoritesTab();
    }
  }

  Widget _pinTextField({required TextEditingController controller}) {
    return SizedBox(
      height: 120,
      child: TextField(
        controller: controller,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 48,
            ),
        onChanged: (value) {
          bloc.add(PinChanged(pin: value));
        },
        maxLength: 6,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        autofocus: true,
        obscureText: true,
      ),
    );
  }
}
