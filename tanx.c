/* Program for Exponential Series */
#include<stdio.h>
#include<conio.h>
 
void main()
{
    int i, n;
    float x, sum=1, t=1;
    //int i1, n1;
    float x1, sum1, t1,tan1;
    
    printf(" Enter the value for x : ");
    scanf("%f",&x);
     
    printf(" Enter the value for n : ");
    scanf("%d",&n);
     
    x=x*3.14159/180;
     
    t1=x;
    sum1=x;
    /* Loop to calculate the value of Cosine */
    for(i=1;i<=n;i++)
    {
        t=t*(-1)*x*x/(2*i*(2*i-1));
        sum=sum+t;
	      t1=(t1*(-1)*x*x)/(2*i*(2*i+1));
        sum1=sum1+t1;
			  
    }
     tan1 = sum1/sum ;
    printf(" The value of tan(%f) is : %.4f", x, tan1);
    getch();
}