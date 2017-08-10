unit u_lap_nilai_sekolah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  Tf_lap_nilai_sekolah = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    grp2: TGroupBox;
    Label2: TLabel;
    edttahun: TEdit;
    grp3: TGroupBox;
    btn_campur: TBitBtn;
    btn_keluar: TBitBtn;
    rb1: TRadioButton;
    rb2: TRadioButton;
    Label3: TLabel;
    edtsekolah: TEdit;
    btnbantu: TBitBtn;
    bvl1: TBevel;
    img1: TImage;
    Label4: TLabel;
    cbbjenjang: TComboBox;
    grp4: TGroupBox;
    rb_kriteria: TRadioButton;
    rb_detail: TRadioButton;
    procedure btn_keluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_campurClick(Sender: TObject);
    procedure btnbantuClick(Sender: TObject);
    procedure cbbjenjangKeyPress(Sender: TObject; var Key: Char);
    procedure rb1Click(Sender: TObject);
    procedure rb2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function bln_indi(vtgl:TDate):string;
  end;

var
  f_lap_nilai_sekolah: Tf_lap_nilai_sekolah;
  npsp : string;

implementation

uses
  u_dm, u_bantu_sekolah, u_bantu_sekolah2, u_report_nilai_sekolah, 
  u_report_nilai_sekolah2;

{$R *.dfm}

procedure Tf_lap_nilai_sekolah.btn_keluarClick(Sender: TObject);
begin
 Close;
end;

procedure Tf_lap_nilai_sekolah.FormShow(Sender: TObject);
begin
 edttahun.Text:=FormatDateTime('yyyy',Now);
 rb1.Checked:=false;
 rb2.Checked:=False;
 edtsekolah.Clear;
 btnbantu.Enabled:=false;
 cbbjenjang.Text:='';
 cbbjenjang.ItemIndex:=-1;
{ with dm.qry_rangking do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select * from tbl_rangking';
    Open;
  end;   }
end;

