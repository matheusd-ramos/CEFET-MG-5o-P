#include "../CImg.h"
using namespace cimg_library;

int main (int argc, char* argv[]){

    // Carregando a imagem
    CImg<unsigned char> img(argv[1]);

    // Criando a máscara
    CImg<unsigned char> mask(3, 3, 3, 1, 1, 1);

    // Criando a imagem dilatada
    CImg<unsigned char> img_dilatada = img.get_dilate(mask);

    // Salvando a imagem resultado
    img_dilatada.save("resultado.bmp");

    // 3 iterações pra deixar o opencv top
    // 2 iterações pra deixar o figuras bala 10

    return 0;
}