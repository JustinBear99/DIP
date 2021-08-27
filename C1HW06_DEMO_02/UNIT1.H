//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
   TPageControl *PageControl1;
   TTabSheet *TabSheet1;
   TTabSheet *TabSheet2;
   TImage *origin;
   TImage *Simg;
   TGroupBox *GroupBox1;
   TButton *openbtn;
   TOpenDialog *OpenDialog1;
   TButton *Sbtn;
   TTabSheet *TabSheet3;
   TImage *Timg;
   TButton *Tbtn;
   TButton *Button1;
   TButton *Button2;
  TTabSheet *TabSheet4;
  TImage *Himg;
   TButton *Button3;
   TButton *Button4;
   TGroupBox *GroupBox2;
   TEdit *Edit5;
   TEdit *Edit6;
   TEdit *Edit7;
   TEdit *Edit8;
   TEdit *Edit1;
   TEdit *Edit2;
   TEdit *Edit3;
   TLabel *Label5;
   TLabel *Label6;
   TLabel *Label7;
   TLabel *Label8;
   TLabel *Label1;
   TScrollBar *ScrollBar2;
   TEdit *Edit9;
   TLabel *Label2;
   TLabel *Label4;
   TEdit *Edit4;
   TScrollBar *ScrollBar1;
   TButton *Button5;
   TBevel *Bevel1;
   TBevel *Bevel2;
   void __fastcall openbtnClick(TObject *Sender);
   void __fastcall SbtnClick(TObject *Sender);
   void __fastcall TbtnClick(TObject *Sender);
   void __fastcall ScrollBar1Change(TObject *Sender);
   void __fastcall Button1Click(TObject *Sender);
   void __fastcall TimgMouseMove(TObject *Sender, TShiftState Shift, int X,
          int Y);
   void __fastcall Button2Click(TObject *Sender);
  void __fastcall HimgMouseDown(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
   void __fastcall Button3Click(TObject *Sender);
   void __fastcall Button4Click(TObject *Sender);
   void __fastcall ScrollBar2Change(TObject *Sender);
   void __fastcall Button5Click(TObject *Sender);
   void __fastcall HimgMouseMove(TObject *Sender, TShiftState Shift, int X,
          int Y);
private:	// User declarations
public:		// User declarations
   __fastcall TForm1(TComponent* Owner);
   int __fastcall TForm1::N(int i,int j);
   int __fastcall TForm1::S(int i,int j);
   int __fastcall TForm1::Gx(int i,int j);
   int __fastcall TForm1::Gy(int i,int j);
   int __fastcall TForm1::check(int i,int j);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
