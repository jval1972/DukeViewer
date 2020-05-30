//------------------------------------------------------------------------------
//
//  Surfaces Engine (SE) - Gaming engine for Windows based on DirectX & DelphiX
//  Copyright (C) 1999-2004, 2018 by Jim Valavanis
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, inc., 59 Temple Place - Suite 330, Boston, MA
//  02111-1307, USA.
//
// DESCRIPTION:
//  Duke Nukem 3D structs and definitions
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//------------------------------------------------------------------------------

{$I defs.inc}

unit se_Duke3DTypes;

interface

const
  DUKE3DVERSION7 = 7;
  DUKE3DVERSION6 = 6;
  DUKE3DVERSION5 = 5;

  DEFDUKE3DIMPORTLFACTOR = 0.5;
  DEFDUKE3DIMPORTFACTOR = 256.0;
  DEFDUKE3DCOMPLEXITYFACTOR = 2;

type
  TDuke3DFileRec = record
    Name: array[1..12] of char;
    Size: integer;
  end;

  TDuke3DEntry = record
    Name: string[12];
    Size: integer;
    Position: integer;
  end;
  PDuke3DEntry = ^TDuke3DEntry;

  TDuke3DPaletteEntry = packed record
    r, g, b: byte;
  end;

  TDuke3DPalette = packed array [0..255] of TDuke3DPaletteEntry;

  PDuke3DDirectories = ^TDuke3DDirectories;
  TDuke3DDirectories = array[0..$FFFF] of TDuke3DEntry;

  TDuke3DSector6 = record
    wallptr: word;
    wallnum: word;
    ceilingpicnum: smallint;
    floorpicnum: smallint;
    ceilingheinum: smallint;
    floorheinum: smallint;
    ceilingz: longint;
    floorz: longint;
    ceilingshade: shortint;
    floorshade: shortint;
    ceilingxpanning: byte;
    floorxpanning: byte;
    ceilingypanning: byte;
    floorypanning: byte;
    ceilingstat: byte;
    floorstat: byte;
    ceilingpal: byte;
    floorpal: byte;
    visibility: byte;
    lotag: smallint;
    hitag: smallint;
    extra: smallint;
  end;

  PDuke3DSector6Array = ^TDuke3DSector6Array;
  TDuke3DSector6Array = array[0..$FFFF] of TDuke3DSector6;


  TDuke3DWall6 = record
    x: longint;
    y: longint;
    point2: smallint;
    nextsector: smallint;
    nextwall: smallint;
    picnum: smallint;
    overpicnum: smallint;
    shade: shortint;
    pal: byte;
    cstat: smallint;
    xrepeat: byte;
    yrepeat: byte;
    xpanning: byte;
    ypanning: byte;
    lotag: smallint;
    hitag: smallint;
    extra: smallint;
  end;

  PDuke3DWall6Array = ^TDuke3DWall6Array;
  TDuke3DWall6Array = array[0..$FFFF] of TDuke3DWall6;


  TDuke3DSprite6 = record
    x: longint;
    y: longint;
    z: longint;
    cstat: smallint;
    shade: shortint;
    pal: byte;
    clipdist: byte;
    xrepeat: byte;
    yrepeat: byte;
    xoffset: byte;
    yoffset: byte;
    picnum: smallint;
    ang: smallint;
    xvel: smallint;
    yvel: smallint;
    zvel: smallint;
    owner: smallint;
    sectnum: smallint;
    statnum: smallint;
    lotag: smallint;
    hitag: smallint;
    extra: smallint;
  end;
  {40 bytes }

  PDuke3DSprite6Array = ^TDuke3DSprite6Array;
  TDuke3DSprite6Array = array[0..$FFFF] of TDuke3DSprite6;

////////////////////////////////////////////////////////////////////////////////
// MAP FORMAT (Version 7)
////////////////////////////////////////////////////////////////////////////////

