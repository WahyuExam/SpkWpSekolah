unit u_report_rang;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, jpeg;

type
  Treport_rangking = class(TQuickRep)
    qrbndDetailBand1: TQRBand;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    qrbndColumnHeaderBand1: TQRBand;
    qrlbl5: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    QRShape10: TQRShape;
    qrlbl10: TQRLabel;
    qrlbl_bln: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    qrlbl12: TQRLabel;
    qrbndTitleBand1: TQRBand;
    QRShape1: TQRShape;
    qrlbl13: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbltahun: TQRLabel;
    QRImage1: TQRImage;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    QRImage2: TQRImage;
    qrlbl11: TQRLabel;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    qrlbl14: TQRLabel;
    qrlbl16: TQRLabel;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRDBText8: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText9: TQRDBText;
  private

  public

  end;

var
  report_rangking: Treport_rangking;

implementation

uses
  u_dm;

{$R *.DFM}

end.
