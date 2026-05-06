#include "CImg.h"

using namespace cimg_library;

int main (){

    CImg<unsigned char> image("imagens/lena_cinza.bmp");
    CImg<unsigned char> image_media(image.width(), image.height(), image.depth(), image.spectrum());

    int largura = image.width();
    int altura = image.height();

    // Para cada pixel
    cimg_forXY(image, x, y){
        int soma = 0;

        // Pega a vizinhança
        // x +- 1 e y +- 1
        for(int i = -1; i <= 1; i++){
            for(int j = -1; j <= 1; j++){
                int nx = x + i;     // Novo x
                int ny = y + j;     // Novo y
                
                // Se for borda, usa pixel mais próximo
                if(nx < 0) nx = 0;
                if(ny < 0) ny = 0;
                if(nx >= largura) nx = largura - 1;
                if(ny >= altura) ny = altura - 1;
                
                soma = soma + image(nx, ny);
            }
        }

        image_media(x, y) = soma / 9;
    }

    image_media.save();

    return 0;
}
 