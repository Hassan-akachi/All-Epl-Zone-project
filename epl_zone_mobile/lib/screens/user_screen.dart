// // lib/screens/user_settings_screen.dart
//
// import 'package:flutter/material.dart';
//
// import '../util/constant.dart';
//
// class UserSettingsScreen extends StatefulWidget {
//   const UserSettingsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<UserSettingsScreen> createState() => _UserSettingsScreenState();
// }
//
// class _UserSettingsScreenState extends State<UserSettingsScreen> {
//   bool _notificationsEnabled = true;
//   bool _darkModeEnabled = false;
//   bool _autoPlayVideos = false;
//   String _selectedLanguage = 'English';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // User Profile Section
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Theme.of(context).colorScheme.primary,
//                     Theme.of(context).colorScheme.primary.withOpacity(0.7),
//                   ],
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: 50,
//                         backgroundColor: Colors.white,
//                         child: Icon(
//                           Icons.person,
//                           size: 60,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).colorScheme.secondary,
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.camera_alt,
//                             size: 20,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'John Doe',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'john.doe@example.com',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white70,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.pushNamed(context, RouteEditingProfile);
//                     },
//                     icon: const Icon(Icons.edit, size: 18),
//                     label: const Text('Edit Profile'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: Theme.of(context).colorScheme.primary,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Account Section
//             _buildSectionHeader('Account'),
//             _buildSettingsTile(
//               icon: Icons.person_outline,
//               title: 'Personal Information',
//               subtitle: 'Update your personal details',
//               onTap: () {
//                 // Navigate to personal info screen
//               },
//             ),
//             _buildSettingsTile(
//               icon: Icons.lock_outline,
//               title: 'Change Password',
//               subtitle: 'Update your password',
//               onTap: () {
//                 // Navigate to change password screen
//               },
//             ),
//             _buildSettingsTile(
//               icon: Icons.favorite_outline,
//               title: 'Favorite Teams',
//               subtitle: 'Manage your favorite teams',
//               trailing: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   '3',
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.primary,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               onTap: () {
//                 // Navigate to favorite teams screen
//               },
//             ),
//
//             const Divider(height: 1),
//
//             // Preferences Section
//             _buildSectionHeader('Preferences'),
//             SwitchListTile(
//               secondary: const Icon(Icons.notifications_outlined),
//               title: const Text('Push Notifications'),
//               subtitle: const Text('Receive match updates and news'),
//               value: _notificationsEnabled,
//               onChanged: (value) {
//                 setState(() {
//                   _notificationsEnabled = value;
//                 });
//               },
//             ),
//             SwitchListTile(
//               secondary: const Icon(Icons.dark_mode_outlined),
//               title: const Text('Dark Mode'),
//               subtitle: const Text('Enable dark theme'),
//               value: _darkModeEnabled,
//               onChanged: (value) {
//                 setState(() {
//                   _darkModeEnabled = value;
//                 });
//               },
//             ),
//             SwitchListTile(
//               secondary: const Icon(Icons.play_circle_outline),
//               title: const Text('Auto-play Videos'),
//               subtitle: const Text('Videos play automatically'),
//               value: _autoPlayVideos,
//               onChanged: (value) {
//                 setState(() {
//                   _autoPlayVideos = value;
//                 });
//               },
//             ),
//             _buildSettingsTile(
//               icon: Icons.language_outlined,
//               title: 'Language',
//               subtitle: _selectedLanguage,
//               trailing: const Icon(Icons.chevron_right),
//               onTap: () {
//                 _showLanguageDialog();
//               },
//             ),
//
//             const Divider(height: 1),
//
//             // Other Section
//             _buildSectionHeader('Other'),
//             _buildSettingsTile(
//               icon: Icons.help_outline,
//               title: 'Help & Support',
//               subtitle: 'Get help and contact support',
//               onTap: () {
//                 // Navigate to help screen
//               },
//             ),
//             _buildSettingsTile(
//               icon: Icons.info_outline,
//               title: 'About',
//               subtitle: 'App version 1.0.0',
//               onTap: () {
//                 _showAboutDialog();
//               },
//             ),
//             _buildSettingsTile(
//               icon: Icons.privacy_tip_outlined,
//               title: 'Privacy Policy',
//               subtitle: 'Read our privacy policy',
//               onTap: () {
//                 // Navigate to privacy policy
//               },
//             ),
//             _buildSettingsTile(
//               icon: Icons.description_outlined,
//               title: 'Terms of Service',
//               subtitle: 'Read our terms of service',
//               onTap: () {
//                 // Navigate to terms of service
//               },
//             ),
//
//             const Divider(height: 1),
//
//             // Logout Button
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: OutlinedButton.icon(
//                   onPressed: () {
//                     _showLogoutDialog();
//                   },
//                   icon: const Icon(Icons.logout),
//                   label: const Text('Log Out'),
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: Colors.red,
//                     side: const BorderSide(color: Colors.red),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             // Delete Account
//             Center(
//               child: TextButton(
//                 onPressed: () {
//                   _showDeleteAccountDialog();
//                 },
//                 child: const Text(
//                   'Delete Account',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//           color: Theme.of(context).colorScheme.primary,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSettingsTile({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     Widget? trailing,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       subtitle: Text(subtitle),
//       trailing: trailing ?? const Icon(Icons.chevron_right),
//       onTap: onTap,
//     );
//   }
//
//   void _showLanguageDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Select Language'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             RadioListTile<String>(
//               title: const Text('English'),
//               value: 'English',
//               groupValue: _selectedLanguage,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedLanguage = value!;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Spanish'),
//               value: 'Spanish',
//               groupValue: _selectedLanguage,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedLanguage = value!;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('French'),
//               value: 'French',
//               groupValue: _selectedLanguage,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedLanguage = value!;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('German'),
//               value: 'German',
//               groupValue: _selectedLanguage,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedLanguage = value!;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAboutDialog() {
//     showAboutDialog(
//       context: context,
//       applicationName: 'PremierZone',
//       applicationVersion: '1.0.0',
//       applicationIcon: Icon(
//         Icons.sports_soccer,
//         size: 48,
//         color: Theme.of(context).colorScheme.primary,
//       ),
//       children: [
//         const Text(
//           'Your comprehensive Premier League statistics platform. '
//               'Stay updated with live scores, player stats, and team information.',
//         ),
//       ],
//     );
//   }
//
//   void _showLogoutDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Log Out'),
//         content: const Text('Are you sure you want to log out?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // TODO: Implement logout logic
//               Navigator.pop(context);
//               Navigator.pushReplacementNamed(context, '/signin');
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//             ),
//             child: const Text('Log Out'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showDeleteAccountDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Account'),
//         content: const Text(
//           'Are you sure you want to delete your account? '
//               'This action cannot be undone and all your data will be permanently deleted.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // TODO: Implement delete account logic
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Account deletion requested'),
//                 ),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//             ),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );
//   }
// }




// lib/features/user/screens/user_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider/auth_controller.dart';
import '../provider/auth_provider/auth_provider.dart';
import '../util/constant.dart';

class UserSettingsScreen extends ConsumerStatefulWidget {
  const UserSettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends ConsumerState<UserSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _autoPlayVideos = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final authStateAsync = ref.watch(authStateProvider);
    final currentUserAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: authStateAsync.when(
        data: (isLoggedIn) {
          if (!isLoggedIn) {
            return _buildNotLoggedInView();
          }

          return currentUserAsync.when(
            data: (user) => _buildLoggedInView(user),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => _buildErrorView(error),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorView(error),
      ),
    );
  }

  Widget _buildNotLoggedInView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_off_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'Not Logged In',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to access your profile and settings',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, RouteSignIn);
              },
              icon: const Icon(Icons.login),
              label: const Text('Sign In'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteSignUp);
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoggedInView(dynamic user) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Profile Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Text(
                        '${user.firstName[0]}${user.lastName[0]}'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                if (user.phoneNumber != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    user.phoneNumber!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteEditingProfile);
                  },
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Account Section
          _buildSectionHeader('Account'),
          _buildSettingsTile(
            icon: Icons.person_outline,
            title: 'Personal Information',
            subtitle: 'Update your personal details',
            onTap: () {
              Navigator.pushNamed(context, RouteEditingProfile);
            },
          ),
          _buildSettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () {
              // TODO: Navigate to change password screen
            },
          ),
          _buildSettingsTile(
            icon: Icons.favorite_outline,
            title: 'Favorite Teams',
            subtitle: 'Manage your favorite teams',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '0',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              // TODO: Navigate to favorite teams screen
            },
          ),

          const Divider(height: 1),

          // Preferences Section
          _buildSectionHeader('Preferences'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive match updates and news'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme'),
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.play_circle_outline),
            title: const Text('Auto-play Videos'),
            subtitle: const Text('Videos play automatically'),
            value: _autoPlayVideos,
            onChanged: (value) {
              setState(() {
                _autoPlayVideos = value;
              });
            },
          ),
          _buildSettingsTile(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: _selectedLanguage,
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showLanguageDialog();
            },
          ),

          const Divider(height: 1),

          // Other Section
          _buildSectionHeader('Other'),
          _buildSettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get help and contact support',
            onTap: () {
              // TODO: Navigate to help screen
            },
          ),
          _buildSettingsTile(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'App version 1.0.0',
            onTap: () {
              _showAboutDialog();
            },
          ),
          _buildSettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            onTap: () {
              // TODO: Navigate to privacy policy
            },
          ),
          _buildSettingsTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            subtitle: 'Read our terms of service',
            onTap: () {
              // TODO: Navigate to terms of service
            },
          ),

          const Divider(height: 1),

          // Logout Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showLogoutDialog();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),

          // Delete Account
          Center(
            child: TextButton(
              onPressed: () {
                _showDeleteAccountDialog();
              },
              child: const Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildErrorView(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to load profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(currentUserProvider);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Spanish'),
              value: 'Spanish',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('French'),
              value: 'French',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('German'),
              value: 'German',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'EPL Zone',
      applicationVersion: '1.0.0',
      applicationIcon: Icon(
        Icons.sports_soccer,
        size: 48,
        color: Theme.of(context).colorScheme.primary,
      ),
      children: const [
        Text(
          'Your comprehensive Premier League statistics platform. '
              'Stay updated with live scores, player stats, and team information.',
        ),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(authControllerProvider.notifier).signOut();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
                Navigator.pushReplacementNamed(context, RouteHome);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? '
              'This action cannot be undone and all your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement delete account logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion requested'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}