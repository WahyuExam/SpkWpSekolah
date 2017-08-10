unit u_dm;

interface

uses
  SysUtils, Classes, DB, ADODB, XPMan;

type
  Tdm = class(TDataModule)
    con1: TADOConnection;
    XPManifest1: TXPManifest;
    qry_kriteria: TADOQuery;
    qry_sekolah: TADOQuery;
    ds_sekolah: TDataSource;
    qry_bobot: TADOQuery;
    qry_tampil_bobot: TADOQuery;
    ds_tampil_bobot: TDataSource;
    qry_indikator_penilaian: TADOQuery;
    qry_tampil_indikator_penilaian: TADOQuery;
    ds_tampil_indikator_penilaian: TDataSource;
    ds_kriteria: TDataSource;
    qry_subkriteria: TADOQuery;
    ds_subkriteria: TDataSource;
    qry_tampil_bantu_penilaian: TADOQuery;
    qry_bantu_penilaian: TADOQuery;
    ds_tampil_bantu_penilaian: TDataSource;
    qry_rangking: TADOQuery;
    ds_indikator_nilai: TDataSource;
    qry_nilai_sekolah: TADOQuery;
    qry_tampil_hasil: TADOQuery;
    tbl_pengguna: TADOTable;
    ds_tampil_hasil: TDataSource;
    tbl_penanggung: TADOTable;
    tbl_kec: TADOTable;
    ds_kec: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
var ss : string;
begin
 con1.Connected:=false;
 getdir(0,ss);
 con1.ConnectionString:=
 'Provider=Microsoft.Jet.OLEDB.4.0;'+
 'Data Source='+ ss +'\dbwp.mdb;';
 con1.Connected:=true;

 //aktif semua
 tbl_pengguna.Active:=True;

 qry_kriteria.Active:=True;
 qry_sekolah.Active:=True;
 qry_bobot.Active:=True;
 qry_tampil_bobot.Active:=True;
 qry_subkriteria.Active:=True;

 qry_indikator_penilaian.Active:=True;
 qry_tampil_indikator_penilaian.Active:=True;

 qry_tampil_bantu_penilaian.Active:=True;
 qry_bantu_penilaian.Active:=True;
 qry_rangking.Active:=True;
 qry_nilai_sekolah.Active:=True;

 qry_tampil_hasil.Active:=True;
 tbl_penanggung.Active:=True;
 tbl_kec.Active:=True;
end;
end.
