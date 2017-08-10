unit u_lap_perangkingan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_lap_rangking = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    grp2: TGroupBox;
    Label2: TLabel;
    edttahun: TEdit;
    grp3: TGroupBox;
    btn_campur: TBitBtn;
    btn_keluar: TBitBtn;
    img1: TImage;
    cbbjenjang: TComboBox;
    Label3: TLabel;
    procedure btn_keluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_campurClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function bln_indi(vtgl:TDate):string;
  end;

var
  f_lap_rangking: Tf_lap_rangking;

implementation

uses
  u_dm, u_report_rang;

{$R *.dfm}

procedure Tf_lap_rangking.btn_keluarClick(Sender: TObject);
begin
 Close;
end;

procedure Tf_lap_rangking.FormShow(Sender: TObject);
begin
 edttahun.Text:=FormatDateTime('yyyy',Now);
 cbbjenjang.Text:='';
 cbbjenjang.ItemIndex:=-1;
end;

procedure Tf_lap_rangking.btn_campurClick(Sender: TObject);
begin
 if edttahun.Text='' then
  begin
    MessageDlg('Tahun Wajib Diisi',mtInformation,[mbok],0);
    Exit;
  end;

 with dm.qry_tampil_hasil do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select a.kd_proses, a.tahun, b.npsp, b.nm_sekolah, b.kec, a.jenj, a.nilai_s, a.nilai_v, a.nilai_wp from tbl_rangking a, tbl_sekolah');
    sql.Add('b where a.npsp=b.npsp and a.tahun='+QuotedStr(edttahun.Text)+' order by a.nilai_wp desc');
    Open;
    if IsEmpty then
     begin
       MessageDlg('Data Tidak Ada',mtInformation,[mbok],0);
       Exit;
     end;

    with report_rangking do
     begin
       qrlbltahun.Caption:=edttahun.Text;
       //qrlbljenjang.Caption:=cbbjenjang.Text;
       qrlbl_bln.Caption:=bln_indi(Now);
       Preview;
     end;
  end;

end;

function Tf_lap_rangking.bln_indi(vtgl: TDate): string;
const nama_bln : array [1..12] of string = ('Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember');
var a: Integer;
begin
  for a:=1 to 12 do
   begin
     LongMonthNames[a]:=Nama_bln[a];
   end;

   Result:=FormatDateTime('dd mmmm yyyy',vtgl);
end;
end.
