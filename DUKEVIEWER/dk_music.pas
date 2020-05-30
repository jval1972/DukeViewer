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
//  Duke Nukem 3D Music
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  New site: https://sourceforge.net/projects/dukeviewer/
//  Old Site: http://www.geocities.ws/jimmyvalavanis/applications/dukeviewer.html
//------------------------------------------------------------------------------

{$I defs.inc}

unit dk_music;

interface

uses
  se_Duke3DTypes;

//
//  MUSIC I/O
//
procedure DK_InitMusic;
procedure DK_ShutdownMusic;

// Volume.
procedure DK_SetMusicVolume(volume: integer);

procedure DK_PlaySong;
// PAUSE game handling.
procedure DK_PauseSong;
procedure DK_ResumeSong;

// Registers a song handle to song data.
function DK_RegisterSong(const data: pointer; const size: integer): boolean;

// See above (register), then think backwards
procedure DK_UnRegisterSong;

function DK_GetMusicName(const mapName: string): string;

implementation

uses
  Windows, Messages, SysUtils, se_DXDUtils, dk_argv, dk_io, dk_delphi,
  se_Midi, MMSystem;

{
music 1 stalker.mid dethtoll.mid streets.mid watrwld1.mid snake1.mid
        thecall.mid ahgeez.mid dethtoll.mid streets.mid watrwld1.mid snake1.mid

music 2 futurmil.mid storm.mid gutwrnch.mid robocrep.mid stalag.mid
       pizzed.mid alienz.mid xplasma.mid alfredh.mid gloomy.mid intents.mid

music 3 inhiding.mid FATCMDR.mid NAMES.MID subway.mid invader.mid gotham.mid
        233c.mid lordofla.mid urban.mid spook.mid whomp.mid
}

function DK_GetMusicName(const mapName: string): string;
var
  uMapName: string;
begin
  Result := '';

  uMapName := UpperCase(ExtractFileNameOnly(mapName));
  if Length(uMapName) < 4 then
    Exit;

  if uMapName[2] = '1' then
  begin
    if uMapName = 'E1L1' then
      Result := 'stalker.mid'
    else if uMapName = 'E1L2' then
      Result := 'dethtoll.mid'
    else if uMapName = 'E1L3' then
      Result := 'streets.mid'
    else if uMapName = 'E1L4' then
      Result := 'watrwld1.mid'
    else if uMapName = 'E1L5' then
      Result := 'snake1.mid'
    else if uMapName = 'E1L6' then
      Result := 'thecall.mid'
    else if uMapName = 'E1L7' then
      Result := 'ahgeez.mid'
    else if uMapName = 'E1L8' then
      Result := 'dethtoll.mid'
    else if uMapName = 'E1L9' then
      Result := 'streets.mid'
    else if uMapName = 'E1L10' then
      Result := 'watrwld1.mid'
    else if uMapName = 'E1L11' then
      Result := 'snake1.mid'
    else
      Exit;
  end
  else if uMapName[2] = '2' then
  begin
    if uMapName = 'E2L1' then
      Result := 'futurmil.mid'
    else if uMapName = 'E2L2' then
      Result := 'storm.mid'
    else if uMapName = 'E2L3' then
      Result := 'gutwrnch.mid'
    else if uMapName = 'E2L4' then
      Result := 'robocrep.mid'
    else if uMapName = 'E2L5' then
      Result := 'stalag.mid'
    else if uMapName = 'E2L6' then
      Result := 'pizzed.mid'
    else if uMapName = 'E2L7' then
      Result := 'alienz.mid'
    else if uMapName = 'E2L8' then
      Result := 'xplasma.mid'
    else if uMapName = 'E2L9' then
      Result := 'alfredh.mid'
    else if uMapName = 'E2L10' then
      Result := 'gloomy.mid'
    else if uMapName = 'E2L11' then
      Result := 'intents.mid'
    else
      Exit;
  end
  else if uMapName[2] = '3' then
  begin
    if uMapName = 'E3L1' then
      Result := 'inhiding.mid'
    else if uMapName = 'E3L2' then
      Result := 'FATCMDR.mid'
    else if uMapName = 'E3L3' then
      Result := 'NAMES.MID'
    else if uMapName = 'E3L4' then
      Result := 'subway.mid'
    else if uMapName = 'E3L5' then
      Result := 'invader.mid'
    else if uMapName = 'E3L6' then
      Result := 'gotham.mid'
    else if uMapName = 'E3L7' then
      Result := '233c.mid'
    else if uMapName = 'E3L8' then
      Result := 'lordofla.mid'
    else if uMapName = 'E3L9' then
      Result := 'urban.mid'
    else if uMapName = 'E3L10' then
      Result := 'spook.mid'
    else if uMapName = 'E3L11' then
      Result := 'whomp.mid';
  end;
end;

var
  MidiFileName: string;
  snd_MusicVolume: integer = 15;

procedure DK_InitMusic;
begin
// Nothing to do
end;

//
// DK_ShutdownMusic
//
procedure DK_ShutdownMusic;
begin
  I_StopMidi;
  fdelete(MidiFileName);
end;

procedure DK_PlaySong;
begin
  I_PlayMidi(MidiFileName);
end;

//
// DK_PauseSong
//
procedure DK_PauseSong;
begin
  I_PauseMidi;
end;

//
// DK_ResumeSong
//
procedure DK_ResumeSong;
begin
  I_ResumeMidi;
end;

// Stops a song
procedure DK_UnRegisterSong;
begin
  I_StopMidi;
  if fexists(MidiFileName) then
    fdelete(MidiFileName);
end;

function DK_RegisterSong(const data: pointer; const size: integer): boolean;
var
  f: file;
  buf: array[0..1024] of char;
begin
  I_StopMidi;

  FillChar(buf, SizeOf(buf), Chr(0));
  GetTempPath(SizeOf(buf), buf);
  MidiFileName := StrPas(buf) + '\dukeviewer.mid';

  assign(f, MidiFileName);
  {$I-}
  rewrite(f, 1);
  BlockWrite(f, data^, size);
  close(f);
  {$I+}
  if IOResult <> 0 then
  begin
    printf('DK_RegisterSong(): Could not initialize MCI' + #13#10);
    Result := False;
    Exit;
  end;

  Result := True;
end;

procedure DK_SetMusicVolume(volume: integer);
begin
  I_SetMusicVolumeMidi(volume);
  snd_MusicVolume := volume;
end;

end.

