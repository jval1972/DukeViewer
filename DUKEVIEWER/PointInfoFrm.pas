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
//  Map Information Form
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  New site: https://sourceforge.net/projects/dukeviewer/
//  Old Site: http://www.geocities.ws/jimmyvalavanis/applications/dukeviewer.html
//------------------------------------------------------------------------------

{$I defs.inc}

unit PointInfoFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, AnotherReg, ExtCtrls, StdCtrls, se_Main, se_Duke3DTypes;

type
  TMapInfoForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel3: TPanel;
    Panel4: TPanel;
    Memo1: TMemo;
    Panel7: TPanel;
    Label1: TLabel;
    Panel5: TPanel;
    Memo2: TMemo;
    Panel8: TPanel;
    Label2: TLabel;
    Panel6: TPanel;
    Memo3: TMemo;
    Panel9: TPanel;
    Label3: TLabel;
    Bevel1: TBevel;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel10: TPanel;
    Label4: TLabel;
    Panel11: TPanel;
    Panel12: TPanel;
    Label5: TLabel;
    Panel13: TPanel;
    Panel14: TPanel;
    Label6: TLabel;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Bevel2: TBevel;
    Panel15: TPanel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    ScrollBox2: TScrollBox;
    Image2: TImage;
    Panel16: TPanel;
    ScrollBox4: TScrollBox;
    Image4: TImage;
    Panel18: TPanel;
    PageControl3: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    ScrollBox3: TScrollBox;
    Image3: TImage;
    Panel17: TPanel;
    ScrollBox5: TScrollBox;
    Image5: TImage;
    Panel19: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    fPoint: integer;
    regFormRestorer1: TFormRestorer;
    procedure SetPoint(Value: integer);
    procedure UpdateInfo;
    procedure Clear;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    Scene: TD3DScene;
    hSectors: PDuke3DSector7Array;
    numSectors: integer;
    hWalls: PDuke3DWall7Array;
    numWalls: integer;
    property Point: integer read fPoint write SetPoint;
  end;

procedure ShowDuke3DMapInfo(AOwner: TComponent; AScene: TD3DScene;
  const p: integer;
  const aSectors: PDuke3DSector7Array; const aNumSectors: integer;
  const aWalls: PDuke3DWall7Array; const aNumWalls: integer);

var
  MapInfoForm: TMapInfoForm = nil;

implementation

{$R *.DFM}

uses
  unit1, smoothshow;

procedure ShowDuke3DMapInfo(AOwner: TComponent; AScene: TD3DScene;
  const p: integer;
  const aSectors: PDuke3DSector7Array; const aNumSectors: integer;
  const aWalls: PDuke3DWall7Array; const aNumWalls: integer);
begin
  if (p >= 0) and (p < aNumWalls) then
  begin
    if MapInfoForm = nil then
      MapInfoForm := TMapInfoForm.Create(AOwner);
    MapInfoForm.Scene := AScene;
    MapInfoForm.hSectors := aSectors;
    MapInfoForm.numSectors := aNumSectors;
    MapInfoForm.hWalls := aWalls;
    MapInfoForm.numWalls := aNumWalls;
    MapInfoForm.Point := p;
    MapInfoForm.Show;
  end;
end;

procedure TMapInfoForm.FormShow(Sender: TObject);
begin
  FormSmoothShow(self, DXViewerForm);
end;

procedure TMapInfoForm.SetPoint(Value: integer);
begin
  if fPoint <> Value then
  begin
    fPoint := Value;
    UpdateInfo;
  end;
end;

procedure TMapInfoForm.Clear;
begin
  Label1.Caption := '';
  Label2.Caption := '';
  Label3.Caption := '';
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;
  Memo3.Lines.Clear;
end;

procedure TMapInfoForm.UpdateInfo;
var
  i, j: integer;
  aMemo: TMemo;
  secNum,
  secNum1,
  secNum2: integer;
  bmp: TBitmap;
