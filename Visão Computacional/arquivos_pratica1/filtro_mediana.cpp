#include "CImg.h"

using namespace cimg_library;

int main (){

    CImg<unsigned char> image("imagens/lena_cinza.bmp");
    CImg<unsigned char> image_mediana(image.width(), image.height(), image.depth(), image.spectrum());

    int largura = image.width();
    int altura = image.height();

    // Para cada pixel
    cimg_forXY(image, x, y){
        int vizinhanca[9];

        // Pega a vizinhança
        // x +- 1 e y +- 1
        for(int i = -1; i <= 1; i++){
            for(int j = -1; j <= 1; j++){
                int k=0;            // Index da vizinhança
                int nx = x + i;     // Novo x
                int ny = y + j;     // Novo y
                
                // Se for borda, usa pixel mais próximo
                if(nx < 0) nx = 0;
                if(ny < 0) ny = 0;
                if(nx >= largura) nx = largura - 1;
                if(ny >= altura) ny = altura - 1;

                vizinhanca[k++] = image(nx, ny);
            }
        }

        std::sort(vizinhanca, vizinhanca + 9);
        int mediana = vizinhanca[4];
        imagem_mediana(x, y) = mediana;
    }

    imagem_mediana.save();

    return 0;
}
 