unit u_bantu_sekolah2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, jpeg, ExtCtrls;

type
  Tf_bantu_sekolah2 = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    grp5: TGroupBox;
    dbgrd1: TDBGrid;
    grp2: TGroupBox;
    btnpilih: TBitBtn;
    btnkeluar: TBitBtn;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure btnpilihClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_bantu_sekolah2: Tf_bantu_sekolah2;

implementation

uses
  u_dm, u_lap_nilai_sekolah;

{$R *.dfm}

procedure Tf_bantu_sekolah2.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_bantu_sekolah2.btnpilihClick(Sender: TObject);
begin
 with f_lap_nilai_sekolah do
  begin
    npsp := Self.dbgrd1.Fields[2].AsString;
    edtsekolah.Text:=Self.dbgrd1.Fields[3].AsString;
  end;
  Close;
end;

end.
