unit u_bantu_sekolah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, jpeg, ExtCtrls;

type
  Tf_bantu_sekolah = class(TForm)
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
  f_bantu_sekolah: Tf_bantu_sekolah;
  kd : string;

implementation

uses
  u_dm, u_trans_penilaian;

{$R *.dfm}

procedure Tf_bantu_sekolah.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_bantu_sekolah.btnpilihClick(Sender: TObject);
begin
 kd:=dbgrd1.Fields[0].AsString;
 if kd='' then Exit;
 with f_trans_nilai_sekolah do
  begin
   edtsekolah.Text:=Self.dbgrd1.Fields[1].AsString;
   npsp:=Self.dbgrd1.Fields[0].AsString;
   jenj:=Self.dbgrd1.Fields[2].AsString;
   edtkec.Text:=Self.dbgrd1.Fields[3].AsString;

   dm.qry_rangking.Close;
   dm.qry_rangking.SQL.Clear;
   dm.qry_rangking.SQL.Text:='select * from tbl_rangking';
   dm.qry_rangking.Open;

   if dm.qry_rangking.Locate('npsp;tahun',VarArrayOf([npsp,edttahun.Text]),[]) then btn_campur.Click else
    begin
     btn_campur.Caption:='Tambah'; btn_campur.Enabled:=True;
     btn_simpan.Enabled:=false;
     btn_hapus.Enabled:=false;
     btn_keluar.Enabled:=True;
     with dm.qry_kriteria do
      begin
       Close;
       SQL.Clear;
       SQL.Text:='select * from tbl_kriteria where kd_kriteria='+QuotedStr('kosong')+'';
       Open;
      end;
    end;
  end;
  Self.Close;
end;

end.
