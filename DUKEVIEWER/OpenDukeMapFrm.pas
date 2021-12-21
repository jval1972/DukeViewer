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
//  Main Map Form
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  New site: https://sourceforge.net/projects/dukeviewer/
//  Old Site: http://www.geocities.ws/jimmyvalavanis/applications/dukeviewer.html
//------------------------------------------------------------------------------

{$I defs.inc}

unit OpenDukeMapFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  se_Duke3DUtils, se_Duke3DTypes, AnotherReg, StdCtrls, ExtCtrls,
  rmBaseEdit, rmBtnEdit, Buttons, Spin, ComCtrls, MessageBox, Variants;

type
  TOpenDukeMapForm = class(TForm)
    Notebook1: TNotebook;
    Panel1: TPanel;
    Panel2: TPanel;
    Bevel1: TBevel;
    OKBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    NextMap: TSpeedButton;
    PrevMap: TSpeedButton;
    TrackBar1: TTrackBar;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    CheckBox1: TCheckBox;
    MapNameLabel: TLabel;
    Image1: TImage;
    Image2: TImage;
    TrackBar2: TTrackBar;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FileEdit1Btn1Click(Sender: TObject);
    procedure FileEdit2Btn1Click(Sender: TObject);
    procedure PrevMapClick(Sender: TObject);
    procedure NextMapClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FileEdit1Change(Sender: TObject);
    procedure FileEdit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
    MessageBox1: TMessageBox;
    MessageBox2: TMessageBox;
    MessageBox3: TMessageBox;

    FileEdit1: TrmBtnEdit;
    FileEdit2: TrmBtnEdit;

    FormRestorer1: TFormRestorer;
    regdoThings: TVariantProfile;
    regLightFactor: TVariantProfile;
    regComplexityFactor: TVariantProfile;

    procedure UpdateMaps;
    procedure UpdateMapsComboBox;
    procedure UpdateEditorChange(FileEdit: TrmBtnEdit; default: string);
  public
    { Public declarations }
  end;

function QueryImportDukeMap(AOwner: TComponent;
  var MainGRP, AdditionalGRP: TFileName; var MapName: string;
  var cFactor: integer; var lFactor: integer; var bdoThings: boolean;
  var MapList: TStringList): boolean;

implementation

uses
  Math, se_DXDUtils, Unit1, smoothshow;

{$R *.DFM}

function QueryImportDukeMap(AOwner: TComponent;
  var MainGRP, AdditionalGRP: TFileName; var MapName: string;
  var cFactor: integer; var lFactor: integer; var bdoThings: boolean;
  var MapList: TStringList): boolean;
begin
  Result := False;
  with TOpenDukeMapForm.Create(AOwner) do
  try
    FileEdit1.Text := MainGRP;
    if AdditionalGRP <> '' then
      FileEdit2.Text := AdditionalGRP
    else
      FileEdit2.Text := MainGRP;
    if lFactor >= 0 then
      TrackBar1.Position := round(lFactor * (TrackBar1.Max - TrackBar1.Min));
    if (cFactor >= TrackBar2.Min) and (cFactor <= TrackBar2.Max) then
      TrackBar2.Position := cFactor;
    UpdateMaps;
    if MapName <> '' then
      ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(MapName);
    ShowModal;
    if ModalResult = mrOK then
    begin
      MainGRP := FileEdit1.Text;
      AdditionalGRP := FileEdit2.Text;
      lFactor := TrackBar1.Position * 8;
      cFactor := TrackBar2.Position;
      if ComboBox1.ItemIndex <> -1 then
        MapName := ComboBox1.Items[ComboBox1.ItemIndex];
      bdoThings := CheckBox1.Checked;
      if MapList = nil then
        MapList := TStringList.Create
      else
        MapList.Clear;
      MapList.AddStrings(ComboBox1.Items);
      Result := True;
    end;
  finally
    Free;
  end;
end;

procedure TOpenDukeMapForm.FormShow(Sender: TObject);
begin
  FormSmoothShow(self, DXViewerForm);
  UpdateMaps;
end;

procedure TOpenDukeMapForm.FileEdit1Btn1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    FileEdit1.Text := OpenDialog1.FileName;
    FileEdit2.Text := OpenDialog1.FileName;
    UpdateMaps;
    ComboBox1.ItemIndex := 0;
    UpdateMapsComboBox;
  end;
end;

procedure TOpenDukeMapForm.FileEdit2Btn1Click(Sender: TObject);
begin
  if OpenDialog2.Execute then
  begin
    FileEdit2.Text := OpenDialog2.FileName;
    UpdateMaps;
    ComboBox1.ItemIndex := 0;
    UpdateMapsComboBox;
  end;
end;

