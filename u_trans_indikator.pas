unit u_trans_indikator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, DBCtrls, jpeg, ExtCtrls;

type
  Tf_trans_indikator = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    grp2: TGroupBox;
    grp3: TGroupBox;
    btn_campur: TBitBtn;
    btn_ubah: TBitBtn;
    btn_simpan: TBitBtn;
    btn_hapus: TBitBtn;
    btn_keluar: TBitBtn;
    grp5: TGroupBox;
    dbgrd1: TDBGrid;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    edt_kriteria: TEdit;
    mmonilai_indi: TMemo;
    btnbantu: TBitBtn;
    dblkcbbsubkriteria: TDBLookupComboBox;
    cbbnilai: TComboBox;
    btntambahindi: TBitBtn;
    btnbatalindikator: TBitBtn;
    img1: TImage;
    procedure btn_keluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnbantuClick(Sender: TObject);
    procedure btn_campurClick(Sender: TObject);
    procedure btn_simpanClick(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure btntambahindiClick(Sender: TObject);
    procedure btnbatalindikatorClick(Sender: TObject);
    procedure btn_ubahClick(Sender: TObject);
    procedure btn_hapusClick(Sender: TObject);
    procedure cbbnilaiKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure tampil_data;
    procedure batal_ubah;
    procedure aktif_tombol_indi;
    procedure hilang_tombol_indi;
  end;

var
  f_trans_indikator: Tf_trans_indikator;
  kode, kd_sub_kriteria, kd_kriteria, kd_nil_indikator, status,
  nm_indi_lama, nil_indi_lama, status_btl : string;

implementation

uses
  u_dm, ADODB, u_bantu_kriteria, DB, StrUtils;

{$R *.dfm}

procedure Tf_trans_indikator.btn_keluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_trans_indikator.FormShow(Sender: TObject);
begin
 btnbantu.Enabled:=True;
 edt_kriteria.Enabled:= false; edt_kriteria.Clear;
 dblkcbbsubkriteria.Enabled:=False; dblkcbbsubkriteria.KeyValue:=null;
 mmonilai_indi.Enabled:=false; mmonilai_indi.Clear;
 cbbnilai.Enabled:=false; cbbnilai.Text:='';

 dbgrd1.Enabled:=false;

 btn_campur.Enabled:=True; btn_campur.Caption:='Tambah';
 btn_simpan.Enabled:=false; btn_simpan.Caption:='Simpan';
 btn_ubah.Enabled:=False;
 btn_hapus.Enabled:=false;
 btn_keluar.Enabled:=True;

 with dm.qry_tampil_indikator_penilaian do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select a.kd_nil_indi, b.kd_sub_kriteria, c.kd_kriteria, c.kriteria, b.sub_kriteria, a.nm_indi,');
    SQL.Add('a.nil_indi from tbl_nil_indikator a, tbl_sub_kriteria b, tbl_kriteria c where a.kd_sub_kriteria=b.kd_sub_kriteria');
    SQL.Add('and b.kd_kriteria=c.kd_kriteria and c.kd_kriteria='+QuotedStr('kosong')+'');
    Open;
  end;

  btntambahindi.Visible:=False;
  btnbatalindikator.Visible:=false;

end;

procedure Tf_trans_indikator.btnbantuClick(Sender: TObject);
begin
 f_bantu_kriteria.edtket.Text:='trans_indi';
 f_bantu_kriteria.ShowModal;
end;

procedure Tf_trans_indikator.btn_campurClick(Sender: TObject);
begin
 if btn_campur.Caption='Tambah' then
  begin
    if edt_kriteria.Text='' then
     begin
       MessageDlg('Kriteria Belum Dipilih',mtInformation,[mbok],0);
       Exit;
     end;

    if dblkcbbsubkriteria.KeyValue=null then
     begin
       MessageDlg('Sub Kriteria Belum Dipilih',mtInformation,[mbOK],0);
       Exit;
     end;

     edt_kriteria.Enabled:=False;
     dblkcbbsubkriteria.Enabled:=False;
     mmonilai_indi.Enabled:=True; mmonilai_indi.SetFocus;
     cbbnilai.Enabled:=True;
     tampil_data;
 
     btn_campur.Caption:='Batal';
     btn_simpan.Caption:='Simpan'; btn_simpan.Enabled:=True;
     btn_ubah.Enabled:=False;
     btn_hapus.Enabled:=false;
     btn_keluar.Enabled:=false;
     status:='simpan';
     dbgrd1.Enabled:=True;
     status_btl:='batal';
     btnbantu.Enabled:=false;
  end
  else
 if btn_campur.Caption='Batal' then
  begin
    if status_btl='batal' then FormShow(Sender) else
    if status_btl='batal_ubah' then
     begin
      batal_ubah;
      aktif_tombol_indi;
     end;
  end;
end;

procedure Tf_trans_indikator.tampil_data;
begin
  with dm.qry_tampil_indikator_penilaian do
   begin
    DisableControls;
    Close;
    SQL.Clear;
    SQL.Add('select a.kd_nil_indi, b.kd_sub_kriteria, c.kd_kriteria, c.kriteria, b.sub_kriteria, a.nm_indi,');
    SQL.Add('a.nil_indi from tbl_nil_indikator a, tbl_sub_kriteria b, tbl_kriteria c where a.kd_sub_kriteria=b.kd_sub_kriteria');
    SQL.Add('and b.kd_kriteria=c.kd_kriteria and b.kd_sub_kriteria='+QuotedStr(dblkcbbsubkriteria.KeyValue)+'');
    Open;
    EnableControls
   end;
end;

procedure Tf_trans_indikator.btn_simpanClick(Sender: TObject);
begin
 if btn_simpan.Caption='Simpan' then
  begin
   if (mmonilai_indi.Text='') or (cbbnilai.Text='') then
    begin
      MessageDlg('Semua Data Wajib Diisi',mtInformation,[mbok],0);
      if Trim(mmonilai_indi.Text)='' then
       begin
         mmonilai_indi.SetFocus;
         Exit;
       end;

      if cbbnilai.Text='' then
       begin
         cbbnilai.SetFocus;
         Exit;
       end;
      Exit;
    end;

    with dm.qry_indikator_penilaian do
     begin
      if status='simpan' then
        begin
          if Locate('kd_sub_kriteria;nm_indi',VarArrayOf([dblkcbbsubkriteria.KeyValue,mmonilai_indi.Text]),[]) then
           begin
             MessageDlg('Indikator Pada Sub Kriteria Ini Sudah Ada',mtInformation,[mbok],0);
             mmonilai_indi.SetFocus;
             Exit;
           end;

          if Locate('kd_sub_kriteria;nil_indi',VarArrayOf([dblkcbbsubkriteria.KeyValue,cbbnilai.Text]),[]) then
           begin
             MessageDlg('Nilai Indikator Pada Sub Kriteria Ini Sudah Ada',mtInformation,[mbok],0);
             cbbnilai.SetFocus;
             Exit;
           end;

          with dm.qry_indikator_penilaian do
           begin
            close;
            SQL.Clear;
            SQL.Text:='select * from tbl_nil_indikator order by kd_nil_indi asc';
            Open;
            if IsEmpty then kode:='001' else
             begin
              Last;
              kode := RightStr(fieldbyname('kd_nil_indi').AsString,3);
              kode := IntToStr(StrToInt(kode)+1);
             end;
            kd_nil_indikator := 'IND-'+Format('%.3d',[StrToInt(kode)]);
           end;

           Append;
           FieldByName('kd_nil_indi').AsString := kd_nil_indikator;
           FieldByName('kd_sub_kriteria').AsString := dblkcbbsubkriteria.KeyValue;
        end
        else
      if status='ubah' then
       begin
         ShowMessage(nm_indi_lama+''+nil_indi_lama+''+kd_nil_indikator);
         if (mmonilai_indi.Text=nm_indi_lama) and (cbbnilai.Text=nil_indi_lama) then
          begin
            batal_ubah;
            tampil_data;
            aktif_tombol_indi;
            Exit;
          end
          else
          begin
            if mmonilai_indi.Text<>nm_indi_lama then
             begin
               if Locate('kd_sub_kriteria;nm_indi',VarArrayOf([dblkcbbsubkriteria.KeyValue,mmonilai_indi.Text]),[]) then
                 begin
                   MessageDlg('Indikator Pada Sub Kriteria Ini Sudah Ada',mtInformation,[mbok],0);
                   mmonilai_indi.SetFocus;
                   Exit;
                 end;
             end;

            if cbbnilai.Text<>nil_indi_lama then
             begin
               if Locate('kd_sub_kriteria;nil_indi',VarArrayOf([dblkcbbsubkriteria.KeyValue,cbbnilai.Text]),[]) then
                begin
                 MessageDlg('Nilai Indikator Pada Sub Kriteria Ini Sudah Ada',mtInformation,[mbok],0);
                 cbbnilai.SetFocus;
                 Exit;
                end;
             end;

             if Locate('kd_nil_indi',kd_nil_indikator,[]) then Edit;
          end;
       end;

       FieldByName('nm_indi').AsString := mmonilai_indi.Text;
       FieldByName('nil_indi').AsString := cbbnilai.Text;
       Post;

       MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
       tampil_data;
       mmonilai_indi.Clear; mmonilai_indi.Enabled:=false;
       cbbnilai.Text:=''; cbbnilai.Enabled:=false;

       btn_simpan.Caption:='Selesai';
       btn_campur.Enabled:=false;

       aktif_tombol_indi;
     end;
  end
  else
 if btn_simpan.Caption='Selesai' then
  begin
    MessageDlg('Semua Data Sudah Disimpan',mtInformation,[mbOK],0);
    FormShow(Sender);
  end;
end;

procedure Tf_trans_indikator.dbgrd1DblClick(Sender: TObject);
begin
 nm_indi_lama := dbgrd1.Fields[5].AsString;
 if nm_indi_lama='' then Exit;

 nil_indi_lama := dbgrd1.Fields[6].AsString;
 kd_nil_indikator := dbgrd1.Fields[0].AsString;

 mmonilai_indi.Text:= dbgrd1.Fields[5].AsString;
 cbbnilai.Text:= dbgrd1.Fields[6].AsString;

 status_btl:='batal_ubah';
 btn_campur.Enabled:=True; btn_campur.Caption:='Batal';


 mmonilai_indi.Enabled:=False;
 cbbnilai.Enabled:=false;
 btn_simpan.Enabled:=false;
 btn_ubah.Enabled:=True;
 btn_hapus.Enabled:=True;

 hilang_tombol_indi;
end;

procedure Tf_trans_indikator.btntambahindiClick(Sender: TObject);
begin
 mmonilai_indi.Enabled:=True; mmonilai_indi.SetFocus;
 cbbnilai.Enabled:=True;
 btn_simpan.Caption:='Simpan';
 status:='simpan';

 btntambahindi.Enabled:=false;
 btnbatalindikator.Enabled:=True;
end;

procedure Tf_trans_indikator.btnbatalindikatorClick(Sender: TObject);
begin
 mmonilai_indi.Clear; mmonilai_indi.Enabled:=false;
 cbbnilai.Text:=''; cbbnilai.Enabled:=false;

 btntambahindi.Enabled:=True;
 btnbatalindikator.Enabled:=false;
 btn_simpan.Caption:='Selesai';
end;

procedure Tf_trans_indikator.btn_ubahClick(Sender: TObject);
begin
 status_btl:='batal_ubah';
 status:='ubah';
 btn_ubah.Enabled:=false;
 btn_hapus.Enabled:=false;
 btn_simpan.Enabled:=True; btn_simpan.Caption:='Simpan';

 mmonilai_indi.Enabled:=True; mmonilai_indi.SetFocus;
 cbbnilai.Enabled:=True;
end;

procedure Tf_trans_indikator.batal_ubah;
begin
 btnbatalindikator.Click;
 status_btl:='batal';
 btn_simpan.Enabled:=True;
 btn_ubah.Enabled:=False;
 btn_hapus.Enabled:=False;
 btn_campur.Enabled:=False;
end;

procedure Tf_trans_indikator.btn_hapusClick(Sender: TObject);
begin
 if MessageDlg('Yakin Data Akan Dihapus?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
   if dm.qry_indikator_penilaian.Locate('kd_nil_indi',kd_nil_indikator,[]) then
    begin
      dm.qry_indikator_penilaian.Delete;
      batal_ubah;
      tampil_data;
      aktif_tombol_indi;
      MessageDlg('Data Sudah Dihapus',mtInformation,[mbok],0);
    end;
  end;
end;

procedure Tf_trans_indikator.aktif_tombol_indi;
begin
 btntambahindi.Visible:=True; btntambahindi.Enabled:=True;
 btnbatalindikator.Visible:=True; btnbatalindikator.Enabled:=False;
end;

procedure Tf_trans_indikator.hilang_tombol_indi;
begin
 btntambahindi.Visible:=false;
 btnbatalindikator.Visible:=false;
end;

procedure Tf_trans_indikator.cbbnilaiKeyPress(Sender: TObject;
  var Key: Char);
begin
 key:=#0;
end;

end.
