#include "CImg.h"
#include  <iostream>
 
// Use the library namespace to ease the declarations afterward.
using namespace cimg_library;
using namespace std;
 
int main() {
 
  //Carrega imagem
  char str[] = "./img/milla.bmp";
  CImg<unsigned char> image(str); //image is initialized by reading an image file from the disk
 
  //Calcula distancia entre linhas para desenhar
  int largura, altura, num_linhas;
  int x, y;
  largura = image.width();
  altura = image.height();

  cout << "Digite o numero de linhas que serao desenhadas na imagem:" << endl;
  cin >> num_linhas;
  
  if (num_linhas <= 0 || num_linhas >= altura){
    cout << "Erro no numero de linhas (menor ou igual a zero ou maior que a altura da imagem)." << endl;
    return 0;
  }

  int passo_vertical = altura/num_linhas;

  cout << "Altura da imagem: " << altura << endl;
  cout << "Largura da imagem: " << largura << endl;
  cout << "Distancia entre linhas (em pixels): " << passo_vertical << endl;  
  
  /*Desenha linhas de cor azul R=0 (canal 0), G=0 (canal 1), B= 255 (canal 2)
  size_x	Image width().
  size_y	Image height().
  size_z	Image depth().
  size_c	Image spectrum() (number of channels). 
  */
  for (y=passo_vertical; y<altura; y=y+passo_vertical){ //para cada linha
    for (x = 0; x<largura; x++){ //percorre todos os pixels da linha
      image(x, y, 0, 0) = 0;
      image(x, y, 0, 1) = 0;
      image(x, y, 0, 2) = 255;
    }
  } 

  //Salva a imagem em arquivo bmp
  image.save("imagem_linhas.bmp");
   
  return 0;
}
