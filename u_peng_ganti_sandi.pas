unit u_peng_ganti_sandi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_peng_gantisandi = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    grp2: TGroupBox;
    Label2: TLabel;
    edtpengguna: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtsandilama: TEdit;
    edtsandibaru: TEdit;
    grp3: TGroupBox;
    btncampur: TBitBtn;
    btnsimpan: TBitBtn;
    btnkeluar: TBitBtn;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btncampurClick(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure edtsandibaruKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_peng_gantisandi: Tf_peng_gantisandi;

implementation

uses
  u_dm;

{$R *.dfm}

procedure Tf_peng_gantisandi.btnkeluarClick(Sender: TObject);
begin
 Close;
end;

procedure Tf_peng_gantisandi.FormShow(Sender: TObject);
begin
 edtpengguna.Text:=dm.tbl_pengguna.fieldbyname('pengguna').AsString;
 edtsandilama.Text:=dm.tbl_pengguna.fieldbyname('sandi').AsString;
 edtpengguna.Enabled:=false;
 edtsandilama.Enabled:=False;

 edtsandibaru.Clear; edtsandibaru.Enabled:=False;
 btncampur.Enabled:=True; btncampur.Caption:='Ubah';
 btnsimpan.Enabled:=false;
 btnkeluar.Enabled:=True;
end;

procedure Tf_peng_gantisandi.btncampurClick(Sender: TObject);
begin
 if btncampur.Caption='Ubah' then
  begin
    edtsandibaru.Enabled:=True; edtsandibaru.SetFocus;
    btncampur.Caption:='Batal';
    btnsimpan.Enabled:=True;
    btnkeluar.Enabled:=false;
  end
  else
 if btncampur.Caption='Batal' then FormShow(Sender);
end;

procedure Tf_peng_gantisandi.btnsimpanClick(Sender: TObject);
begin
 if Trim(edtsandibaru.Text)='' then
  begin
    MessageDlg('Kata Sandi Baru Belum Dimasukkan',mtInformation,[mbOK],0);
    edtsandibaru.SetFocus;
    Exit;
  end;

  with dm.tbl_pengguna do
   begin
     Edit;
     FieldByName('sandi').AsString:=edtsandibaru.Text;
     Post;
   end;
   MessageDlg('Kata Sandi Sudah Diganti',mtInformation,[mbok],0);
   FormShow(Sender);
end;

procedure Tf_peng_gantisandi.edtsandibaruKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Key=#13 then btnsimpan.Click;
end;

end.
