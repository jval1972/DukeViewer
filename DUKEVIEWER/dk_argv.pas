//------------------------------------------------------------------------------
//
//  DukeViewer: Map Viewer for the game Duke Nukem 3D
//  Copyright (C) 2005-2018 by Jim Valavanis
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
//  Command line parameters
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  New site: https://sourceforge.net/projects/dukeviewer/
//  Old Site: http://www.geocities.ws/jimmyvalavanis/applications/dukeviewer.html
//------------------------------------------------------------------------------

{$I defs.inc}

unit dk_argv;

interface

function DK_CheckParam(const check: string): integer;

function DK_GetParam(const id: integer): string;

implementation

uses SysUtils;

const
  MAXARGS = 256;

var
  myargc: integer;
  myargv: array[0..MAXARGS] of string;

function DK_CheckParam(const check: string): integer;
var
  i: integer;
  uCheck: string;
begin
  uCheck := UpperCase(check);
  for i := 1 to myargc - 1 do
    if uCheck = myargv[i] then
    begin
      result := i;
      exit;
    end;
  result := 0;
end;

procedure DK_InitArgv;
var
  i: integer;
begin
  myargc := ParamCount + 1;
  for i := 0 to myargc - 1 do
    myargv[i] := UpperCase(ParamStr(i));
  for i := myargc to MAXARGS do
    myargv[i] := '';
end;

function DK_GetParam(const id: integer): string;
begin
  if (id >= 0) and (id <= MAXARGS) then
    result := myargv[id]
  else
    result := '';
end;

initialization
  DK_InitArgv;

end.


