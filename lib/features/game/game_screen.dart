import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restify_flutter/core/constants/app_assets.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';
import 'package:restify_flutter/core/theme/app_typography.dart';
import 'package:restify_flutter/features/game/game_logic.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameLogic _game = GameLogic();

  // State to toggle between Menu and Game Board
  bool _isGameActive = false;

  // Colors
  final Color _colorX = kColorGray;
  final Color _colorO = kColorOrange;

  // --- GAME ACTIONS ---

  void _startGame(bool isHard) {
    setState(() {
      _game.resetGame(isHard);
      _isGameActive = true;
    });
  }

  void _quitGame() {
    setState(() {
      _isGameActive = false;
    });
  }

  void _handleTap(int index) {
    if (_game.winner != '') return;

    // 1. Player Move
    bool moved = _game.playerMove(index);
    if (!moved) return;
    setState(() {}); // Update UI

    // 2. Check Win
    if (_game.winner != '') return;

    // 3. AI Turn
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _game.makeAIMove();
      });
    });
  }

  // --- UI BUILDERS ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorCream,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: _isGameActive ? _buildGameUI() : _buildMenuUI(),
          ),
        ),
      ),
    );
  }

  // 1. MENU UI (Image + Buttons)
  Widget _buildMenuUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 45),
        Text(
          "TIC TAC TOE",
          style: TextStyle(
            fontFamily: kFontFamilyRobotoCondensed,
            fontSize: 64,
            height: 69.18 / 64,
            fontWeight: FontWeight.w700,
            color: kColorOrange,
          ),
        ),
        const SizedBox(height: 43),

        // Game Board Image (Decoration)
        Center(
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                AppAssets.gameBoard,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        // Mode Buttons
        _buildButton("Easy Mode", () => _startGame(false)),
        const SizedBox(height: 30),
        _buildButton("Hard Mode", () => _startGame(true)),
      ],
    );
  }

  // 2. GAME UI (Status + Board + Reset/Play Again)
  Widget _buildGameUI() {
    return Column(
      children: [
        // Top Bar with Back Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Row(
            children: [
              GestureDetector(
                onTap: _quitGame,
                child: SvgPicture.asset(
                  AppAssets.iconBack,
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Title
        Text(
          "TIC TAC TOE",
          style: TextStyle(
            fontFamily: kFontFamilyRobotoCondensed,
            fontSize: 64,
            height: 69.18 / 64,
            fontWeight: FontWeight.w700,
            color: kColorOrange,
          ),
        ),

        const SizedBox(height: 37),

        // Status Text
        Text(
          _game.statusMessage,
          style: kAppTypography.titleLarge?.copyWith(
            fontSize: 28,
            color: _game.winner != ''
                ? (_game.winner == 'X' ? _colorX : kColorOrange)
                : kColorGray,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 28),

        // Game Board
        Center(
          child: Container(
            width: 320,
            height: 320,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kColorBeige,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xBFF1B869),
                  blurRadius: 4,
                  offset: Offset(0, 6),
                )
              ],
            ),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: 9,
              itemBuilder: (context, index) => _buildGridItem(index),
            ),
          ),
        ),

        const SizedBox(height: 43),

        // Dynamic Buttons Logic
        if (_game.winner == '')
          _buildButton("Reset", () => _startGame(_game.isHardMode))
        else ...[
          _buildButton("Play Again", () => _startGame(_game.isHardMode)),
          const SizedBox(height: 15),
          _buildButton(
            _game.isHardMode ? "Easy Mode" : "Hard Mode",
            () => _startGame(!_game.isHardMode),
          ),
        ],
      ],
    );
  }

  Widget _buildGridItem(int index) {
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: Container(
        decoration: BoxDecoration(
          color: kColorCream,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
             BoxShadow(
              color: kColorOrange,
              blurRadius: 0,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ]
        ),
        child: Center(
          child: _game.board[index] == 'X'
            ? SvgPicture.asset(
              'assets/icons/x.svg',
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(_colorX, BlendMode.srcIn),
            )
            : _game.board[index] == 'O'
              ? SvgPicture.asset(
                'assets/icons/o.svg',
                width: 40,
                height: 40,
                colorFilter: ColorFilter.mode(_colorO, BlendMode.srcIn),
              )
            : null,
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        height: 60,
        decoration: BoxDecoration(
          color: kColorOrange,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: kColorBlack.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: kAppTypography.bodyLarge?.copyWith(
              color: kColorBlack,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}