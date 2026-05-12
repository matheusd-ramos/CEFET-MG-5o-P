#include "../CImg.h"
using namespace cimg_library;

int main (int argc, char* argv[]){

    // Carregando a imagem
    CImg<unsigned char> img(argv[1]);

    // Criando a máscara
    CImg<unsigned char> mask(3, 3, 3, 1, 1, 1);

    // Criando a imagem erodida
    CImg<unsigned char> img_erodida = img.get_erode(mask);

    // Salvando a imagem resultado
    img_erodida.save("resultado.bmp");

    return 0;
}