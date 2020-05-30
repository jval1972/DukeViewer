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
//  Main Programm
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  New site: https://sourceforge.net/projects/dukeviewer/
//  Old Site: http://www.geocities.ws/jimmyvalavanis/applications/dukeviewer.html
//------------------------------------------------------------------------------

program DukeViewer;

uses
  FastMM4 in 'FASTMM\FastMM4.pas',
  FastMM4Messages in 'FASTMM\FastMM4Messages.pas',
  Forms,
  se_DirectX in 'ENGINE\se_DirectX.pas',
  se_DXCommon in 'ENGINE\se_DXCommon.pas',
  se_WADS in 'ENGINE\se_WADS.pas',
  se_D3DUtils in 'ENGINE\se_D3DUtils.pas',
  se_DXClasses in 'ENGINE\se_DXClasses.pas',
  se_DXDUtils in 'ENGINE\se_DXDUtils.pas',
  se_DXMeshes in 'ENGINE\se_DXMeshes.pas',
  se_DXTables in 'ENGINE\se_DXTables.pas',
  se_DXDraws in 'ENGINE\se_DXDraws.pas',
  se_DXClass in 'ENGINE\se_DXClass.pas',
  se_DXConsts in 'ENGINE\se_DXConsts.pas',
  se_DXTexImg in 'ENGINE\se_DXTexImg.pas',
  se_DXRender in 'ENGINE\se_DXRender.pas',
  se_DXInput in 'ENGINE\se_DXInput.pas',
  se_DXTextureEffects in 'ENGINE\se_DXTextureEffects.pas',
  se_Main in 'ENGINE\se_Main.pas',
  se_MyD3DUtils in 'ENGINE\se_MyD3DUtils.pas',
  se_TempDXDraw in 'ENGINE\se_TempDXDraw.pas' {TempDXDrawForm},
  se_ZipFile in 'ENGINE\se_ZipFile.pas',
  se_Utils in 'ENGINE\se_Utils.pas',
  se_Duke3DTypes in 'ENGINE\se_Duke3DTypes.pas',
  se_Duke3DUtils in 'ENGINE\se_Duke3DUtils.pas',
  se_DXSounds in 'ENGINE\se_DXSounds.pas',
  se_Wave in 'ENGINE\se_Wave.pas',
  se_Midi in 'ENGINE\se_Midi.pas',
  se_RTLCompileParams in 'ENGINE\se_RTLCompileParams.pas',
  zBitmap in 'IMAGEFORMATS\zBitmap.pas',
  pcximage in 'IMAGEFORMATS\pcximage.pas',
  pngimage in 'IMAGEFORMATS\pngimage.pas',
  pnglang in 'IMAGEFORMATS\pnglang.pas',
  xGif in 'IMAGEFORMATS\xGIF.pas',
  xM8 in 'IMAGEFORMATS\xM8.pas',
  xPPM in 'IMAGEFORMATS\xPPM.pas',
  xStubGraphic in 'IMAGEFORMATS\xStubGraphic.pas',
  dibimage in 'IMAGEFORMATS\dibimage.pas',
  xTGA in 'IMAGEFORMATS\xTGA.pas',
  xWZ in 'IMAGEFORMATS\xWZ.pas',
  XPMenu in 'LIBRARY\XPMenu.pas',
  About in 'LIBRARY\About.pas' {AboutBox},
  Aboutdlg in 'LIBRARY\Aboutdlg.pas',
  AnotherReg in 'LIBRARY\AnotherReg.pas',
  binarydata in 'LIBRARY\binarydata.pas',
  DropDownButton in 'LIBRARY\DropDownButton.pas',
  MessageBox in 'LIBRARY\MessageBox.pas',
  rmBaseEdit in 'LIBRARY\rmBaseEdit.pas',
  rmBtnEdit in 'LIBRARY\rmBtnEdit.pas',
  rmLibrary in 'LIBRARY\rmLibrary.pas',
  rmSpeedBtns in 'LIBRARY\rmSpeedBtns.pas',
  smoothshow in 'LIBRARY\smoothshow.pas',
  zlibpas in 'ZLIB\zlibpas.pas',
  Unit1 in 'DUKEVIEWER\Unit1.pas' {DXViewerForm},
  QuickInfoFrm in 'DUKEVIEWER\QuickInfoFrm.pas' {QuickInfoForm},
  Splash in 'DUKEVIEWER\Splash.pas' {SplashForm},
  OpenDukeMapFrm in 'DUKEVIEWER\OpenDukeMapFrm.pas' {OpenDukeMapForm},
  dk_music in 'DUKEVIEWER\dk_music.pas',
  dk_argv in 'DUKEVIEWER\dk_argv.pas',
  dk_io in 'DUKEVIEWER\dk_io.pas',
  dk_delphi in 'DUKEVIEWER\dk_delphi.pas',
  dk_globals in 'DUKEVIEWER\dk_globals.pas',
  PointInfoFrm in 'DUKEVIEWER\PointInfoFrm.pas' {MapInfoForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'DukeViewer';
  Application.CreateForm(TDXViewerForm, DXViewerForm);
  Application.CreateForm(TMapInfoForm, MapInfoForm);
  Application.Run;
end.
