#ifndef GAME_H
#define GAME_H

#include "gba.h"

/* TODO: */

// Macros ==========================================================================

#define KEY_JUST_UNPRESSED(key, buttons, oldbuttons) (((KEY_DOWN(key, oldbuttons))) & ~(KEY_DOWN(key, buttons)))
#define JUST_ATTACKED(currAtk, prevAtk) ((currAtk == ATTACKING) && (prevAtk == NOT_ATTACKING))
#define JUST_DIED(currState, prevState) ((currState == DEAD) && (prevState == ALIVE))

// Enums/States ==================================================================

typedef enum {
  START,
  INSTRUCTIONS,
  HUB,
  HALL,
  BOSS1,
  BOSS2,
  BOSS3,
  BOSS4,
  WIN,
  LOSE,
} GBAState;

typedef enum {
  JUMPSTART,
  MID_UP,
  APEX,
  MID_BOTTOM,
  DONE,
} JumpState;

typedef enum {
  JUMPING,
  CROUCHING,
  STANDING,
} YAxisState;

typedef enum {
  LEFTFACING,
  RIGHTFACING,
} XAxisState;

typedef enum {
  ATTACKING,
  NOT_ATTACKING,
} CurrAttackingState, PrevAttackingState;

typedef enum {
  NOT_ATTACKING_B,
  ABOUT_TO_B,
  ATTACKING_B,
} BossAttackingState;

typedef enum {
  MISSED,
  HIT,
} BossDamaging;

typedef enum {
  ALIVE,
  DEAD,
} BossLifeState;

// Structs ============================================================

typedef struct character {
  int health;
  int row;
  int col;
  int height;
  int width;
  int bossesBeaten;
} CurrCharacter, PrevCharacter;

typedef struct boss {
  int health;
  int row;
  int col;
  int height;
  int width;
} BossInfo;

typedef struct weapon {
  int row;
  int col;
  int height;
  int width;
} CurrWeapon, PrevWeapon;

// Prototypes =============================================================

void delay(int n);

#endif