procedure Tf_lap_nilai_sekolah.btn_campurClick(Sender: TObject);
begin
 if (Trim(edttahun.Text)='') then
  begin
    MessageDlg('Tahun Wajib Diisi',mtWarning,[mbok],0);
    Exit;
  end;

  if (rb1.Checked=False) and (rb2.Checked=false) then
   begin
     MessageDlg('Jenis Laporan Belum Dipilih',mtWarning,[mbok],0);
     Exit;
   end;

  if (rb_kriteria.Checked=False) and (rb_detail.Checked=False) then
   begin
     MessageDlg('Jenis Penilaian Belum Dipilih',mtWarning,[mbok],0);
     Exit;
   end;

  if rb1.Checked=True then
   begin
    if rb_detail.Checked=True then
     begin
       with report_nilai_sekolah.qry_laporan_nilai do
        begin
         Close;
         SQL.Clear;
         sql.Add('select a.kd_proses, a.tahun, b.npsp, b.nm_sekolah, b.kec, c.kd_sub_kriteria, c.sub_kriteria, d.kd_kriteria,');
         SQL.Add('d.kriteria, e.kd_nil_indi, e.nm_indi, e.nil_indi from tbl_rangking a, tbl_sekolah b, tbl_sub_kriteria c,');
         SQL.Add('tbl_kriteria d, tbl_nil_sek e where a.npsp=b.npsp and e.kd_proses=a.kd_proses and e.kd_sub_kriteria=c.kd_sub_kriteria and');
         sql.Add('c.kd_kriteria = d.kd_kriteria and a.tahun='+QuotedStr(edttahun.Text)+' order by b.npsp asc, d.kd_kriteria asc');
         Open;
         if IsEmpty then
           begin
            MessageDlg('Data Kosong',mtInformation,[mbok],0);
            Exit;
           end
         else
           begin
            with report_nilai_sekolah do
             begin
               qrlbl17.Caption:=edttahun.Text;
               qrlbl_bln.Caption:=bln_indi(Now);
               Preview;
             end;
           end;
        end;
     end
     else
    if rb_kriteria.Checked=True then
     begin
       with report_nilai_sekolah2.qry_laporan_nilai do
        begin
         Close;
         sql.Clear;
         SQL.Add('select a.kd_proses, a.tahun, a.jenj, b.npsp, b.nm_sekolah, b.kec, c.kd_kriteria, c.kriteria, d.nilai, a.nilai_wp');
         sql.Add('from tbl_rangking a, tbl_sekolah b, tbl_kriteria c, tbl_bantu_nilai d where a.npsp=b.npsp and d.kd_kriteria=c.kd_kriteria and');
         sql.Add('d.kd_proses=a.kd_proses and a.tahun='+QuotedStr(edttahun.Text)+'');
         sql.Add('order by b.npsp asc');
         Open;
         if IsEmpty then
           begin
            MessageDlg('Data Kosong',mtInformation,[mbok],0);
            Exit;
           end
          else
          begin
            with report_nilai_sekolah2 do
             begin
               qrlbl17.Caption:=edttahun.Text;
               qrlbl_bln.Caption:=bln_indi(Now);
               Preview;
             end;
          end;
        end;
     end;
   end
   else
  if rb2.Checked=True then
   begin
      if edtsekolah.Text='' then
       begin
         MessageDlg('Sekolah Belum Dipilih',mtInformation,[mbok],0);
         Exit;
       end;

      if rb_detail.Checked=True then
       begin
         with report_nilai_sekolah.qry_laporan_nilai do
          begin
            Close;
            SQL.Clear;
            sql.Add('select a.kd_proses, a.tahun, b.npsp, b.nm_sekolah, b.kec, c.kd_sub_kriteria, c.sub_kriteria, d.kd_kriteria,');
            sql.Add('d.kriteria, e.kd_nil_indi, e.nm_indi, e.nil_indi from tbl_rangking a, tbl_sekolah b, tbl_sub_kriteria c,');
            SQL.Add('tbl_kriteria d, tbl_nil_sek e where a.npsp=b.npsp and e.kd_proses=a.kd_proses and e.kd_sub_kriteria=c.kd_sub_kriteria and');
            sql.Add('c.kd_kriteria = d.kd_kriteria and a.tahun='+QuotedStr(edttahun.Text)+'');
            sql.Add('and b.npsp='+QuotedStr(npsp)+'order by d.kd_kriteria asc');
            Open;

            {Close;
            SQL.Clear;
            SQL.Add('select a.kd_proses, a.tahun, a.jenj, b.npsp, b.nm_sekolah, b.kec, c.kd_kriteria, c.kriteria, d.nilai, a.nilai_wp');
            sql.Add('from tbl_rangking a, tbl_sekolah b, tbl_kriteria c, tbl_bantu_nilai d where a.npsp=b.npsp and d.kd_kriteria=c.kd_kriteria and');
            sql.Add('d.kd_proses=a.kd_proses and a.tahun='+QuotedStr(edttahun.Text)+'');
            sql.Add('and b.npsp='+QuotedStr(npsp)+'');
            Open;                                     }
             with report_nilai_sekolah do
              begin
               qrlbl17.Caption:=edttahun.Text;
               qrlbl_bln.Caption:=bln_indi(Now);
               Preview;
              end;
          end;
       end
       else
      if rb_kriteria.Checked=True then
       begin
         with report_nilai_sekolah2.qry_laporan_nilai do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select a.kd_proses, a.tahun, a.jenj, b.npsp, b.nm_sekolah, b.kec, c.kd_kriteria, c.kriteria, d.nilai, a.nilai_wp');
            sql.Add('from tbl_rangking a, tbl_sekolah b, tbl_kriteria c, tbl_bantu_nilai d where a.npsp=b.npsp and d.kd_kriteria=c.kd_kriteria and');
            sql.Add('d.kd_proses=a.kd_proses and a.tahun='+QuotedStr(edttahun.Text)+'');
            sql.Add('and b.npsp='+QuotedStr(npsp)+'');
            Open;                                     
             with report_nilai_sekolah2 do
              begin
               qrlbl17.Caption:=edttahun.Text;
               qrlbl_bln.Caption:=bln_indi(Now);
               Preview;
              end;
          end;
       end;
   end;
end;

procedure Tf_lap_nilai_sekolah.btnbantuClick(Sender: TObject);
begin
 if (Trim(edttahun.Text)='') then
  begin
    MessageDlg('Tahun Harus Diisi',mtWarning,[mbok],0);
    Exit;
  end;

 with dm.qry_tampil_hasil do
  begin
    Close;
    SQL.Clear;
    sql.Add('select a.kd_proses, a.tahun, b.npsp, b.nm_sekolah, b.kec, a.jenj, a.nilai_wp from tbl_rangking a, tbl_sekolah b where a.npsp=b.npsp');
    SQL.Add('and a.tahun='+QuotedStr(edttahun.Text)+'');
    Open;
    if IsEmpty then
     begin
       MessageDlg('Tidak Ada Penilaian Sekolah Pada Tahun Ini',mtInformation,[mbok],0);
       Exit;
     end
     else f_bantu_sekolah2.ShowModal;
  end;
end;

function Tf_lap_nilai_sekolah.bln_indi(vtgl: TDate): string;
const nama_bln : array [1..12] of string = ('Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember');
var a: Integer;
begin
  for a:=1 to 12 do
   begin
     LongMonthNames[a]:=Nama_bln[a];
   end;

   Result:=FormatDateTime('dd mmmm yyyy',vtgl);
end;
procedure Tf_lap_nilai_sekolah.cbbjenjangKeyPress(Sender: TObject;
  var Key: Char);
begin
 Key:=#0;
end;

procedure Tf_lap_nilai_sekolah.rb1Click(Sender: TObject);
begin
 edtsekolah.Clear;
 btnbantu.Enabled:=false;
end;

procedure Tf_lap_nilai_sekolah.rb2Click(Sender: TObject);
begin
 edtsekolah.Clear;
 btnbantu.Enabled:=True;
end;

end.