{
////////////////////////////////////////////////////////////////////////////////
/////////////////                SECTORS          //////////////////////////////
////////////////////////////////////////////////////////////////////////////////
wallptr - index to first wall of sector
wallnum - number of walls in sector
z's - z coordinate (height) of ceiling / floor at first point of sector
stat's
	bit 0: 1 = parallaxing, 0 = not                                 "P"
	bit 1: 1 = sloped, 0 = not
	bit 2: 1 = swap x&y, 0 = not                                    "F"
	bit 3: 1 = double smooshiness                                   "E"
	bit 4: 1 = x-flip                                               "F"
	bit 5: 1 = y-flip                                               "F"
	bit 6: 1 = Align texture to first wall of sector                "R"
	bits 7-15: reserved
picnum's - texture index into art file
heinum's - slope value (rise/run) (0-parallel to floor, 4096-45 degrees)
shade's - shade offset of ceiling/floor
pal's - palette lookup table number (0 - use standard colors)
panning's - used to align textures or to do texture panning
visibility - determines how fast an area changes shade relative to distance
filler - useless byte to make structure aligned
lotag, hitag, extra - These variables used by the game programmer only
}

const
  sec_Parallaxing = 1;
  sec_Sloped = 2;
  sec_xySwap = 4;
  sec_DoubleSmooshiness = 8;
  sec_xFlip = 16;
  sec_yFlip = 1 shl 5;
  sec_AlignTextureToFirstWall = 1 shl 6;

  sec_lotagSecret = 32767; // secret room

type
  PDuke3DSector7 = ^TDuke3DSector7;
  TDuke3DSector7 = record
    wallptr: smallint; // Starting wall index
    wallnum: smallint; // number of walls
    ceilingz: longint;
    floorz: longint;
    ceilingstat: smallint;
    floorstat: smallint;
    ceilingpicnum: smallint;
    ceilingheinum: smallint;
    ceilingshade: shortint;
    ceilingpal: byte;
    ceilingxpanning: byte;
    ceilingypanning: byte;
    floorpicnum: smallint;
    floorheinum: smallint;
    floorshade: shortint;
    floorpal: byte;
    floorxpanning: byte;
    floorypanning: byte;
    visibility: byte;
    filler: byte;
    lotag: smallint;
    hitag: smallint;
    extra: smallint;
  end;
  {32 bytes }

  PDuke3DSector7Array = ^TDuke3DSector7Array;
  TDuke3DSector7Array = array[0..$FFFF] of TDuke3DSector7;

  PDuke3DSectorDimentions = ^TDuke3DSectorDimentions;
  TDuke3DSectorDimentions = record
    minX, minY,
    maxX, maxY: integer;
    distX, distY: integer;
  end;

  PDuke3DSectorDimentionsArray = ^TDuke3DSectorDimentionsArray;
  TDuke3DSectorDimentionsArray = array[0..$FFFF] of TDuke3DSectorDimentions;

{
////////////////////////////////////////////////////////////////////////////////
/////////////////////           WALLS        ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
x, y: Coordinate of left side of wall, get right side from next wall's left side
point2: Index to next wall on the right (always in the same sector)
nextwall: Index to wall on other side of wall (-1 if there is no sector)
nextsector: Index to sector on other side of wall (-1 if there is no sector)
cstat:
	bit 0: 1 = Blocking wall (use with clipmove, getzrange)         "B"
	bit 1: 1 = bottoms of invisible walls swapped, 0 = not          "2"
	bit 2: 1 = align picture on bottom (for doors), 0 = top         "O"
	bit 3: 1 = x-flipped, 0 = normal                                "F"
	bit 4: 1 = masking wall, 0 = not                                "M"
	bit 5: 1 = 1-way wall, 0 = not                                  "1"
	bit 6: 1 = Blocking wall (use with hitscan / cliptype 1)        "H"
	bit 7: 1 = Transluscence, 0 = not                               "T"
	bit 8: 1 = y-flipped, 0 = normal                                "F"
	bit 9: 1 = Transluscence reversing, 0 = normal                  "T"
	bits 10-15: reserved
picnum - texture index into art file
overpicnum - texture index into art file for masked walls / 1-way walls
shade - shade offset of wall
pal - palette lookup table number (0 - use standard colors)
repeat's - used to change the size of pixels (stretch textures)
pannings - used to align textures or to do texture panning
lotag, hitag, extra - These variables used by the game programmer only
}

