unit u_mast_bobot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_mast_bobot = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    grp2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edt_kriteria: TEdit;
    edt_bobot: TEdit;
    grp3: TGroupBox;
    btn_campur: TBitBtn;
    btn_simpan: TBitBtn;
    btn_keluar: TBitBtn;
    grp5: TGroupBox;
    dbgrd1: TDBGrid;
    Label4: TLabel;
    Label5: TLabel;
    edtjumlah: TEdit;
    Label6: TLabel;
    img1: TImage;
    Label7: TLabel;
    edtjml_data: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btn_keluarClick(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure btn_campurClick(Sender: TObject);
    procedure btn_simpanClick(Sender: TObject);
    procedure edt_bobotKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure tampil;
  end;

var
  f_mast_bobot: Tf_mast_bobot;
  bbt_awal, jml_skr : string;
  a : Integer;
  jml_bbt : Real;

implementation

uses
  u_dm;

{$R *.dfm}

procedure Tf_mast_bobot.FormShow(Sender: TObject);
begin
 edt_kriteria.Clear; edt_kriteria.Enabled:=false;
 edt_bobot.Clear; edt_bobot.Enabled:=false;
 edtjml_data.Enabled:=false;

 dbgrd1.Enabled:=True;
 btn_campur.Caption:='Ubah';
 btn_simpan.Enabled:=False;
 btn_keluar.Enabled:=True;

 edtjumlah.Enabled:=false;
 tampil;
end;

procedure Tf_mast_bobot.btn_keluarClick(Sender: TObject);
begin
 if StrToFloat(edtjumlah.Text) < 100 then
  begin
    MessageDlg('Anda Tidak Bisa Keluar Dari Form, Jumlah Bobot Harus 100%',mtWarning,[mbOK],0);
    Exit;
  end
  else close;
end;

procedure Tf_mast_bobot.dbgrd1DblClick(Sender: TObject);
begin
 edt_kriteria.Text:=dbgrd1.Fields[2].AsString;
 edt_bobot.Text:=dbgrd1.Fields[3].AsString;
 bbt_awal := edt_bobot.Text;
end;

procedure Tf_mast_bobot.btn_campurClick(Sender: TObject);
begin
 if btn_campur.Caption='Ubah' then
  begin
   if edt_kriteria.Text='' then
    begin
      MessageDlg('Pilih Data Yang Akan Diubah',mtInformation,[mbOK],0);
      Exit;
    end;

   btn_campur.Caption:='Batal';
   btn_simpan.Enabled:=True;
   btn_keluar.Enabled:=False;
   edt_bobot.Enabled:=True; edt_bobot.SetFocus;
  end
  else
 if btn_campur.Caption='Batal' then FormShow(Sender);
end;

procedure Tf_mast_bobot.btn_simpanClick(Sender: TObject);
begin
 if bbt_awal=edt_bobot.Text then FormShow(Sender) else
  begin
   jml_skr := FloatToStr(StrToFloat(edtjumlah.Text)-StrToFloat(bbt_awal)+StrToFloat(edt_bobot.Text));
   if StrToFloat(jml_skr)>100 then
    begin
      MessageDlg('Jumlah Bobot Tidak Boleh Melebihi 100 %',mtWarning,[mbok],0);
      edt_bobot.SetFocus;
      Exit;
    end
    else
    begin
      with dm.qry_bobot do
       begin
        if Locate('kd_bobot',dbgrd1.Fields[0].AsString,[]) then
         begin
           Edit;
           FieldByName('bobot').AsString := edt_bobot.Text;
           Post;

           FormShow(Sender);
           MessageDlg('Data Bobot Sudah Diubah',mtInformation,[mbOK],0);
           if StrToFloat(edtjumlah.Text) < 100 then
             begin
              MessageDlg('Jumlah Bobot Harus 100%',mtWarning,[mbOK],0);
             end
         end;
       end;
    end;
  end;
end;

procedure Tf_mast_bobot.tampil;
begin
 with dm.qry_tampil_bobot do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select a.kd_bobot, b.kd_kriteria, b.kriteria, a.bobot, a.jumlah from tbl_bobot a, tbl_kriteria b where a.kd_kriteria=b.kd_kriteria order by kd_bobot asc';
    Open;
    edtjml_data.Text:=IntToStr(RecordCount);
    jml_bbt:=0;
    for a:=1 to RecordCount do
     begin
       RecNo:=a;
       jml_bbt:=jml_bbt+fieldbyname('bobot').AsVariant;
     end;
     a:=a+1;
     First;
     edtjumlah.Text:=FloatToStr(jml_bbt);
  end;
end;

procedure Tf_mast_bobot.edt_bobotKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9',#8,#9,#13,'.']) then Key:=#0;
 if Key=#13 then btn_simpan.Click;
end;

end.
