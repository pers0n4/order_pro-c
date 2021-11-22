#ifndef TERMINAL_H_
#define TERMINAL_H_

#include <stdbool.h>

#define ESC '\033'

void ClearScreen(void);
void MoveCursor(int row, int col);

bool KeyHit(void);

#endif  // TERMINAL_H_
