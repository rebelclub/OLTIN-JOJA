program adminka;

uses
  Vcl.Forms,
  uadmmain in 'uadmmain.pas' {formMain},
  uadmdb in 'uadmdb.pas' {dm: TDataModule},
  uadmpassw in 'uadmpassw.pas' {passwForm},
  uadmconsts in 'uadmconsts.pas',
  uadmusers in 'uadmusers.pas' {usersForm},
  uadmcudausers in 'uadmcudausers.pas' {userCUDAForm},
  uadmcabins in 'uadmcabins.pas' {cabinForm},
  uadmbluds in 'uadmbluds.pas' {bludsForm},
  uadmcudabluds in 'uadmcudabluds.pas' {cudaBludForm},
  uadmsells in 'uadmsells.pas' {sellForm},
  uadmprnt in 'uadmprnt.pas' {prnForm},
  uadmcudaprn in 'uadmcudaprn.pas' {prnCUDAForm},
  uadmprnform in 'uadmprnform.pas' {prnOrderForm},
  uadmOtchets in 'uadmOtchets.pas' {otchetForm},
  uadmreserv in 'uadmreserv.pas' {reservForm},
  uadmcudareserv in 'uadmcudareserv.pas' {cudaReservForm},
  uadmperenos in 'uadmperenos.pas' {perenosForm},
  unlockform in 'unlockform.pas' {AdminPassForm},
  planshetform in 'planshetform.pas' {Form2},
  uadmOtchets2 in 'uadmOtchets2.pas' {otchetForm2},
  uadmhelp in 'uadmhelp.pas' {helpForm},
  previnst in 'previnst.pas',
  uDaemon in 'uDaemon.pas' {serverForm},
  _activation in '_activation.pas' {FormRegistration},
  uadmunlock2 in 'uadmunlock2.pas' {Form1},
  uadmON_OFF in 'uadmON_OFF.pas' {FormON_OFF},
  VolSN in 'VolSN.pas',
  Ostats in 'Ostats.pas' {FormOstats};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TpasswForm, passwForm);
  Application.CreateForm(TusersForm, usersForm);
  Application.CreateForm(TuserCUDAForm, userCUDAForm);
  Application.CreateForm(TcabinForm, cabinForm);
  Application.CreateForm(TbludsForm, bludsForm);
  Application.CreateForm(TcudaBludForm, cudaBludForm);
  Application.CreateForm(TsellForm, sellForm);
  Application.CreateForm(TprnForm, prnForm);
  Application.CreateForm(TprnCUDAForm, prnCUDAForm);
  Application.CreateForm(TprnOrderForm, prnOrderForm);
  Application.CreateForm(TotchetForm, otchetForm);
  Application.CreateForm(TreservForm, reservForm);
  Application.CreateForm(TcudaReservForm, cudaReservForm);
  Application.CreateForm(TperenosForm, perenosForm);
  Application.CreateForm(TAdminPassForm, AdminPassForm);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TotchetForm2, otchetForm2);
  Application.CreateForm(ThelpForm, helpForm);
  Application.CreateForm(TserverForm, serverForm);
  Application.CreateForm(TFormRegistration, FormRegistration);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormON_OFF, FormON_OFF);
  Application.CreateForm(TFormOstats, FormOstats);
  Application.Run;
end.
