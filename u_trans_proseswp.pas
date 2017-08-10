unit u_trans_proseswp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, math, DBGrids, jpeg, ExtCtrls;

type
  Tf_trans_proseswp = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    grp2: TGroupBox;
    Label2: TLabel;
    edttahun: TEdit;
    Label3: TLabel;
    cbbjenjang: TComboBox;
    grp3: TGroupBox;
    btnproses: TBitBtn;
    btnbersih: TBitBtn;
    btnkeluar: TBitBtn;
    dbgrd1: TDBGrid;
    img1: TImage;
    Label4: TLabel;
    edtjml_data: TEdit;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edttahunKeyPress(Sender: TObject; var Key: Char);
    procedure btnprosesClick(Sender: TObject);
    procedure btnbersihClick(Sender: TObject);
    procedure cbbjenjangKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_trans_proseswp: Tf_trans_proseswp;
  a,b,c, jml_kriteria :Integer;
  nilai_s : array[1..1000] of Real;
  nilai_v : array[1..1000] of real;
  hasil_s, hasil_v, nil_wp : real;

implementation

uses
  u_dm, DB;

{$R *.dfm}

procedure Tf_trans_proseswp.btnkeluarClick(Sender: TObject);
begin
 Close;
end;

procedure Tf_trans_proseswp.FormShow(Sender: TObject);
begin
 edttahun.Text:=FormatDateTime('yyyy',Now); edttahun.Enabled:=True;
 cbbjenjang.Text:=''; cbbjenjang.Enabled:=True;

 btnproses.Enabled:=True;
 btnbersih.Enabled:=false;
 btnkeluar.Enabled:=True;

 with dm.qry_tampil_hasil do
   begin
    close;
    SQL.Clear;
    SQL.Add('select a.kd_proses, a.tahun, b.npsp, b.nm_sekolah, b.kec, a.jenj, a.nilai_wp from tbl_rangking a, tbl_sekolah b where a.npsp=b.npsp');
    sql.add('and a.tahun='+QuotedStr('kosong')+'');
    Open;
    edtjml_data.Text:=IntToStr(RecordCount);
   end;
end;

procedure Tf_trans_proseswp.edttahunKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (Key in ['0'..'9',#13,#8,#9]) then Key:=#0;
end;

procedure Tf_trans_proseswp.btnprosesClick(Sender: TObject);
begin
 if (edttahun.Text='') then
  begin
    MessageDlg('Tahun Wajib Diisi',mtInformation,[mbok],0);
    Exit;
  end;

 with dm.qry_rangking do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_rangking where tahun='+QuotedStr(edttahun.Text)+'';
    Open;
    if IsEmpty then
     begin
       MessageDlg('Data Pada Tahun Ini Tidak Ada',mtInformation,[mbOK],0);
       Exit;
     end
     else
     begin
       hasil_v:=0;
       for a:=1 to RecordCount do
        begin
          RecNo:=a;
          with dm.qry_bantu_penilaian do
           begin
             Close;
             SQL.Clear;
             SQL.Text:='select * from tbl_bantu_nilai where kd_proses='+QuotedStr(dm.qry_rangking.fieldbyname('kd_proses').AsString)+'';
             Open;
             hasil_s:=1;
             for b:=1 to RecordCount do
              begin
                RecNo:=b;

                with dm.qry_bobot do
                 begin
                   Close;
                   SQL.Clear;
                   SQL.Text:='select * from tbl_bobot where kd_kriteria='+QuotedStr(dm.qry_bantu_penilaian.fieldbyname('kd_kriteria').AsString)+'';
                   Open;

                   for c:=1 to RecordCount do
                    begin
                      RecNo:=c;

                      nilai_s[c]:=Power(dm.qry_bantu_penilaian.fieldbyname('nilai').AsVariant,(fieldbyname('bobot').AsVariant/fieldbyname('jumlah').AsVariant));
                      hasil_s:=hasil_s*nilai_s[c];

                    end;
                    c:=c+1;
                 end;
              end;
              b:=b+1;
           end;
           nilai_v[a]:=hasil_s;
           hasil_v:=hasil_v+nilai_v[a];

           Edit;
           FieldByName('nilai_s').AsVariant:=Format('%.4f',[hasil_s]);
           Post;
        end;
        a:=a+1;

        nil_wp:=0;
        close;
        SQL.Clear;
        SQL.Text:='select * from tbl_rangking where tahun='+QuotedStr(edttahun.Text)+'';
        Open;
        for a:=1 to RecordCount do
         begin
           RecNo:=a;
           nil_wp:=nilai_v[a]/hasil_v;

           Edit;
           FieldByName('nilai_v').AsVariant:=Format('%.4f',[hasil_v]);
           FieldByName('nilai_wp').AsVariant:=Format('%.4f',[nil_wp]);
           Post;
         end;
         a:=a+1;

        //tampilkan data
        with dm.qry_tampil_hasil do
         begin
           close;
           SQL.Clear;
           SQL.Add('select a.kd_proses, a.tahun, b.npsp, b.nm_sekolah, b.kec, a.jenj, a.nilai_s, a.nilai_v, a.nilai_wp from tbl_rangking a, tbl_sekolah b where a.npsp=b.npsp');
           sql.add('and a.tahun='+QuotedStr(edttahun.Text)+' order by a.nilai_wp desc');
           Open;
           edtjml_data.Text:=IntToStr(RecordCount);
         end;
         MessageDlg('Proses Perhitungan Selesai',mtInformation,[mbOK],0);
         btnproses.Enabled:=false;
         btnbersih.Enabled:=True;
         btnkeluar.Enabled:=false;
         edttahun.Enabled:=false;
         cbbjenjang.Enabled:=false;
     end;
  end;
end;

procedure Tf_trans_proseswp.btnbersihClick(Sender: TObject);
begin
 FormShow(Sender);
end;

procedure Tf_trans_proseswp.cbbjenjangKeyPress(Sender: TObject;
  var Key: Char);
begin
 Key:=#0;
end;

end.