const
  wall_Blocking = 1;
  wall_BottomSwapped = 2;
  wall_AlignBottom = 4;
  wall_xFlipped = 8;
  wall_Masking = 16;
  wall_1way = 1 shl 5;
  wall_Transluscence = 1 shl 7;
  wall_yFlipped = 1 shl 8;
  wall_TransluscencereReversing = 1 shl 9;

type
  PDuke3DWall7 = ^TDuke3DWall7;
  TDuke3DWall7 = record
    x: longint;     // xpos (x1)
    y: longint;     // ypos (y1)
    point2: smallint; // next wall ( y2 = Walls[point2]
    nextwall: smallint;
    nextsector: smallint;
    cstat: smallint;
    picnum: smallint;
    overpicnum: smallint;
    shade: shortint;
    pal: byte;
    xrepeat: byte;
    yrepeat: byte;
    xpanning: byte;
    ypanning: byte;
    lotag: smallint;
    hitag: smallint;
    extra: smallint;
  end;
  {44 bytes }

  PDuke3DWall7Array = ^TDuke3DWall7Array;
  TDuke3DWall7Array = array[0..$FFFF] of TDuke3DWall7;

{
////////////////////////////////////////////////////////////////////////////////
////////////////////            SPRITES          ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////
x, y, z - position of sprite - can be defined at center bottom or center
cstat:
 bit 0: 1 = Blocking sprite (use with clipmove, getzrange)       "B"
 bit 1: 1 = transluscence, 0 = normal                            "T"
 bit 2: 1 = x-flipped, 0 = normal                                "F"
 bit 3: 1 = y-flipped, 0 = normal                                "F"
 bits 5-4: 00 = FACE sprite (default)                            "R"
           01 = WALL sprite (like masked walls)
           10 = FLOOR sprite (parallel to ceilings&floors)
 bit 6: 1 = 1-sided sprite, 0 = normal                           "1"
 bit 7: 1 = Real centered centering, 0 = foot center             "C"
 bit 8: 1 = Blocking sprite (use with hitscan / cliptype 1)      "H"
 bit 9: 1 = Transluscence reversing, 0 = normal                  "T"
 bits 10-14: reserved
 bit 15: 1 = Invisible sprite, 0 = not invisible
picnum - texture index into art file
shade - shade offset of sprite
pal - palette lookup table number (0 - use standard colors)
clipdist - the size of the movement clipping square (face sprites only)
filler - useless byte to make structure aligned
repeat's - used to change the size of pixels (stretch textures)
offset's - used to center the animation of sprites
sectnum - current sector of sprite
statnum - current status of sprite (inactive/monster/bullet, etc.)

ang - angle the sprite is facing
owner, xvel, yvel, zvel, lotag, hitag, extra - These variables used by the game programmer only
}

const
  spr_Blocking = 1;
  spr_Transculate = 2;
  spr_xFlipped = 4;
  spr_yFlipped = 8;
  spr_SingleSided = 1 shl 6;
  spr_Centered = 1 shl 7;
  spr_TransluscenceReversing = 1 shl 9;
  spr_Invisible = 1 shl 15;

type
  PDuke3DSprite7 = ^TDuke3DSprite7;
  TDuke3DSprite7 = record
    x: longint;
    y: longint;
    z: longint;
    cstat: smallint;
    picnum: smallint;
    shade: shortint;
    pal: byte;
    clipdist: byte;
    filler: byte;
    xrepeat: byte;
    yrepeat: byte;
    xoffset: byte;
    yoffset: byte;
    sectnum: smallint;
    statnum: smallint;
    ang: smallint;
    owner: smallint;
    xvel: smallint;
    yvel: smallint;
    zvel: smallint;
    lotag: smallint;
    hitag: smallint;
    extra: smallint;
  end;

  PDuke3DSprite7Array = ^TDuke3DSprite7Array;
  TDuke3DSprite7Array = array[0..$FFFF] of TDuke3DSprite7;

  PDuke3DSprDimention = ^TDuke3DSprDimention;
  TDuke3DSprDimention = record
    Width, Height: word;
    TransWidth, TransHeight: word;
    coord_idx: integer;
    picsiz: byte;
  end;

  PDuke3DSprDimentions = ^TDuke3DSprDimentions;
  TDuke3DSprDimentions = array[0..$FFFF] of TDuke3DSprDimention;

