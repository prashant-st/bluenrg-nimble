#ifndef __CONSOLE_H__
#define __CONSOLE_H__

#include "SEGGER_RTT.h"

#define console_printf(fmt, ...)           SEGGER_RTT_printf(0, fmt, ##__VA_ARGS__)

#endif
