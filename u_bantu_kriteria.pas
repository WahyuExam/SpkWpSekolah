unit u_bantu_kriteria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, jpeg, ExtCtrls;

type
  Tf_bantu_kriteria = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    grp5: TGroupBox;
    dbgrd1: TDBGrid;
    grp2: TGroupBox;
    btnpilih: TBitBtn;
    btnkeluar: TBitBtn;
    edtket: TEdit;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure btnpilihClick(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_bantu_kriteria: Tf_bantu_kriteria;
  kd : string;

implementation

uses
  u_dm, u_trans_indikator, u_trans_penilaian, ADODB, DB;

{$R *.dfm}

procedure Tf_bantu_kriteria.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_bantu_kriteria.btnpilihClick(Sender: TObject);
begin
// if kd='' then Exit else
//  begin
   if edtket.Text='trans_indi' then
    begin
     with f_trans_indikator do
      begin
       edt_kriteria.Text:=Self.dbgrd1.Fields[1].AsString;
       kd_kriteria:=Self.dbgrd1.Fields[0].AsString;
       dblkcbbsubkriteria.Enabled:=True;
      end;

     with dm.qry_subkriteria do
      begin
        close;
        SQL.Clear;
        SQL.Text:='select * from tbl_sub_kriteria where kd_kriteria='+QuotedStr(Self.dbgrd1.Fields[0].AsString);
        Open;
        if IntToStr(RecordCount)='1' then f_trans_indikator.dblkcbbsubkriteria.KeyValue:=fieldbyname('kd_sub_kriteria').AsString;
      end;
    end
    else
   if edtket.Text='trans_nilai' then
    begin
     with f_trans_nilai_sekolah do
      begin
        kode_kriteria := Self.dbgrd1.Fields[0].AsString;
       // edtkriteria.Text:=Self.dbgrd1.Fields[1].AsString;

        with dm.qry_tampil_bantu_penilaian do
         begin
           Close;
           sql.Clear;
           sql.Add('select a.kd_proses, b.kd_sub_kriteria, b.sub_kriteria, a.nm_indi, a.nil_indi, a.kd_nil_indi, c.kd_kriteria,');
           SQL.Add('c.kriteria from tbl_nil_sek a, tbl_sub_kriteria b, tbl_kriteria c  where a.kd_sub_kriteria=b.kd_sub_kriteria');
           sql.Add('and b.kd_kriteria=c.kd_kriteria');
           SQL.Add('and c.kd_kriteria='+QuotedStr(kode_kriteria)+' and a.kd_proses='+QuotedStr(kd_proses)+'');
           Open;
         end;
        dbgrd1.Enabled:=True;
      //  btnbantukriteria.Enabled:=false;
      end;
    end;
    Self.Close;
//  end;
end;

procedure Tf_bantu_kriteria.dbgrd1CellClick(Column: TColumn);
begin
// kd:=dbgrd1.Fields[0].AsString;
end;

procedure Tf_bantu_kriteria.FormShow(Sender: TObject);
begin
 with dm.qry_kriteria do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
    Open;
    First;
  end;
end;

end.
