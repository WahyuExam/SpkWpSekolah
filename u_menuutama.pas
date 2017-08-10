unit u_menuutama;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, jpeg, ExtCtrls;

type
  Tf_menu = class(TForm)
    img1: TImage;
    mm1: TMainMenu;
    Master1: TMenuItem;
    Sekolah1: TMenuItem;
    Bobot1: TMenuItem;
    ransaksi1: TMenuItem;
    IndikatorPenilaian1: TMenuItem;
    PenilaianSekolah1: TMenuItem;
    ProsesSAW1: TMenuItem;
    Laporan1: TMenuItem;
    Sekolah2: TMenuItem;
    IndikatorPenilaian2: TMenuItem;
    PenilaianSekolah2: TMenuItem;
    PerangkinganMetodeWP1: TMenuItem;
    Pengaturam1: TMenuItem;
    SalindanPanggilData1: TMenuItem;
    GantiKataSandi1: TMenuItem;
    PenanggungJawab1: TMenuItem;
    keluar1: TMenuItem;
    procedure keluar1Click(Sender: TObject);
    procedure Sekolah1Click(Sender: TObject);
    procedure Bobot1Click(Sender: TObject);
    procedure IndikatorPenilaian1Click(Sender: TObject);
    procedure PenilaianSekolah1Click(Sender: TObject);
    procedure ProsesSAW1Click(Sender: TObject);
    procedure GantiKataSandi1Click(Sender: TObject);
    procedure SalindanPanggilData1Click(Sender: TObject);
    procedure Sekolah2Click(Sender: TObject);
    procedure PenanggungJawab1Click(Sender: TObject);
    procedure PerangkinganMetodeWP1Click(Sender: TObject);
    procedure PenilaianSekolah2Click(Sender: TObject);
    procedure IndikatorPenilaian2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function bln_indi(vtgl:TDate):string;
  end;

var
  f_menu: Tf_menu;

implementation

uses
  u_mast_sekolah, u_mast_bobot, u_trans_indikator, u_trans_penilaian, 
  u_trans_proseswp, u_peng_ganti_sandi, u_peng_salindata, u_dm, ADODB, 
  u_report_sekolah, u_peng_jawab, u_report_rang, u_lap_perangkingan, 
  u_lap_nilai_sekolah, u_report_indikator_nilai, DB;

{$R *.dfm}

procedure Tf_menu.keluar1Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure Tf_menu.Sekolah1Click(Sender: TObject);
begin
 f_mast_sekolah.ShowModal;
end;

procedure Tf_menu.Bobot1Click(Sender: TObject);
begin
 f_mast_bobot.ShowModal;
end;

procedure Tf_menu.IndikatorPenilaian1Click(Sender: TObject);
begin
 f_trans_indikator.ShowModal;
end;

procedure Tf_menu.PenilaianSekolah1Click(Sender: TObject);
begin
 f_trans_nilai_sekolah.ShowModal;
end;

procedure Tf_menu.ProsesSAW1Click(Sender: TObject);
begin
 f_trans_proseswp.ShowModal;
end;

procedure Tf_menu.GantiKataSandi1Click(Sender: TObject);
begin
 f_peng_gantisandi.ShowModal;
end;

procedure Tf_menu.SalindanPanggilData1Click(Sender: TObject);
begin
 f_peng_salindata.ShowModal;
end;

procedure Tf_menu.Sekolah2Click(Sender: TObject);
begin
 with dm.qry_sekolah do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select * from tbl_sekolah';
    Open;
  end;
  report_sekolah.qrlbl_bln.Caption:=bln_indi(Now);
  report_sekolah.Preview;
end;

function Tf_menu.bln_indi(vtgl: TDate): string;
const nama_bln : array [1..12] of string = ('Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember');
var a: Integer;
begin
  for a:=1 to 12 do
   begin
     LongMonthNames[a]:=Nama_bln[a];
   end;

   Result:=FormatDateTime('dd mmmm yyyy',vtgl);
end;

procedure Tf_menu.PenanggungJawab1Click(Sender: TObject);
begin
 f_peng_jawab.ShowModal;
end;

procedure Tf_menu.PerangkinganMetodeWP1Click(Sender: TObject);
begin
 f_lap_rangking.ShowModal;
end;

procedure Tf_menu.PenilaianSekolah2Click(Sender: TObject);
begin
 f_lap_nilai_sekolah.ShowModal;
end;

procedure Tf_menu.IndikatorPenilaian2Click(Sender: TObject);
begin
 with repor_indikator_nilai.qry_lap_indi do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select a.kd_kriteria, a.kriteria, b.kd_sub_kriteria, b.sub_kriteria, c.kd_nil_indi, c.nm_indi, c.nil_indi from');
    sql.Add('tbl_kriteria a, tbl_sub_kriteria b, tbl_nil_indikator c where b.kd_kriteria=a.kd_kriteria and c.kd_sub_kriteria=b.kd_sub_kriteria');
    Open;

  end;
 repor_indikator_nilai.qrlbl_bln.Caption:=bln_indi(Now);
 repor_indikator_nilai.Preview;
end;

end.
