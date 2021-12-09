#include "terminal.h"

#include <stdio.h>
#include <string.h>

#ifdef __linux__

#include <termios.h>
#include <unistd.h>

void ClearScreen(void) { printf("%c[H%c[J", ESC, ESC); }
void MoveCursor(int row, int col) { printf("%c[%d;%dH", ESC, col, row); }

bool KeyHit(void) {
  int ch;
  struct termios old;
  struct termios new;

  tcgetattr(STDIN_FILENO, &old);
  memcpy(&new, &old, sizeof(new));

  new.c_lflag &= ~(ICANON | ECHO);
  new.c_cc[VMIN] = 1;
  new.c_cc[VTIME] = 0;

  tcsetattr(STDIN_FILENO, TCSANOW, &new);
  ch = getchar();
  tcsetattr(STDIN_FILENO, TCSANOW, &old);

  // if (ch != -1) {
  //   ungetc(ch, stdin);
  // }
  return ((ch != -1) ? true : false);
}

/*
#include <sys/ioctl.h>

void ScreenSize(void) {
  struct winsize w;
  ioctl(STDIN_FILENO, TIOCGWINSZ, &w);

  printf("row %d\n", w.ws_row);
  printf("col %d\n", w.ws_col);
}
*/

#elif _WIN32

#include <conio.h>
#include <windows.h>

// https://www.cplusplus.com/articles/4z18T05o/
void ClearScreen(void) {
  HANDLE hStdOut;
  CONSOLE_SCREEN_BUFFER_INFO csbi;
  DWORD count;
  DWORD cellCount;
  COORD homeCoords = {0, 0};

  hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
  if (hStdOut == INVALID_HANDLE_VALUE) return;

  /* Get the number of cells in the current buffer */
  if (!GetConsoleScreenBufferInfo(hStdOut, &csbi)) return;
  cellCount = csbi.dwSize.X * csbi.dwSize.Y;

  /* Fill the entire buffer with spaces */
  if (!FillConsoleOutputCharacter(hStdOut, (TCHAR)' ', cellCount, homeCoords,
                                  &count))
    return;

  /* Fill the entire buffer with the current colors and attributes */
  if (!FillConsoleOutputAttribute(hStdOut, csbi.wAttributes, cellCount,
                                  homeCoords, &count))
    return;

  /* Move the cursor home */
  SetConsoleCursorPosition(hStdOut, homeCoords);
}

#define KeyHit() _getch()

#endif
