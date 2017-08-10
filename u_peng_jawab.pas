unit u_peng_jawab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_peng_jawab = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    grp2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtnip: TEdit;
    edtpenanggung: TEdit;
    edtjabatan: TEdit;
    grp3: TGroupBox;
    btncampur: TBitBtn;
    btnsimpan: TBitBtn;
    btnkeluar: TBitBtn;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btncampurClick(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure edtnipKeyPress(Sender: TObject; var Key: Char);
    procedure edtpenanggungKeyPress(Sender: TObject; var Key: Char);
    procedure edtjabatanKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_peng_jawab: Tf_peng_jawab;

implementation

uses
  u_dm, DB;

{$R *.dfm}

procedure Tf_peng_jawab.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_peng_jawab.FormShow(Sender: TObject);
begin
 edtnip.Text:=dm.tbl_penanggung.fieldbyname('nip').AsString;
 edtpenanggung.Text:=dm.tbl_penanggung.fieldbyname('nama').AsString;
 edtjabatan.Text:=dm.tbl_penanggung.fieldbyname('jabatan').AsString;
 edtnip.Enabled:=false;
 edtpenanggung.Enabled:=False;
 edtjabatan.Enabled:=false;
 
 btncampur.Enabled:=True; btncampur.Caption:='Ubah';
 btnsimpan.Enabled:=false;
 btnkeluar.Enabled:=True;
end;

procedure Tf_peng_jawab.btncampurClick(Sender: TObject);
begin
 if btncampur.Caption='Ubah' then
  begin
    edtnip.Enabled:=True; edtnip.SetFocus;
    edtpenanggung.Enabled:=True;
    edtjabatan.Enabled:=True;

    btncampur.Caption:='Batal';
    btnsimpan.Enabled:=True;
    btnkeluar.Enabled:=false;
  end
  else
 if btncampur.Caption='Batal' then FormShow(Sender);

end;

procedure Tf_peng_jawab.btnsimpanClick(Sender: TObject);
begin
 if (Trim(edtnip.Text)='') or (Trim(edtpenanggung.Text)='') or (Trim(edtjabatan.Text)='') then
  begin
    MessageDlg('Semua Data Wajib Diisi',mtInformation,[mbOK],0);
    edtnip.SetFocus;
    Exit;
  end;

  with dm.tbl_penanggung do
   begin
     Edit;
     FieldByName('nip').AsString:=edtnip.Text;
     FieldByName('nama').AsString:=edtpenanggung.Text;
     FieldByName('jabatan').AsString:=edtjabatan.Text;
     Post;
   end;
   MessageDlg('Penanggung Jawab Sudah Diganti',mtInformation,[mbok],0);
   FormShow(Sender);
end;

procedure Tf_peng_jawab.edtnipKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9',#13,#32,#8,#9]) then Key:=#0;
 if Key=#13 then edtpenanggung.SetFocus;
end;

procedure Tf_peng_jawab.edtpenanggungKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (key in ['A'..'Z','a'..'z',#13,#32,#8,#9]) then Key:=#0;
 if Key=#13 then edtjabatan.SetFocus;
end;

procedure Tf_peng_jawab.edtjabatanKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['A'..'Z','a'..'z',#13,#32,#8,#9]) then Key:=#0;
  if Key=#13 then btnsimpan.Click;
end;

end.
