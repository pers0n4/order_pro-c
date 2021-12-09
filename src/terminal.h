#ifndef TERMINAL_H_
#define TERMINAL_H_

#include <stdbool.h>

#define ESC '\033'

#ifdef __linux__

#include <stdio_ext.h>
#include <termios.h>
#include <unistd.h>

#elif _WIN32

#include <conio.h>
#include <windows.h>

#endif

void FlushInputBuffer(void);

void ClearScreen(void);
void MoveCursor(int row, int col);

bool KeyHit(void);

#endif  // TERMINAL_H_
