unit u_report_indikator_nilai;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, jpeg, DB, ADODB;

type
  Trepor_indikator_nilai = class(TQuickRep)
    qry_lap_indi: TADOQuery;
    qrbndDetailBand1: TQRBand;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    qrbndTitleBand1: TQRBand;
    QRShape1: TQRShape;
    qrlbl5: TQRLabel;
    QRGroup2: TQRGroup;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    qrlbl7: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl22: TQRLabel;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    qrlbl27: TQRLabel;
    qrbnd1: TQRBand;
    QRShape10: TQRShape;
    qrbndSummaryBand1: TQRBand;
    qrlbl10: TQRLabel;
    qrlbl_bln: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    qrlbl12: TQRLabel;
    QRImage2: TQRImage;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    QRImage3: TQRImage;
    qrlbl11: TQRLabel;
  private

  public

  end;

var
  repor_indikator_nilai: Trepor_indikator_nilai;

implementation

uses
  u_dm;

{$R *.DFM}

end.
