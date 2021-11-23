#include "terminal.h"

#include <stdio.h>
#include <string.h>
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
