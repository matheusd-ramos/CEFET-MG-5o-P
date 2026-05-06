#include "../CImg.h"
#include <iostream>

using namespace cimg_library;
using namespace std;

int main(int argc, char** argv) {
    // Carregando a imagem original
    CImg<unsigned char> imagem(argv[1]);
    
    // Filtro Horizontal
    CImg<float> kernelHorizontal(3, 3, 1, 1,
        -1, -1, -1,
         2,  2,  2,
        -1, -1, -1
    );
    
    // Filtro Vertical:
    CImg<float> kernelVertical(3, 3, 1, 1,
        -1,  2, -1,
        -1,  2, -1,
        -1,  2, -1
    );
    
    // Convertendo imagem para float para valores negativos
    CImg<float> imagemFloat = imagem.get_normalize(0, 255);
    
    // Aplicando a correlação (convolução) com os kernels
    CImg<float> resultadoHorizontal = imagemFloat.get_correlate(kernelHorizontal);
    CImg<float> resultadoVertical = imagemFloat.get_correlate(kernelVertical);
    
    // Normalizando os resultados para visualização (0-255)
    resultadoHorizontal.normalize(0, 255);
    resultadoVertical.normalize(0, 255);
    
    // Convertendo para unsigned char para salvar
    CImg<unsigned char> resultHorUchar(resultadoHorizontal);
    CImg<unsigned char> resultVerUchar(resultadoVertical);
    
    // Salvando as imagens resultado
    resultHorUchar.save("resultado_linhas_horizontais.png");
    resultVerUchar.save("resultado_linhas_verticais.png");
    
    return 0;
}