procedure TOpenDukeMapForm.UpdateMaps;
begin
  if (FileEdit2.Text <> '') and FileExists(FileEdit2.Text) then
  begin
    ComboBox1.Enabled := True;
    GetDuke3DMaps(FileEdit2.Text, ComboBox1.Items);
    if ComboBox1.Items.Count > 0 then
    begin
      ComboBox1.Enabled := True;
      OKBtn.Enabled := True;
    end
    else
    begin
      ComboBox1.Enabled := False;
      OKBtn.Enabled := False;
    end
  end
  else
  begin
    ComboBox1.Enabled := False;
    OKBtn.Enabled := False;
  end;
  UpdateMapsComboBox;
//  PrevMap.Enabled := ComboBox1.ItemIndex > 0;
//  NextMap.Enabled := (ComboBox1.ItemIndex < (ComboBox1.Items.Count - 1)) and (ComboBox1.Items.Count > 0);
end;

procedure TOpenDukeMapForm.PrevMapClick(Sender: TObject);
begin
  if ComboBox1.ItemIndex > 0 then
  begin
    ComboBox1.ItemIndex := ComboBox1.ItemIndex - 1;
    PrevMap.Enabled := ComboBox1.ItemIndex > 0;
    NextMap.Enabled := True;
  end;
  UpdateMapsComboBox;
end;

procedure TOpenDukeMapForm.NextMapClick(Sender: TObject);
begin
  if ComboBox1.ItemIndex < ComboBox1.Items.Count - 1 then
  begin
    ComboBox1.ItemIndex := ComboBox1.ItemIndex + 1;
    PrevMap.Enabled := True;
    NextMap.Enabled := (ComboBox1.ItemIndex < (ComboBox1.Items.Count - 1)) and (ComboBox1.Items.Count > 0);
  end
  else
  begin
    PrevMap.Enabled := ComboBox1.ItemIndex > 0;
    NextMap.Enabled := False;
  end;
  UpdateMapsComboBox;
end;

procedure TOpenDukeMapForm.UpdateMapsComboBox;
begin
  PrevMap.Enabled := ComboBox1.ItemIndex > 0;
  NextMap.Enabled := (ComboBox1.ItemIndex < (ComboBox1.Items.Count - 1)) and (ComboBox1.Items.Count > 0);
  if ComboBox1.ItemIndex > -1 then
    MapNameLabel.Caption := GetDuke3DDefMapName(ComboBox1.Items[ComboBox1.ItemIndex])
  else
    MapNameLabel.Caption := '';
end;

procedure TOpenDukeMapForm.ComboBox1Change(Sender: TObject);
begin
  UpdateMapsComboBox;
end;

resourceString
  rsMAINGRP = 'Main GRP file';
  rsADDITIONALGRP = 'Additional GRP file';

procedure TOpenDukeMapForm.UpdateEditorChange(FileEdit: TrmBtnEdit; default: string);
begin
  Screen.Cursor := crHourglass;
  Refresh;
  try
    if (FileEdit.Text <> '') and FileExists(FileEdit.Text) then
      UpdateMapsComboBox
    else
      FileEdit.Hint := default;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TOpenDukeMapForm.FileEdit1Change(Sender: TObject);
begin
  UpdateEditorChange(FileEdit1, rsMAINGRP);
end;

procedure TOpenDukeMapForm.FileEdit2Change(Sender: TObject);
begin
  UpdateEditorChange(FileEdit2, rsADDITIONALGRP);
end;