{***************************************************************************
	KEN'S TAG DEFINITIONS:      (Please define your own tags for your games)

 sector[?].lotag = 0   Normal sector
 sector[?].lotag = 1   If you are on a sector with this tag, then all sectors
			with same hi tag as this are operated.  Once.
 sector[?].lotag = 2   Same as sector[?].tag = 1 but this is retriggable.
 sector[?].lotag = 3   A really stupid sector that really does nothing now.
 sector[?].lotag = 4   A sector where you are put closer to the floor
                      (such as the slime in DOOM1.DAT)
 sector[?].lotag = 5   A really stupid sector that really does nothing now.
 sector[?].lotag = 6   A normal door - instead of pressing D, you tag the
                       sector with a 6.  The reason I make you edit doors
                       this way is so that can program the doors
                       yourself.
 sector[?].lotag = 7   A door the goes down to open.
 sector[?].lotag = 8   A door that opens horizontally in the middle.
 sector[?].lotag = 9   A sliding door that opens vertically in the middle.
			-Example of the advantages of not using BSP tree.
 sector[?].lotag = 10  A warping sector with floor and walls that shade.
 sector[?].lotag = 11  A sector with all walls that do X-panning.
 sector[?].lotag = 12  A sector with walls using the dragging function.
 sector[?].lotag = 13  A sector with some swinging doors in it.
 sector[?].lotag = 14  A revolving door sector.
 sector[?].lotag = 15  A subway track.
 sector[?].lotag = 16  A true double-sliding door.
 
 wall[?].lotag = 0   Normal wall
 wall[?].lotag = 1   Y-panning wall
 wall[?].lotag = 2   Switch - If you flip it, then all sectors with same hi
			tag as this are operated.
 wall[?].lotag = 3   Marked wall to detemine starting dir. (sector tag 12)
 wall[?].lotag = 4   Mark on the shorter wall closest to the pivot point
			of a swinging door. (sector tag 13)
 wall[?].lotag = 5   Mark where a subway should stop. (sector tag 15)
 wall[?].lotag = 6   Mark for true double-sliding doors (sector tag 16)
 wall[?].lotag = 7   Water fountain
 wall[?].lotag = 8   Bouncy wall!

 sprite[?].lotag = 0   Normal sprite
 sprite[?].lotag = 1   If you press space bar on an AL, and the AL is tagged
								  with a 1, he will turn evil.
 sprite[?].lotag = 2   When this sprite is operated, a bomb is shot at its
								  position.
 sprite[?].lotag = 3   Rotating sprite.
 sprite[?].lotag = 4   Sprite switch.
 sprite[?].lotag = 5   Basketball hoop score.

KEN'S STATUS DEFINITIONS:  (Please define your own statuses for your games)
 status = 0            Inactive sprite
 status = 1            Active monster sprite
 status = 2            Monster that becomes active only when it sees you
 status = 3            Smoke on the wall for chainguns
 status = 4            Splashing sprites (When you shoot slime)
 status = 5            Explosion!
 status = 6            Travelling bullet
 status = 7            Bomb sprial-out explosion
 status = 8            Player!
 status = 9            EVILALGRAVE shrinking list
 status = 10           EVILAL list
 status = 11           Sprite respawning list
 status = 12           Sprite which does not respawn (Andy's addition)
 status = MAXSTATUS    Non-existent sprite (this will be true for your code also)
**************************************************************************}

implementation

end.
