unit u_trans_penilaian;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, Grids, DBGrids, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_trans_nilai_sekolah = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    grp2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edttahun: TEdit;
    edtsekolah: TEdit;
    grp3: TGroupBox;
    btnbantusekolah: TBitBtn;
    dbgrd1: TDBGrid;
    grp4: TGroupBox;
    btn_campur: TBitBtn;
    btn_simpan: TBitBtn;
    btn_keluar: TBitBtn;
    btn_hapus: TBitBtn;
    grp6: TGroupBox;
    dblkcbbpenilaian: TDBLookupComboBox;
    edtnilai: TEdit;
    Label4: TLabel;
    Label6: TLabel;
    edtsubkriteria: TEdit;
    grp5: TGroupBox;
    dbgrd2: TDBGrid;
    btnulang: TBitBtn;
    btnset: TBitBtn;
    img1: TImage;
    cbbjenjang: TComboBox;
    Label5: TLabel;
    Label7: TLabel;
    edtkec: TEdit;
    procedure btn_keluarClick(Sender: TObject);
    procedure btn_campurClick(Sender: TObject);
    procedure btnbantukriteriaClick(Sender: TObject);
    procedure edttahunKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnbantusekolahClick(Sender: TObject);
    procedure dblkcbbpenilaianCloseUp(Sender: TObject);
    procedure dbgrd2CellClick(Column: TColumn);
    procedure dbgrd2DblClick(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure btnulangClick(Sender: TObject);
    procedure btnsetClick(Sender: TObject);
    procedure btn_simpanClick(Sender: TObject);
    procedure btn_hapusClick(Sender: TObject);
    procedure edttahunClick(Sender: TObject);
    procedure cbbjenjangClick(Sender: TObject);
    procedure cbbjenjangKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure update_data_bantu;
    procedure tampil_db;
    procedure isi_sub;
    procedure kejadian_simpan;
    procedure tombol_ulang;
  end;

var
  f_trans_nilai_sekolah: Tf_trans_nilai_sekolah;
  a, nilai : Integer;
  kode, kd_proses, npsp, kode_kriteria, status, kd_sub_kriteria, status_btl, jenj : string;
  ada : Boolean;

implementation

uses
  u_dm, StrUtils, DB, u_bantu_kriteria, u_bantu_sekolah, ADODB;

{$R *.dfm}

procedure Tf_trans_nilai_sekolah.btn_keluarClick(Sender: TObject);
begin
 Close;
end;

procedure Tf_trans_nilai_sekolah.btn_campurClick(Sender: TObject);
begin
 if btn_campur.Caption='Tambah' then
  begin
   if (edttahun.Text='') or (edtsekolah.Text='') then
    begin
      MessageDlg('Semua Data Wajib Diisi',mtInformation,[mbok],0);
      if Trim(edttahun.Text)='' then
       begin
         edttahun.SetFocus;
       end;

      if edtsekolah.Text='' then
       begin
         btnbantusekolah.SetFocus;
       end;
      Exit;
    end;

   with dm.qry_rangking do
    begin
      close;
      SQL.Clear;
      SQL.Text:='select * from tbl_rangking';
      Open;
      if Locate('tahun;npsp',VarArrayOf([edttahun.Text,npsp]),[]) then
       begin
         MessageDlg('Sekolah ini Sudah Dinilai Pada Tahun ini ', mtInformation,[mbOK],0);
         dbgrd1.Enabled:=False;
         dbgrd2.Enabled:=False;

         btn_campur.Caption:='Ubah';
         btn_simpan.Enabled:=false;
         btn_hapus.Enabled:=True;
         btn_keluar.Enabled:=false;

         kd_proses:=dm.qry_rangking.fieldbyname('kd_proses').AsString;

         with dm.qry_kriteria do
          begin
           Close;
           SQL.Clear;
           SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
           Open;
          end;
          Exit;
       end
       else
       begin
         Close;
         SQL.Clear;
         SQL.Text:='select * from tbl_rangking order by kd_proses asc';
         Open;
         if IsEmpty then kode:='001' else
           begin
            Last;
            kode := RightStr(fieldbyname('kd_proses').AsString,3);
            kode := IntToStr(StrToInt(kode)+1);
           end;
         kd_proses := 'PR-'+Format('%.3d',[StrToInt(kode)]);

        Append;
        FieldByName('kd_proses').AsString:=kd_proses;
        FieldByName('tahun').AsString:=edttahun.Text;
        FieldByName('npsp').AsString:=npsp;
        FieldByName('jenj').AsString:=jenj;
        Post;

        with dm.qry_kriteria do
         begin
          Close;
          SQL.Clear;
          SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
          Open;
          for a:=1 to RecordCount do
           begin
            RecNo:=a;

            with dm.qry_bantu_penilaian do
             begin
               Append;
               FieldByName('kd_proses').AsString:=kd_proses;
               FieldByName('kd_kriteria').AsString:=dm.qry_kriteria.fieldbyname('kd_kriteria').AsString;
               Post;
             end;
           end;
          a:=a+1;
          First;
         end;

        with dm.qry_subkriteria do
         begin
           close;
           SQL.Clear;
           SQL.Text:='select * from tbl_sub_kriteria order by kd_sub_kriteria asc';
           Open;
           for a:=1 to RecordCount do
            begin
              RecNo:=a;

              with dm.qry_nilai_sekolah do
               begin
                 Append;
                 FieldByName('kd_proses').AsString:=kd_proses;
                 FieldByName('kd_sub_kriteria').AsString:=dm.qry_subkriteria.fieldbyname('kd_sub_kriteria').AsString;
                 Post;
               end;
            end;
         end;
         dbgrd2.Enabled:=True;
       end;
    end;

    btn_campur.Caption:='Batal';
    btn_simpan.Enabled:=True; btn_simpan.Caption:='Simpan';
    btn_hapus.Enabled:=false;
    btn_keluar.Enabled:=False;

    edttahun.Enabled:=false;
    edtsekolah.Enabled:=false;
    btnbantusekolah.Enabled:=false;
    //cbbjenjang.Enabled:=false;
    edtkec.Enabled:=false;

    status:='simpan';
    status_btl := 'batal';
  end
  else
 if btn_campur.Caption='Batal' then
  begin
    if status_btl='batal' then
     begin
       with dm.qry_rangking do
        begin
         Close;
         SQL.Clear;
         SQL.Text:='delete from tbl_rangking where kd_proses='+QuotedStr(kd_proses)+'';
         ExecSQL;
        end;
     FormShow(Sender);
     end
     else
    if status_btl='batal_ubah' then
     begin
       FormShow(Sender);
     end;
  end
  else
 if btn_campur.Caption='Ubah' then
  begin
    btnbantusekolah.Enabled:=false;
    dbgrd2.Enabled:=True;
    btn_campur.Enabled:=True;
    btn_simpan.Enabled:=False;
    btn_hapus.Enabled:=false;
    btn_keluar.Enabled:=false;
    status_btl:='batal_ubah';
    btn_campur.Caption:='Batal';
  end;
end;

procedure Tf_trans_nilai_sekolah.btnbantukriteriaClick(Sender: TObject);
begin
 f_bantu_kriteria.edtket.Text:='trans_nilai';
 f_bantu_kriteria.ShowModal;
end;

procedure Tf_trans_nilai_sekolah.edttahunKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (key in ['0'..'9',#8,#9,#13]) then Key:=#0;
 if Key=#13 then btnbantusekolah.SetFocus;
end;

procedure Tf_trans_nilai_sekolah.FormShow(Sender: TObject);
begin
 edttahun.Text:=FormatDateTime('yyyy',Now); edttahun.Enabled:=True;
 edtsekolah.Clear; edtsekolah.Enabled:=false;
 btnbantusekolah.Enabled:=True;
 //cbbjenjang.Enabled:=True; cbbjenjang.Text:='';
 edtkec.Clear; edtkec.Enabled:=false;

 dbgrd1.Enabled:=false;
 dbgrd2.Enabled:=false;

 edtsekolah.Enabled:=false; edtsubkriteria.Clear;
 dblkcbbpenilaian.Enabled:=false; dblkcbbpenilaian.KeyValue:=null;
 edtnilai.Enabled:=false; edtnilai.Clear;
 btnset.Enabled:=false;
 btnulang.Enabled:=false;


 btn_campur.Enabled:=True; btn_campur.Caption:='Tambah';
 btn_simpan.Enabled:=false; btn_simpan.Caption:='Simpan';
 //btn_ubah.Enabled:=false;
 btn_hapus.Enabled:=false;
 btn_keluar.Enabled:=True;

 with dm.qry_tampil_bantu_penilaian do
  begin
    close;
    SQL.Clear;
    sql.Add('select a.kd_proses, b.kd_sub_kriteria, b.sub_kriteria, a.nm_indi, a.nil_indi, a.kd_nil_indi, c.kd_kriteria,');
    sql.Add('c.kriteria from tbl_nil_sek a, tbl_sub_kriteria b, tbl_kriteria c where a.kd_sub_kriteria=b.kd_sub_kriteria');
    sql.Add('and b.kd_kriteria=c.kd_kriteria');
    SQL.Add('and c.kd_kriteria='+QuotedStr('kosong')+'');
    Open;
  end;

 with dm.qry_kriteria do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_kriteria where kd_kriteria='+QuotedStr('kosong')+'';
    open;
  end;
end;

procedure Tf_trans_nilai_sekolah.btnbantusekolahClick(Sender: TObject);
begin
  with dm.qry_sekolah do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_sekolah';
    Open;
    if IsEmpty then
     begin
       MessageDlg('Tidak ada Penilaian Sekolah Pada Tahun ini',mtInformation,[mbOK],0);
       Exit;
     end
     else f_bantu_sekolah.ShowModal;
  end;
end;

procedure Tf_trans_nilai_sekolah.dblkcbbpenilaianCloseUp(Sender: TObject);
begin
 if dblkcbbpenilaian.KeyValue=null then Exit else
  begin
    with dm.qry_indikator_penilaian do
     begin
      if Locate('kd_nil_indi',dblkcbbpenilaian.KeyValue,[]) then edtnilai.Text:=FieldByName('nil_indi').AsString;
     end;
  end;
end;

procedure Tf_trans_nilai_sekolah.update_data_bantu;
begin
 //update nilai bantu
  kd_sub_kriteria:= dbgrd1.Fields[1].AsString;
  with dm.qry_tampil_bantu_penilaian do
   begin
    close;
    SQL.Clear;
    sql.Add('select a.kd_proses, b.kd_sub_kriteria, b.sub_kriteria, a.nm_indi, a.nil_indi, a.kd_nil_indi, c.kd_kriteria,');
    sql.Add('c.kriteria from tbl_nil_sek a, tbl_sub_kriteria b, tbl_kriteria c  where a.kd_sub_kriteria=b.kd_sub_kriteria');
    sql.Add('and b.kd_kriteria=c.kd_kriteria');
    SQL.Add('and a.kd_proses='+QuotedStr(kd_proses)+' and c.kd_kriteria='+QuotedStr(dbgrd2.Fields[0].AsString)+'');
    Open;

    nilai:=0;
    for a:=1 to RecordCount do
     begin
      RecNo:=a;
      nilai:=nilai+fieldbyname('nil_indi').AsInteger;
     end;
     a:=a+1;
   end;

  with dm.qry_bantu_penilaian do
   begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_bantu_nilai';
    Open;

    if Locate('kd_proses;kd_kriteria',VarArrayOf([kd_proses,dbgrd2.Fields[0].AsString]),[]) then
      begin
        Edit;
        FieldByName('nilai').AsString:=IntToStr(nilai);
        Post;
      end;
   end;
end;

procedure Tf_trans_nilai_sekolah.tampil_db;
begin
 with dm.qry_tampil_bantu_penilaian do
  begin
    Close;
    sql.Clear;
    SQL.Add('select distinct a.kd_proses, b.kd_kriteria, b.kriteria, c.kd_sub_kriteria, c.sub_kriteria, a.nilai,');
    SQL.Add('a.ket from tbl_bantu_nilai a, tbl_kriteria b, tbl_sub_kriteria c where a.kd_kriteria=b.kd_kriteria and');
    SQL.Add('c.kd_kriteria=b.kd_kriteria and b.kd_kriteria='+QuotedStr(kode_kriteria)+' and a.kd_proses='+QuotedStr(kd_proses)+'');
    Open;
  end;
end;

procedure Tf_trans_nilai_sekolah.isi_sub;
begin
 with dm.qry_tampil_bantu_penilaian do
  begin
    close;
    SQL.Clear;
    sql.Add('select a.kd_proses, b.kd_sub_kriteria, b.sub_kriteria, a.nm_indi, a.nil_indi, a.kd_nil_indi, c.kd_kriteria,');
    sql.Add('c.kriteria from tbl_nil_sek a, tbl_sub_kriteria b, tbl_kriteria c  where a.kd_sub_kriteria=b.kd_sub_kriteria');
    sql.Add('and b.kd_kriteria=c.kd_kriteria');
    SQL.Add('and a.kd_proses='+QuotedStr(kd_proses)+' and c.kd_kriteria='+QuotedStr(dbgrd2.Fields[0].AsString)+'');
    Open;

    ada:=False;
    for a:=1 to RecordCount do
     begin
       RecNo:=a;
       if FieldByName('nil_indi').AsString='' then ada:=True;
     end;
     a:=a+1;

    if ada=True then
     begin
      dbgrd2.Enabled:=False;
     end
     else
     begin
       dbgrd2.Enabled:=True;
     end;
      dbgrd1.Enabled:=True;
  end;
end;

procedure Tf_trans_nilai_sekolah.dbgrd2CellClick(Column: TColumn);
begin
 dbgrd1.Enabled:=false;
 with dm.qry_tampil_bantu_penilaian do
  begin
    close;
    SQL.Clear;
    SQL.Add('select a.kd_proses, b.kd_sub_kriteria, b.sub_kriteria, a.nm_indi, a.nil_indi, a.kd_nil_indi, c.kd_kriteria,');
    SQL.Add('c.kriteria from tbl_nil_sek a, tbl_sub_kriteria b, tbl_kriteria c  where a.kd_sub_kriteria=b.kd_sub_kriteria');
    SQL.Add('and b.kd_kriteria=c.kd_kriteria');
    SQL.Add('and a.kd_proses='+QuotedStr(kd_proses)+' and c.kd_kriteria='+QuotedStr(dbgrd2.Fields[0].AsString)+'');
    Open;
  end;
end;

procedure Tf_trans_nilai_sekolah.dbgrd2DblClick(Sender: TObject);
begin
 if dm.qry_tampil_bantu_penilaian.RecordCount > 1 then
  begin
    dbgrd2.Enabled:=False;
    dbgrd1.Enabled:=True;
    dblkcbbpenilaian.Enabled:=False;
    edtsubkriteria.Clear;
  end
  else
  dbgrd1.OnDblClick(Sender);
end;

procedure Tf_trans_nilai_sekolah.dbgrd1DblClick(Sender: TObject);
begin
 with dm.qry_indikator_penilaian do
  begin
   close;
   SQL.Clear;
   SQL.Text:='select * from tbl_nil_indikator where kd_sub_kriteria='+QuotedStr(dbgrd1.Fields[1].AsString)+'';
   Open;
  end;

 if dbgrd1.Fields[4].AsString <> '' then
  begin
    MessageDlg('Kriteria Sudah Dinilai',mtInformation,[mbok],0);
    if MessageDlg('Apakah Ingin Melakukan Perubahan Nilai?',mtConfirmation,[mbYes,mbNo],0)=mryes then
     begin
       if dm.qry_tampil_bantu_penilaian.RecordCount=1 then
        begin
          dbgrd2.Enabled:=false;
          dbgrd1.Enabled:=false;

          dblkcbbpenilaian.KeyValue:=dbgrd1.Fields[5].AsString;
          edtnilai.Text:=dbgrd1.Fields[4].AsString;
        end
        else
        begin
          dbgrd1.Enabled:=True; dbgrd2.Enabled:=False; dbgrd1.SetFocus;
        end;

        edtsubkriteria.Text:=dbgrd1.Fields[2].AsString;
        dblkcbbpenilaian.Enabled:=True;
        kejadian_simpan;
     end
  end
  else
  begin
   if dm.qry_tampil_bantu_penilaian.RecordCount=1 then
    begin
     dbgrd2.Enabled:=false;
     dbgrd1.Enabled:=false;
    end
   else
    begin
     dbgrd1.Enabled:=True; dbgrd2.Enabled:=False;
    end;

    edtsubkriteria.Text:=dbgrd1.Fields[2].AsString;
    dblkcbbpenilaian.Enabled:=True;
    kejadian_simpan;
  end;
end;

procedure Tf_trans_nilai_sekolah.kejadian_simpan;
begin
 btn_campur.Enabled:=false;
 btn_simpan.Enabled:=false;

 btnset.Enabled:=True;
 btnulang.Enabled:=True;
end;

procedure Tf_trans_nilai_sekolah.btnulangClick(Sender: TObject);
begin
 if dm.qry_tampil_bantu_penilaian.RecordCount = 1 then
  begin
    dbgrd2.Enabled:=True; dbgrd2.SetFocus;
    dbgrd1.Enabled:=false;
  end
  else
  begin
    dbgrd2.Enabled:=false;
    dbgrd1.Enabled:=True; dbgrd1.SetFocus;
  end;

 tombol_ulang;
 if status_btl='batal_ubah' then btn_simpan.Enabled:=False;
end;

procedure Tf_trans_nilai_sekolah.btnsetClick(Sender: TObject);
begin
 if dblkcbbpenilaian.KeyValue=null then
  begin
   MessageDlg('Penilaian Belum Diisi',mtInformation,[mbok],0);
   Exit;
  end;

  //simpan ke nil sekolah
 with dm.qry_nilai_sekolah do
  begin
   close;
   SQL.Clear;
   SQL.Text:='select * from tbl_nil_sek';
   Open;

   if Locate('kd_proses;kd_sub_kriteria',VarArrayOf([kd_proses,dbgrd1.Fields[1].AsString]),[]) then
     begin
      Edit;
      FieldByName('kd_nil_indi').AsString:=dblkcbbpenilaian.KeyValue;
      FieldByName('nm_indi').AsString:=dblkcbbpenilaian.Text;
      dm.qry_indikator_penilaian.Locate('kd_nil_indi',dblkcbbpenilaian.KeyValue,[]);
      FieldByName('nil_indi').AsString:=dm.qry_indikator_penilaian.fieldbyname('nil_indi').AsString;
      Post;
     end;
  end;

  update_data_bantu;
  isi_sub;
  MessageDlg('Nilai Sudah Disimpan',mtInformation,[mbOK],0);

  edtsubkriteria.Clear;
  dblkcbbpenilaian.KeyValue:=null; edtnilai.Enabled:=false; edtnilai.Clear;
  dblkcbbpenilaian.Enabled:=false;
  tombol_ulang;
  if status_btl='batal_ubah' then
   begin
      btn_campur.Enabled:=false;
      btn_simpan.Enabled:=True;
   end;
end;

procedure Tf_trans_nilai_sekolah.tombol_ulang;
begin
  btn_simpan.Enabled:=True;
  btn_campur.Enabled:=True; btn_campur.Caption:='Batal';
  edtsubkriteria.Clear;
  dblkcbbpenilaian.Enabled:=false; edtnilai.Clear;
  dblkcbbpenilaian.KeyValue:=null;
  btnset.Enabled:=false;
  btnulang.Enabled:=false;
end;

procedure Tf_trans_nilai_sekolah.btn_simpanClick(Sender: TObject);
begin
 with dm.qry_nilai_sekolah do
  begin
    close;
    SQL.Clear;
    sql.Text:='select * from tbl_nil_sek where kd_proses='+QuotedStr(kd_proses)+'';
    Open;

    ada:=False;
    for a:=1 to RecordCount do
     begin
       RecNo:=a;
       if FieldByName('nil_indi').AsString='' then ada:=True;
     end;
     a:=a+1;

    if ada=True then
     begin
      MessageDlg('Semua Kriteria Harus Dinilai',mtInformation,[mbok],0);
      Exit;
     end
     else
     begin
       MessageDlg('Semua Penilaian Kriteria Sudah Disimpan',mtInformation,[mbok],0);
       FormShow(Sender);
       Exit;
     end;
  end;
end;

procedure Tf_trans_nilai_sekolah.btn_hapusClick(Sender: TObject);
begin
 if MessageDlg('Yakin Penilaian Akan Dihapus?',mtConfirmation,[mbYes,mbNo],0)=mryes then
  begin
    with dm.qry_rangking do
     begin
       Close;
       SQL.Clear;
       SQL.Text:='delete from tbl_rangking where kd_proses='+QuotedStr(kd_proses)+'';
       ExecSQL;
     end;
     MessageDlg('Data Sudah Dihapus',mtInformation,[mbOK],0);
     FormShow(Sender);
  end;
end;

procedure Tf_trans_nilai_sekolah.edttahunClick(Sender: TObject);
begin
 edtsekolah.Clear;
end;

procedure Tf_trans_nilai_sekolah.cbbjenjangClick(Sender: TObject);
begin
 edtsekolah.Clear;
end;

procedure Tf_trans_nilai_sekolah.cbbjenjangKeyPress(Sender: TObject;
  var Key: Char);
begin
 key:=#0;
end;

end.
