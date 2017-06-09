unit UTalking;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Edit,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.TMSBaseControl, FMX.TMSLabelEdit,
  FMX.TMSCustomEdit, FMX.TMSSearchEdit, UDm, UMain, FMX.ScrollBox, FMX.Memo, FMX.ListBox;

type
  TTalkForm = class(TForm)
    LY_Talking: TLayout;
    Panel4: TPanel;
    Rectangle3: TRectangle;
    Text15: TText;
    Circle3: TCircle;
    Image1: TImage;
    LY_Send: TLayout;
    RoundRect9: TRoundRect;
    Text7: TText;
    LY_Remake: TLayout;
    RoundRect10: TRoundRect;
    Text4: TText;
    LY_SubTitle: TLayout;
    Layout2: TLayout;
    RoundRect1: TRoundRect;
    Text1: TText;
    LY_Letter: TLayout;
    ToolBar6: TToolBar;
    Text14: TText;
    masterbutton: TButton;
    Rectangle1: TRectangle;
    MEMO_Letter: TMemo;
    ComboBox1: TComboBox;
    Text2: TText;
    procedure remakebutton(Sender: TObject);
    procedure masterbuttonClick(Sender: TObject);
    function SendMSG: Boolean;
    function FindUser: Boolean;
    procedure SendClick(Sender: TObject);
  private
    { Private declarations }
  var
    UserToID, UserFromID: string;
  public
    { Public declarations }
  end;

var
  TalkForm: TTalkForm;

implementation

{$R *.fmx}

function TTalkForm.FindUser: Boolean;
var
  ToId: string;
begin
  ToId := ComboBox1.Selected.Text;

  if ToId = '�߱�������' then
    UserToID := 'jkmanager';
  if ToId = '���빮������' then
    UserToID := 'ddmmanager';
  if ToId = 'û��õ������' then
    UserToID := 'ckcmanager';

end;

procedure TTalkForm.masterbuttonClick(Sender: TObject);
begin
  TalkForm.Close;
end;

procedure TTalkForm.remakebutton(Sender: TObject);
begin
  MEMO_Letter.Text := '';
end;

procedure TTalkForm.SendClick(Sender: TObject);
begin
  SendMSG;
  TalkForm.Close;
end;

function TTalkForm.SendMSG: Boolean; // qryTalking �� �������� ������ function
var
  MesContent: string;
  MesDate: TDate;
  MesTime: TTime;
begin
  Dm.Cl_qryTalking.Append;

  FindUser;

  UserFromID := Dm.myuser;
  MesContent := MEMO_Letter.Text;
  MesDate := now;
  MesTime := now;

  Dm.Cl_qryTalking.FieldByName('USerTo_ID').AsString := UserToID;
  Dm.Cl_qryTalking.FieldByName('USerFrom_ID').AsString := UserFromID;
  Dm.Cl_qryTalking.FieldByName('MES_CONTENT').AsString := MesContent;
  Dm.Cl_qryTalking.FieldByName('MES_DATE').AsDateTime := MesDate;
  Dm.Cl_qryTalking.FieldByName('MES_TIME').AsDateTime := MesTime;

  Dm.Cl_qryTalking.post;
  ShowMessage('�޽��� ����');

  if Dm.Cl_qryTalking.ChangeCount > 0 then
  begin
    Dm.Cl_qryTalking.applyUpdates(0);
  end;

end;

end.
