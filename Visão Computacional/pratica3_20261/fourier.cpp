#include "CImg.h"
#include <iostream>
#include <cmath>

using namespace cimg_library;
using namespace std;
 
int main(int argc, char *argv[]) {
    // Inicializando a imagem
    CImg<unsigned char> img(argv[1]);

    // Criando a imagem transformada
    CImgList<float> img_fft = img.get_FFT();

    // Pegando a magnitude
    CImg<float> img_real(img_fft[0]);

    // Pegando a parte imaginaria
    CImg<float> img_imagrinaria(img_fft[1]);

    // Declarando imagem para pegar espectro
    CImg<float> espectro(img.width(), img.height(), 1, 1, 0);

    cimg_forXY(img, x, y){
        float real_quadrado = pow(img_real(x, y), 2);
        float imag_quadrado = pow(img_imagrinaria(x, y), 2);

        espectro(x, y) = sqrt(real_quadrado + imag_quadrado);
    }

    CImg<float> espectro_ajustado(img.width(), img.height(), 1, 1, 0);

    cimg_forXY(img, x, y){
        espectro_ajustado(x, y) = 1 + log2(espectro(x, y));
    }

    espectro_ajustado.shift(espectro_ajustado.width() / 2, espectro_ajustado.height() / 2, 0, 0, 2);

    float max = espectro_ajustado(0, 0);
    float min = espectro_ajustado(0, 0);

    cimg_forXY(espectro_ajustado, x, y){
        if(espectro_ajustado(x, y) > max)
            max = espectro_ajustado(x, y);

         if(espectro_ajustado(x, y) < min)
            min = espectro_ajustado(x, y);
    }

    float amplitude = max - min;

    CImg<unsigned char> espectro_normalizado(img.width(), img.height());

    cimg_forXY(espectro_ajustado, x, y){
        float valor = espectro_ajustado(x, y) - min;
        espectro_normalizado(x, y) = (unsigned char) (valor / amplitude * 255);
    }

    espectro_normalizado.save("espectro_normalizado.png");

    return 0;
}