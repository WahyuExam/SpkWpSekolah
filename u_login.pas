unit u_login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_login = class(TForm)
    edtpengguna: TEdit;
    edtsandi: TEdit;
    btnlogin: TBitBtn;
    btnkeluar: TBitBtn;
    img1: TImage;
    procedure FormShow(Sender: TObject);
    procedure btnkeluarClick(Sender: TObject);
    procedure edtpenggunaKeyPress(Sender: TObject; var Key: Char);
    procedure edtsandiKeyPress(Sender: TObject; var Key: Char);
    procedure btnloginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_login: Tf_login;

implementation

uses
  u_dm, u_menuutama;

{$R *.dfm}

procedure Tf_login.FormShow(Sender: TObject);
begin
 edtpengguna.Clear; edtpengguna.SetFocus;
 edtsandi.Clear;
end;

procedure Tf_login.btnkeluarClick(Sender: TObject);
begin
 Application.Terminate;
end;

procedure Tf_login.edtpenggunaKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then edtsandi.SetFocus;
end;

procedure Tf_login.edtsandiKeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then btnlogin.Click;
end;

procedure Tf_login.btnloginClick(Sender: TObject);
begin
 if (Trim(edtpengguna.Text)='') or (Trim(edtsandi.Text)='') then
  begin
    MessageDlg('Pengguna dan Kata Sandi Harus Diisi',mtWarning,[mbOK],0);
    Exit;
  end;

 if (edtpengguna.Text=dm.tbl_pengguna.FieldByName('pengguna').AsString) and (edtsandi.Text=dm.tbl_pengguna.FieldByName('sandi').AsString) then
  begin
    f_menu.ShowModal;
    Exit;
  end
  else
  begin
    MessageDlg('Pengguna dan Kata Sandi Yang Anda Masukkan Salah',mtError,[mbok],0);
    edtpengguna.Clear;
    edtsandi.Clear;
    edtpengguna.SetFocus;
  end;
end;

end.