procedure TOpenDukeMapForm.FormCreate(Sender: TObject);
begin
  FormRestorer1 := TFormRestorer.Create(self);
  FormRestorer1.ParentKey := DXViewerForm.AppConfigKey1;
  FormRestorer1.Name := 'FormRestorer1';
  FormRestorer1.Restoring := frPositionOnly;
  FormRestorer1.Restore;

  regLightFactor := TVariantProfile.Create(self);
  regLightFactor.Key := FormRestorer1;
  regLightFactor.Name := 'LightFactor';

  regComplexityFactor := TVariantProfile.Create(self);
  regComplexityFactor.Key := FormRestorer1;
  regComplexityFactor.Name := 'ComplexityFactor';

  regdoThings := TVariantProfile.Create(self);
  regdoThings.Key := FormRestorer1;
  regdoThings.Name := 'doThings';

  MessageBox1 := TMessageBox.Create(self);
  MessageBox1.Caption := 'DukeViewer';
  MessageBox1.Text := 'Please select each file as an existed file on disk.';
  MessageBox1.Buttons := mbxOK;
  MessageBox1.Icon := mbxIconError;
  MessageBox1.DefaultButton := mbxDefButton1;
  MessageBox1.Modality := mbxDefModality;
  MessageBox1.TextAlignment := mbxLeft;

  MessageBox2 := TMessageBox.Create(self);
  MessageBox2.Caption := 'DukeViewer';
  MessageBox2.Text := 'Main GRP file not found!';
  MessageBox2.Buttons := mbxOK;
  MessageBox2.Icon := mbxIconError;
  MessageBox2.DefaultButton := mbxDefButton1;
  MessageBox2.Modality := mbxDefModality;
  MessageBox2.TextAlignment := mbxLeft;

  MessageBox3 := TMessageBox.Create(self);
  MessageBox3.Caption := 'DukeViewer';
  MessageBox3.Text := 'Additional MAP file not found!';
  MessageBox3.Buttons := mbxOK;
  MessageBox3.Icon := mbxIconError;
  MessageBox3.DefaultButton := mbxDefButton1;
  MessageBox3.Modality := mbxDefModality;
  MessageBox3.TextAlignment := mbxLeft;

  FileEdit1 := TrmBtnEdit.Create(self);
  FileEdit1.Parent := NoteBook1;
  FileEdit1.Left := 120;
  FileEdit1.Top := 14;
  FileEdit1.Width := 361;
  FileEdit1.Height := 21;
  FileEdit1.Hint := 'Select main GRP filename';
  FileEdit1.BtnWidth := 22;
  FileEdit1.Btn1Glyph := Image1.Picture.Bitmap;
  FileEdit1.Btn1NumGlyphs := 1;
  FileEdit1.Btn2Glyph := Image2.Picture.Bitmap;
  FileEdit1.Btn2NumGlyphs := 1;
  FileEdit1.TabOrder := 0;
  FileEdit1.OnChange := FileEdit1Change;
  FileEdit1.OnBtn1Click := FileEdit1Btn1Click;

  FileEdit2 := TrmBtnEdit.Create(self);
  FileEdit2.Parent := NoteBook1;
  FileEdit2.Left := 120;
  FileEdit2.Top := 38;
  FileEdit2.Width := 361;
  FileEdit2.Height := 21;
  FileEdit2.Hint := 'Select external MAP file';
  FileEdit2.BtnWidth := 22;
  FileEdit2.Btn1Glyph := Image1.Picture.Bitmap;
  FileEdit2.Btn1NumGlyphs := 1;
  FileEdit2.Btn2Glyph := Image2.Picture.Bitmap;
  FileEdit2.Btn2NumGlyphs := 1;
  FileEdit2.TabOrder := 1;
  FileEdit2.OnChange := FileEdit2Change;
  FileEdit2.OnBtn1Click := FileEdit2Btn1Click;

  if TrackBar1.Min > DEFDUKE3DCOMPLEXITYFACTOR then
    TrackBar1.Min := DEFDUKE3DCOMPLEXITYFACTOR;
  if TrackBar1.Max < DEFDUKE3DCOMPLEXITYFACTOR then
    TrackBar1.Max := DEFDUKE3DCOMPLEXITYFACTOR;

  if not VarIsEmpty(regLightFactor.Value) then
    TrackBar1.Position := Max(TrackBar1.Min, Min(regLightFactor.Value, TrackBar1.Max));
  if not VarIsEmpty(regComplexityFactor.Value) then
    TrackBar2.Position := Max(TrackBar2.Min, Min(regComplexityFactor.Value, TrackBar2.Max));
  if not VarIsEmpty(regdoThings.Value) then
    CheckBox1.Checked := regdoThings.Value;
end;

procedure TOpenDukeMapForm.FormDestroy(Sender: TObject);
begin
  regdoThings.Value := CheckBox1.Checked;
  regdoThings.Free;

  regLightFactor.Value := TrackBar1.Position;
  regLightFactor.Free;

  regComplexityFactor.Value := TrackBar2.Position;
  regComplexityFactor.Free;

  FormRestorer1.Store;
  FormRestorer1.Free;

  MessageBox1.Free;
  MessageBox2.Free;
  MessageBox3.Free;

  FileEdit1.Free;
  FileEdit2.Free;
end;

procedure TOpenDukeMapForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOk then
  begin
    CanClose := (FileEdit1.Text <> '') and FileExists(FileEdit1.Text) and
                (FileEdit2.Text <> '') and FileExists(FileEdit2.Text);
    if not CanClose then
    begin
      if not FileExists(FileEdit1.Text) then
      begin
        MessageBox2.Execute;
        TryFocusControl(FileEdit1);
      end
      else if not FileExists(FileEdit2.Text) then
      begin
        MessageBox3.Execute;
        TryFocusControl(FileEdit2);
      end
      else
      begin
        MessageBox1.Execute;
        TryFocusControl(FileEdit1);
      end;
    end;
  end;
end;

procedure TOpenDukeMapForm.FormHide(Sender: TObject);
begin
  FormSmoothHide(self, DXViewerForm);
end;

end.
