premier_zone/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── core/
│   │   └── theme/
│   │       └── app_theme.dart             # Theme configuration
│   ├── models/
│   │   ├── player.dart                    # Player model
│   │   └── player_filters.dart            # Filter model
│   ├── services/
│   │   └── player_api_service.dart        # API service
│   ├── widgets/
│   │   ├── search_bar_widget.dart         # Search bar
│   │   ├── feature_card.dart              # Home feature cards
│   │   ├── team_card.dart                 # Team cards
│   │   └── nation_card.dart               # Nation cards (not needed, inline now)
│   └── screens/
│       ├── home_screen.dart               # Home
│       ├── teams_screen.dart              # Teams
│       ├── nations_screen.dart            # Nations (with gradients)
│       ├── positions_screen.dart          # Positions (with colors)
│       └── player_data_screen.dart        # Player data table
├── pubspec.yaml
├── android/
│   └── app/src/main/AndroidManifest.xml  # Android config
└── ios/
└── Runner/Info.plist                   # iOS config