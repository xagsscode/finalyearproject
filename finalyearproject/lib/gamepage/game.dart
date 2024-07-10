import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> _board =
      List.generate(3, (_) => List.filled(3, '')); // 3x3 board
  String _currentPlayer = 'X';
  String _winner = '';

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] != '' &&
          _board[i][0] == _board[i][1] &&
          _board[i][0] == _board[i][2]) {
        _winner = _board[i][0];
        break;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_board[0][i] != '' &&
          _board[0][i] == _board[1][i] &&
          _board[0][i] == _board[2][i]) {
        _winner = _board[0][i];
        break;
      }
    }

    // Check diagonals
    if (_board[0][0] != '' &&
        _board[0][0] == _board[1][1] &&
        _board[0][0] == _board[2][2]) {
      _winner = _board[0][0];
    } else if (_board[0][2] != '' &&
        _board[0][2] == _board[1][1] &&
        _board[0][2] == _board[2][0]) {
      _winner = _board[0][2];
    }

    if (_winner != '') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('$_winner wins!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetGame();
                },
                child: Text('Play Again'),
              ),
            ],
          );
        },
      );
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, ''));
      _currentPlayer = 'X';
      _winner = '';
    });
  }

  void _markCell(int row, int col) {
    if (_board[row][col] == '' && _winner == '') {
      setState(() {
        _board[row][col] = _currentPlayer;
        _checkWinner();
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < 3; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int j = 0; j < 3; j++)
                    GestureDetector(
                      onTap: () => _markCell(i, j),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Center(
                          child: Text(
                            _board[i][j],
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            SizedBox(height: 20),
            if (_winner == '')
              Text('Current Player: $_currentPlayer')
            else
              Text('$_winner wins!'),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor),
              onPressed: _resetGame,
              child: Text(
                'Reset Game',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
