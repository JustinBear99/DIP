//---------------------------------------------------------------------------

#include <vcl.h>
#include <math.h>
#pragma hdrstop

#include "Unit1.h"

#define pi M_PI
//#define P  Bitmap1->Canvas->Pixels
//#define P2 Bitmap2->Canvas->Pixels
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
int P[520][520],P2[520][520],P3[520][520];
int A[520][1500];
int height,width;
int scale;
int linecount;
struct ln
{
   double a;
   double b;
} ;
ln line[20];

  Graphics::TBitmap *Bitmap1 = new Graphics::TBitmap();
  Graphics::TBitmap *Bitmap2 = new Graphics::TBitmap();
  Graphics::TBitmap *Bitmap3 = new Graphics::TBitmap();
  Graphics::TBitmap *Bitmap4 = new Graphics::TBitmap();


//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
   : TForm(Owner)
{
  height=0;
  width =0;
  scale=35;         //累積方格大小
  linecount=0;
// Bitmap1->PixelFormat = (TPixelFormat)1;
// Bitmap2->PixelFormat = (TPixelFormat)1;
PageControl1->ActivePage=TabSheet1;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::openbtnClick(TObject *Sender)
{
OpenDialog1->Filter = "BMP檔案|*.BMP";
if(OpenDialog1->Execute())
 origin->Picture->LoadFromFile(OpenDialog1->FileName);

origin->Picture->Bitmap->PixelFormat=(TPixelFormat)6;
Bitmap1->Assign(origin->Picture);
Simg->Picture->Assign(Bitmap1);
PageControl1->ActivePage=TabSheet1;

 width=origin->Width;
 height=origin->Height;
//Edit1->Text= N(10,10);

}
//---------------------------------------------------------------------------
int __fastcall TForm1::N(int i,int j)
{
int m,n,count=0;
int p[10];                          //   8 1 4
                                    //   7 6 5
p[1]=P[i  ][j];
p[2]=P[i  ][j-1];
p[3]=P[i+1][j-1];
p[4]=P[i+1][j];
p[5]=P[i+1][j+1];
p[6]=P[i  ][j+1];
p[7]=P[i-1][j+1];
p[8]=P[i-1][j];
p[9]=P[i-1][j-1];

for(int m=2;m<=9;m++)
   if(p[m]!=0)
      count++;
/*
 for(n=-1;n<=1;n++)
  for(m=-1;m<=1;m++)
    if(P[i+m][j+n]>0 && (m!=0 && n!=0))
      count++;
*/
return(count);
}
//----------------------------------------------------------------------------
int __fastcall TForm1::S(int i,int j)
{
int m,n,count=0,t;                  //   9 2 3
int p[10];                          //   8 1 4
                                    //   7 6 5
p[1]=P[i  ][j];
p[2]=P[i  ][j-1];
p[3]=P[i+1][j-1];
p[4]=P[i+1][j];
p[5]=P[i+1][j+1];
p[6]=P[i  ][j+1];
p[7]=P[i-1][j+1];
p[8]=P[i-1][j];
p[9]=P[i-1][j-1];

for(int m=2;m<9;m++)
{
   if(p[m]==0 && p[m+1]!=0)
      count++;
}
if(p[9]==0 && p[2]!=0)
   count++;
/*
 m=0,n=(-1);
//  for(i=0;i<8;i++)
 t=P[i+m][j+n];
 m++;
 if(t==0 && P[i+m][j+n]!=0)
   count++;

 t=P[i+m][j+n];
 n++;
 if(t==0 && P[i+m][j+n]!=0)
   count++;

 t=P[i+m][j+n];
 n++;
 if(t==0 && P[i+m][j+n]!=0)
   count++;

 t=P[i+m][j+n];
 m--;
 if(t==0 && P[i+m][j+n]!=0)
   count++;

 t=P[i+m][j+n];
 m--;
 if(t==0 && P[i+m][j+n]!=0)
   count++;

 t=P[i+m][j+n];
 n--;
 if(t==0 && P[i+m][j+n]!=0)
   count++;

 t=P[i+m][j+n];
 n--;
 if(t==0 && P[i+m][j+n]!=0)
   count++;

 t=P[i+m][j+n];
 m++;
 if(t==0 && P[i+m][j+n]!=0)
   count++;
*/

   return(count);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::SbtnClick(TObject *Sender)
{

int i,j,k,w,h;
int flag;

Byte *ptr,*ptr2;
Bitmap1->Assign(Simg->Picture);
Bitmap2->Assign(Bitmap1);



for(int i=0;i<Bitmap1->Height;i++)
 {
 ptr  = (Byte *)Bitmap1->ScanLine[i];
 for(int j=0;j<Bitmap1->Width;j++)
  {
   if( ptr[j*3] ==0)
      P2[j][i]=0 ;
   else
      P2[j][i]=1;
  }
 }



k=0;
while(flag)
{
flag=0;
k++;
for(int j=0;j<Bitmap2->Height;j++)
   for(int i=0;i<Bitmap2->Width;i++)
      P[i][j]=P2[i][j];

for(int j=0;j<Bitmap2->Height;j++)
   for(int i=0;i<Bitmap2->Width;i++)
     {
      if(P[i][j]!=0)
       if(N(i,j)>=2 && N(i,j)<=6)
        if(S(i,j)==1)
         if(P[i][j-1] * P[i+1][j] * P[i][j+1] ==0 )
          if(P[i-1][j] * P[i+1][j] * P[i][j+1] ==0 )
            {P2[i][j]=0;
             flag++;
            }
     }

for(int j=0;j<Bitmap2->Height;j++)
   for(int i=0;i<Bitmap2->Width;i++)
      P[i][j]=P2[i][j];

for(int j=0;j<Bitmap2->Height;j++)
   for(int i=0;i<Bitmap2->Width;i++)
     {
      if(P[i][j]!=0)
       if(N(i,j)>=2 && N(i,j)<=6)
        if(S(i,j)==1)
         if(P[i][j-1] * P[i+1][j] * P[i-1][j] ==0 )
          if(P[i-1][j]* P[i][j-1] * P[i][j+1] ==0 )
            P2[i][j]=0;
     }
}

for(int i=0;i<Bitmap2->Height;i++)
 {
 ptr2 = (Byte *)Bitmap2->ScanLine[i];
 for(int j=0;j<Bitmap2->Width;j++)
  {
   if(P2[j][i]==0)
      {ptr2[j*3]=0;
      ptr2[j*3+1]=0;
      ptr2[j*3+2]=0;
      }
   else
      {ptr2[j*3]=255;
      ptr2[j*3+1]=255;
      ptr2[j*3+2]=255;
      }
  }
 }

Simg->Picture->Assign(Bitmap2);
PageControl1->ActivePage=TabSheet2;
Label2->Caption=k;

}
//---------------------------------------------------------------------------


void __fastcall TForm1::TbtnClick(TObject *Sender)
{
Byte *ptr;
int r,g,b;
int gray;
int i,j;
int threshold;

threshold=ScrollBar1->Position;
Bitmap3->Assign(Bitmap1);
Bitmap4->Assign(Bitmap1);
Bitmap3->PixelFormat=6;
for(j=0;j<Bitmap3->Height;j++)
{
  ptr = (Byte *)Bitmap3->ScanLine[j];
  for(i=0;i<Bitmap3->Width;i++)
    {
    b=ptr[i*3];
    g=ptr[i*3+1];
    r=ptr[i*3+2];
    gray=0.299*r +0.587*g+0.114*b;
    if(gray>threshold)
      gray=255;
    else
      gray=0;


    ptr[i*3]=(Byte)gray;
    ptr[i*3+1]=(Byte)gray;
    ptr[i*3+2]=(Byte)gray;
    }

 }
Timg->Picture->Assign(Bitmap3);
PageControl1->ActivePage=TabSheet3;
}
//---------------------------------------------------------------------------
int __fastcall TForm1::Gx(int i,int j)
{
int gx;
int p[10];                          //   8 1 4
                                    //   7 6 5
p[1]=P3[i-1][j-1];
p[2]=P3[i  ][j-1];
p[3]=P3[i+1][j-1];
p[4]=P3[i-1][j  ];
p[5]=P3[i  ][j  ];
p[6]=P3[i+1][j  ];
p[7]=P3[i-1][j+1];
p[8]=P3[i  ][j+1];
p[9]=P3[i+1][j+1];

gx=(p[7]+2*p[8]+p[9])-(p[1]+2*p[2]+p[3]);


if(gx<0)
 gx=(-1)*gx;
//if(gx>255)
// gx=255;

 return(gx);

}
//---------------------------------------------------------------------------
int __fastcall TForm1::Gy(int i,int j)
{
int gy  ;
int p[10];                          //   8 1 4
                                    //   7 6 5
p[1]=P3[i-1][j-1];
p[2]=P3[i  ][j-1];
p[3]=P3[i+1][j-1];
p[4]=P3[i-1][j  ];
p[5]=P3[i  ][j  ];
p[6]=P3[i+1][j  ];
p[7]=P3[i-1][j+1];
p[8]=P3[i  ][j+1];
p[9]=P3[i+1][j+1];

gy=(p[3]+2*p[6]+p[9])-(p[1]+2*p[4]+p[7]);

if(gy<0)
 gy=(-1)*gy;

 return(gy);

}
//---------------------------------------------------------------------------
void __fastcall TForm1::ScrollBar1Change(TObject *Sender)
{
   Edit4->Text=ScrollBar1->Position;
      TbtnClick(Tbtn);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
Byte *ptr;
 for(int i=0;i<Bitmap3->Height;i++)
 {
 ptr  = (Byte *)Bitmap3->ScanLine[i];
 for(int j=0;j<Bitmap3->Width;j++)
  {
 //  if(  ==0)
      P3[j][i]=ptr[j*3] ;
  }
 }

for(int i=0;i<Bitmap3->Height;i++)
 {
 ptr = (Byte *)Bitmap3->ScanLine[i];
 for(int j=0;j<Bitmap3->Width;j++)
  {
//   if(Gx(j,i)==0)
      {ptr[j*3]=Gx(j,i)+Gy(j,i);
      ptr[j*3+1]=Gx(j,i)+Gy(j,i);
      ptr[j*3+2]=Gx(j,i)+Gy(j,i);
      }
/*   else
      {ptr[j*3]=255;
      ptr[j*3+1]=255;
      ptr[j*3+2]=255;
      }*/
  }
 }
Timg->Picture->Assign(Bitmap3);

int i,j,k,w,h;
int flag;

Byte *ptr2;
Bitmap1->Assign(Timg->Picture);
Bitmap2->Assign(Bitmap1);



for(int i=0;i<Bitmap1->Height;i++)
 {
 ptr  = (Byte *)Bitmap1->ScanLine[i];
 for(int j=0;j<Bitmap1->Width;j++)
  {
   if( ptr[j*3] ==0)
      P2[j][i]=0 ;
   else
      P2[j][i]=1;
  }
 }



k=0;
while(flag)
{
flag=0;
k++;
for(int j=0;j<Bitmap2->Height;j++)
   for(int i=0;i<Bitmap2->Width;i++)
      P[i][j]=P2[i][j];

for(int j=0;j<Bitmap2->Height;j++)
   for(int i=0;i<Bitmap2->Width;i++)
     {
      if(P[i][j]!=0)
       if(N(i,j)>=2 && N(i,j)<=6)
        if(S(i,j)==1)
         if(P[i][j-1] * P[i+1][j] * P[i][j+1] ==0 )
          if(P[i-1][j] * P[i+1][j] * P[i][j+1] ==0 )
            {P2[i][j]=0;
             flag++;
            }
     }

for(int j=0;j<Bitmap2->Height;j++)
   for(int i=0;i<Bitmap2->Width;i++)
      P[i][j]=P2[i][j];

for(int j=0;j<Bitmap2->Height;j++)
   for(int i=0;i<Bitmap2->Width;i++)
     {
      if(P[i][j]!=0)
       if(N(i,j)>=2 && N(i,j)<=6)
        if(S(i,j)==1)
         if(P[i][j-1] * P[i+1][j] * P[i-1][j] ==0 )
          if(P[i-1][j]* P[i][j-1] * P[i][j+1] ==0 )
            P2[i][j]=0;
     }
}

for(int i=0;i<Bitmap2->Height;i++)
 {
 ptr2 = (Byte *)Bitmap2->ScanLine[i];
 for(int j=0;j<Bitmap2->Width;j++)
  {
   if(P2[j][i]==0)
      {ptr2[j*3]=0;
      ptr2[j*3+1]=0;
      ptr2[j*3+2]=0;
      }
   else
      {ptr2[j*3]=255;
      ptr2[j*3+1]=255;
      ptr2[j*3+2]=255;
      }
  }
 }

//Simg->Picture->Assign(Bitmap2);


Timg->Picture->Assign(Bitmap2);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::TimgMouseMove(TObject *Sender, TShiftState Shift,
      int X, int Y)
{
double theta,rho,maxtemp,mintemp;
Edit1->Text=Gx(X,Y);
Edit2->Text= X;
Edit3->Text= Y;

maxtemp =0;
mintemp =0;
                for(double theta=0;theta<=360;theta++)
              {
                rho = X*cos(theta*2*pi/360) + Y*sin(theta*2*pi/360);
                if(rho>maxtemp)
                  maxtemp =rho;
                if(rho<mintemp)
                  mintemp =rho;
              }
Edit5->Text =maxtemp;
Edit6->Text =mintemp;

}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{

Byte *ptr;
int x,y;
//int i,j,ii,jj,p,q;
double theta,rho;
int t,r;
//int a,b;
int c;

c=0;

for(int j=0;j<1500;j++)
   for(int i=0;i<520;i++)
      A[i][j]=0;

 for(int i=0;i<Bitmap3->Height;i++)
 {
 ptr  = (Byte *)Bitmap3->ScanLine[i];
 for(int j=0;j<Bitmap3->Width;j++)
  {
   if( ptr[j*3] ==0)
      P3[j][i]=0 ;
   else
      P3[j][i]=1;
  }
 }
// rho = x*cos(theta) + y*sin(theta)
for(int y=0;y<Bitmap3->Height;y++)
   for(int x=0;x<Bitmap3->Width ;x++)
      {
         if(P3[x][y]!=0)
            {
              for(double theta=-90;theta<=90;theta++)
              {
                rho = x*cos(theta*2*pi/360) + y*sin(theta*2*pi/360);
                t=theta+90;
                r=rho+700;
                A[t][r]++;
              }

            }
      }

for(int i=0;i<Bitmap4->Height;i++)
 {
 ptr = (Byte *)Bitmap4->ScanLine[i];
 for(int j=0;j<Bitmap4->Width;j++)
  {

      ptr[j*3]=A[j][i*3]*2;
      ptr[j*3+1]=A[j][i*3]*2;
      ptr[j*3+2]=A[j][i*3]*2;
    if(A[j][i]>100)
      {
      c++;
      ptr[j*3]=0;
      ptr[j*3+1]=0;
      ptr[j*3+2]=255;

      }
  }
 }
 Edit7->Text = c;
 Himg->Picture->Assign(Bitmap4);
 PageControl1->ActivePage=TabSheet4;


/*
for(int j=0;j<Bitmap3->Height;j++)
   for(int i=0;i<Bitmap3->Width ;i++)
      {
         if(P3[i][j]!=0)
            {
            for(int q=0;q<Bitmap3->Height;q++)
               for(int p=0;p<Bitmap3->Width ;p++)
               {
                  if(p!=i && q!=j)
                  {
                     if(P3[p][q]>0)
                     for(int a=0;a<512;a++)
                     {
                        b= (-a*(i+p)+(j+q))/2;
                        A[a][b]++;
                     }

                  }

               }
            }

      }


for(int i=0;i<Bitmap3->Height;i++)
 {
 for(int j=0;j<Bitmap3->Width;j++)
  {
   if(A[j][i]>10)
      Edit4->Text = A[j][i];
  }
 }
 */
//Timg->Picture->Assign(Bitmap3);
}
//---------------------------------------------------------------------------






void __fastcall TForm1::HimgMouseDown(TObject *Sender, TMouseButton Button,
      TShiftState Shift, int X, int Y)
{
Edit8->Text = A[X][Y*3];
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
int c;
c=0x00000000;
origin->Canvas->Pen->Color = c;
origin->Canvas->MoveTo(100,100);
origin->Canvas->LineTo(400,100);

c=0x000000f0;
origin->Canvas->Pen->Color = c;
origin->Canvas->MoveTo(100,200);
origin->Canvas->LineTo(400,200);

c=0x0000f000;
origin->Canvas->Pen->Color = c;
origin->Canvas->MoveTo(100,300);
origin->Canvas->LineTo(400,300);

c=0x00f00000;
origin->Canvas->Pen->Color = c;
origin->Canvas->MoveTo(100,400);
origin->Canvas->LineTo(400,400);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{
 Himg->Picture->Assign(Bitmap4);
int i,j;

for(j=0;j<1500;j+=scale)
   for(i=0;i<=180;i+=scale)
      {
        check(i,j);
      }


}
//---------------------------------------------------------------------------
int __fastcall TForm1::check(int i,int j)
{
int m,n;
int max;
int c;
max =0;

//linecount=0;
for(n=0;n<=scale;n++)
   for(m=0;m<=scale;m++)
      if(A[i+m][j+n]>max)
       {  max=A[i+m][j+n];
         line[linecount].a=(i+m-90)*2*pi/360;
         line[linecount].b=(j+n-700);
       }

   if(max> ScrollBar2->Position)
   {
      c=0x00f00000;
      Himg->Canvas->Pen->Color = c;
      Himg->Canvas->MoveTo(i,j/3);
      Himg->Canvas->LineTo(i+scale,j/3);
      Himg->Canvas->LineTo(i+scale,j/3+scale);
      Himg->Canvas->LineTo(i,j/3+scale);
      Himg->Canvas->LineTo(i,j/3);

      linecount++;

      Edit9->Text=linecount;
   }


}

void __fastcall TForm1::ScrollBar2Change(TObject *Sender)
{
int i,j;
 Himg->Picture->Assign(Bitmap4);
linecount=0;

for(j=0;j<1500;j+=scale)
   for(i=0;i<=180;i+=scale)
      {
        check(i,j);
      }


}
//---------------------------------------------------------------------------



void __fastcall TForm1::Button5Click(TObject *Sender)
{
Byte *ptr;
int i,k;
int x,y;

origin->Picture->Assign(Simg->Picture);

for(int k=0;k<linecount;k++)
for(int i=0;i<Bitmap1->Height;i++)
 {
 ptr  = (Byte *)origin->Picture->Bitmap->ScanLine[i];
 x  =  (line[k].b-(i*sin(line[k].a)))/cos(line[k].a);
 if(x>0 && x<510)
  {
   ptr[ 3*x ] =0;
   ptr[ 3*x+1 ] =0;
   ptr[ 3*x+2 ] =255;
  }
 }

//origin->Picture->Assign(Bitmap1);
PageControl1->ActivePage=TabSheet1;

/*
for(int k=0;k<=linecount;k++)
{
i=k;
origin->Canvas->Pen->Color = c;
origin->Canvas->MoveTo(line[i].b*sin(line[i].a),line[i].b*cos(line[i].a));
origin->Canvas->LineTo(line[i].b/sin(line[i].a),0);
origin->Canvas->LineTo(0,line[i].b/cos(line[i].a));

if( line[i].b*sin(line[i].a) * line[i].b*cos(line[i].a) )

}
*/
}
//---------------------------------------------------------------------------

void __fastcall TForm1::HimgMouseMove(TObject *Sender, TShiftState Shift,
      int X, int Y)
{
Edit2->Text= X;
Edit3->Text= Y*3;   
}
//---------------------------------------------------------------------------