begin
  Clear;
  Label1.Caption := Format('wallnum: %d', [fPoint]);
  Memo1.Lines.Add(Format('x: %d', [hWalls[fPoint].x]));
  Memo1.Lines.Add(Format('y: %d', [hWalls[fPoint].y]));
  Memo1.Lines.Add(Format('point2: %d', [hWalls[fPoint].point2]));
  Memo1.Lines.Add(Format('nextwall: %d', [hWalls[fPoint].nextwall]));
  Memo1.Lines.Add(Format('nextsector: %d', [hWalls[fPoint].nextsector]));
  Memo1.Lines.Add(Format('cstat: %d', [hWalls[fPoint].cstat]));
  Memo1.Lines.Add(Format('picnum: %d', [hWalls[fPoint].picnum]));
  Memo1.Lines.Add(Format('overpicnum: %d', [hWalls[fPoint].overpicnum]));
  Memo1.Lines.Add(Format('shade: %d', [hWalls[fPoint].shade]));
  Memo1.Lines.Add(Format('pal: %d', [hWalls[fPoint].pal]));
  Memo1.Lines.Add(Format('xrepeat: %d', [hWalls[fPoint].xrepeat]));
  Memo1.Lines.Add(Format('yrepeat: %d', [hWalls[fPoint].yrepeat]));
  Memo1.Lines.Add(Format('xpanning: %d', [hWalls[fPoint].xpanning]));
  Memo1.Lines.Add(Format('ypanning: %d', [hWalls[fPoint].ypanning]));
  Memo1.Lines.Add(Format('lotag: %d', [hWalls[fPoint].lotag]));
  Memo1.Lines.Add(Format('hitag: %d', [hWalls[fPoint].hitag]));
  Memo1.Lines.Add(Format('extra: %d', [hWalls[fPoint].extra]));
  Memo1.Lines.Add('--------------');
  if hWalls[fPoint].cstat <> 0 then
  begin
    if (hWalls[fPoint].cstat and wall_Blocking) <> 0 then
      Memo1.Lines.Add('Blocking');
    if (hWalls[fPoint].cstat and wall_BottomSwapped) <> 0 then
      Memo1.Lines.Add('BottomSwapped');
    if (hWalls[fPoint].cstat and wall_AlignBottom) <> 0 then
      Memo1.Lines.Add('AlignBottom');
    if (hWalls[fPoint].cstat and wall_xFlipped) <> 0 then
      Memo1.Lines.Add('xFlipped');
    if (hWalls[fPoint].cstat and wall_Masking) <> 0 then
      Memo1.Lines.Add('Masking');
    if (hWalls[fPoint].cstat and wall_1way) <> 0 then
      Memo1.Lines.Add('One way');
    if (hWalls[fPoint].cstat and wall_Transluscence) <> 0 then
      Memo1.Lines.Add('Transluscence');
    if (hWalls[fPoint].cstat and wall_yFlipped) <> 0 then
      Memo1.Lines.Add('yFlipped');
    if (hWalls[fPoint].cstat and wall_TransluscencereReversing) <> 0 then
      Memo1.Lines.Add('Transluscencere Reversing');
  end;


  secNum := -1;
  for i := 0 to numSectors - 1 do
  begin
    for j := hSectors[i].wallptr to hSectors[i].wallptr + hSectors[i].wallnum - 1 do
      if j = fPoint then
      begin
        secNum := i;
        break;
      end;
  end;

  secNum1 := secNum;

  Label2.Caption := Format('wall->sector: %d', [secNum]);
  Label3.Caption := Format('wall->nextsector: %d', [hWalls[fPoint].nextsector]);
  aMemo := Memo2;
  for i := 1 to 2 do
  begin
    if (secNum >= 0) and (secNum < numSectors) then
    begin
      aMemo.Lines.Add(Format('wallptr: %d', [hSectors[secNum].wallptr]));
      aMemo.Lines.Add(Format('wallnum: %d', [hSectors[secNum].wallnum]));
      aMemo.Lines.Add(Format('ceilingz: %d', [hSectors[secNum].ceilingz]));
      aMemo.Lines.Add(Format('floorz: %d', [hSectors[secNum].floorz]));
      aMemo.Lines.Add(Format('ceilingstat: %d', [hSectors[secNum].ceilingstat]));
      aMemo.Lines.Add(Format('floorstat: %d', [hSectors[secNum].floorstat]));
      aMemo.Lines.Add(Format('ceilingpicnum: %d', [hSectors[secNum].ceilingpicnum]));
      aMemo.Lines.Add(Format('ceilingheinum: %d', [hSectors[secNum].ceilingheinum]));
      aMemo.Lines.Add(Format('ceilingshade: %d', [hSectors[secNum].ceilingshade]));
      aMemo.Lines.Add(Format('ceilingpal: %d', [hSectors[secNum].ceilingpal]));
      aMemo.Lines.Add(Format('ceilingxpanning: %d', [hSectors[secNum].ceilingxpanning]));
      aMemo.Lines.Add(Format('ceilingypanning: %d', [hSectors[secNum].ceilingypanning]));
      aMemo.Lines.Add(Format('floorpicnum: %d', [hSectors[secNum].floorpicnum]));
      aMemo.Lines.Add(Format('floorheinum: %d', [hSectors[secNum].floorheinum]));
      aMemo.Lines.Add(Format('floorshade: %d', [hSectors[secNum].floorshade]));
      aMemo.Lines.Add(Format('floorpal: %d', [hSectors[secNum].floorpal]));
      aMemo.Lines.Add(Format('floorxpanning: %d', [hSectors[secNum].floorxpanning]));
      aMemo.Lines.Add(Format('floorypanning: %d', [hSectors[secNum].floorypanning]));
      aMemo.Lines.Add(Format('visibility: %d', [hSectors[secNum].visibility]));
      aMemo.Lines.Add(Format('filler: %d', [hSectors[secNum].filler]));
      aMemo.Lines.Add(Format('lotag: %d', [hSectors[secNum].lotag]));
      aMemo.Lines.Add(Format('hitag: %d', [hSectors[secNum].hitag]));
      aMemo.Lines.Add(Format('extra: %d', [hSectors[secNum].extra]));
      aMemo.Lines.Add('--------------');
      aMemo.Lines.Add(Format('Height: %d', [(hSectors[secNum].floorz - hSectors[secNum].ceilingz) div 16]));
      aMemo.Lines.Add('--------------');
      aMemo.Lines.Add('ceilingstat:');
      if (hSectors[secNum].ceilingstat and  sec_Parallaxing) <> 0 then
        aMemo.Lines.Add('Parallaxing');
      if (hSectors[secNum].ceilingstat and  sec_Sloped) <> 0 then
        aMemo.Lines.Add('Sloped');
      if (hSectors[secNum].ceilingstat and  sec_xySwap) <> 0 then
        aMemo.Lines.Add('xySwap');
      if (hSectors[secNum].ceilingstat and  sec_DoubleSmooshiness) <> 0 then
        aMemo.Lines.Add('Double smooshiness');
      if (hSectors[secNum].ceilingstat and  sec_xFlip) <> 0 then
        aMemo.Lines.Add('xFliped');
      if (hSectors[secNum].ceilingstat and  sec_yFlip) <> 0 then
        aMemo.Lines.Add('yFliped');
      if (hSectors[secNum].ceilingstat and  sec_AlignTextureToFirstWall) <> 0 then
        aMemo.Lines.Add('Align texture to first wall');
      aMemo.Lines.Add('--------------');
      aMemo.Lines.Add('floorstat:');
      if (hSectors[secNum].floorstat and  sec_Parallaxing) <> 0 then
        aMemo.Lines.Add('Parallaxing');
      if (hSectors[secNum].floorstat and  sec_Sloped) <> 0 then
        aMemo.Lines.Add('Sloped');
      if (hSectors[secNum].floorstat and  sec_xySwap) <> 0 then
        aMemo.Lines.Add('xySwap');
      if (hSectors[secNum].floorstat and  sec_DoubleSmooshiness) <> 0 then
        aMemo.Lines.Add('Double smooshiness');
      if (hSectors[secNum].floorstat and  sec_xFlip) <> 0 then
        aMemo.Lines.Add('xFliped');
      if (hSectors[secNum].floorstat and  sec_yFlip) <> 0 then
        aMemo.Lines.Add('yFliped');
      if (hSectors[secNum].floorstat and  sec_AlignTextureToFirstWall) <> 0 then
        aMemo.Lines.Add('Align texture to first wall');

    end;

    aMemo := Memo3;
    secNum := hWalls[fPoint].nextsector;
    secNum2 := secNum;
  end;

  Label4.Caption := Label1.Caption;
  Label5.Caption := Label2.Caption;
  Label6.Caption := Label3.Caption;
  if Scene <> nil then
  begin
    Image1.Picture.Bitmap.Width := 0;
    Image1.Picture.Bitmap.Height := 0;
    if hWalls[fPoint].picnum >= 0 then
    begin
      bmp := Scene.GetTextureBmp(hWalls[fPoint].picnum);
      if bmp <> nil then
      try
        Image1.Picture.Bitmap.Width := bmp.Width;
        Image1.Picture.Bitmap.Height := bmp.Height;
        Image1.Picture.Bitmap.Canvas.Draw(0, 0, bmp);
      finally
        bmp.Free;
      end;
    end;
    Panel15.Caption := Format('(%d x %d)', [Image1.Picture.Bitmap.Width, Image1.Picture.Bitmap.Height]);

    Image2.Picture.Bitmap.Width := 0;
    Image2.Picture.Bitmap.Height := 0;
    if secNum1 >= 0 then
    begin
      bmp := Scene.GetTextureBmp(hSectors[secNum1].floorpicnum);
      if bmp <> nil then
      try
        Image2.Picture.Bitmap.Width := bmp.Width;
        Image2.Picture.Bitmap.Height := bmp.Height;
        Image2.Picture.Bitmap.Canvas.Draw(0, 0, bmp);
      finally
        bmp.Free;
      end;
    end;
    Panel16.Caption := Format('(%d x %d)', [Image2.Picture.Bitmap.Width, Image2.Picture.Bitmap.Height]);

    Image4.Picture.Bitmap.Width := 0;
    Image4.Picture.Bitmap.Height := 0;
    if secNum1 >= 0 then
    begin
      bmp := Scene.GetTextureBmp(hSectors[secNum1].ceilingpicnum);
      if bmp <> nil then
      try
        Image4.Picture.Bitmap.Width := bmp.Width;
        Image4.Picture.Bitmap.Height := bmp.Height;
        Image4.Picture.Bitmap.Canvas.Draw(0, 0, bmp);
      finally
        bmp.Free;
      end;
    end;
    Panel18.Caption := Format('(%d x %d)', [Image4.Picture.Bitmap.Width, Image4.Picture.Bitmap.Height]);

    Image3.Picture.Bitmap.Width := 0;
    Image3.Picture.Bitmap.Height := 0;
    if secNum2 >= 0 then
    begin
      bmp := Scene.GetTextureBmp(hSectors[secNum2].floorpicnum);
      if bmp <> nil then
      try
        Image3.Picture.Bitmap.Width := bmp.Width;
        Image3.Picture.Bitmap.Height := bmp.Height;
        Image3.Picture.Bitmap.Canvas.Draw(0, 0, bmp);
      finally
        bmp.Free;
      end;
    end;
    Panel17.Caption := Format('(%d x %d)', [Image3.Picture.Bitmap.Width, Image3.Picture.Bitmap.Height]);

    Image5.Picture.Bitmap.Width := 0;
    Image5.Picture.Bitmap.Height := 0;
    if secNum2 >= 0 then
    begin
      bmp := Scene.GetTextureBmp(hSectors[secNum2].ceilingpicnum);
      if bmp <> nil then
      try
        Image5.Picture.Bitmap.Width := bmp.Width;
        Image5.Picture.Bitmap.Height := bmp.Height;
        Image5.Picture.Bitmap.Canvas.Draw(0, 0, bmp);
      finally
        bmp.Free;
      end;
    end;
    Panel19.Caption := Format('(%d x %d)', [Image5.Picture.Bitmap.Width, Image5.Picture.Bitmap.Height]);

  end;
end;

procedure TMapInfoForm.FormCreate(Sender: TObject);
begin
  regFormRestorer1 := TFormRestorer.Create(self);
  regFormRestorer1.ParentKey := DXViewerForm.AppConfigKey1;
  regFormRestorer1.Name := 'FormRestorer1';
  regFormRestorer1.Restoring := frPositionOnly;
  regFormRestorer1.Restore;

  fPoint := -1;
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
  PageControl3.ActivePageIndex := 0;
  Clear;
end;

procedure TMapInfoForm.CreateParams;
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_PALETTEWINDOW;
end;

procedure TMapInfoForm.FormResize(Sender: TObject);
begin
  Panel4.Width := Panel3.Width div 3;
  Panel5.Width := Panel3.Width div 3;
  Panel6.Width := Panel3.Width - Panel4.Width - Panel5.Width;

  Panel2.Width := Panel4.Width;
  Panel11.Width := Panel5.Width;
  Panel13.Width := Panel6.Width;
end;

end.
