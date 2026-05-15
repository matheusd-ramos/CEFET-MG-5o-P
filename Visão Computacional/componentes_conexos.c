#include <stdio.h>

void busca_profundidade(int largura, int altura, int img[largura][altura], 
         int x, int y, int c, int componente[largura][altura]){
    
    // Verifica limites
    if(x < 0 || x >= largura || y < 0 || y >= altura) return;
    
    // Se já visitado ou não é pixel alto, retorna
    if(componente[x][y] != 0 || img[x][y] != 255) return;
    
    // Marca como visitado com o número da componente
    componente[x][y] = c;
    
    // Explora os 4 vizinhos (cima, baixo, esquerda, direita)
    busca_profundidade(largura, altura, img, x + 1, y, c, componente);
    busca_profundidade(largura, altura, img, x - 1, y, c, componente);
    busca_profundidade(largura, altura, img, x, y + 1, c, componente);
    busca_profundidade(largura, altura, img, x, y - 1, c, componente);
}

int main(){

    int largura, altura;
    scanf("%d %d", &largura, &altura);

    int img[largura][altura];

    for(int y=altura-1; y>=0; y--){
        for (int x=0; x<largura; x++){
            scanf("%d", &img[x][y]);
        }
    }

    // Normaliza a entrada: valores != 0 viram 255, 0 fica 0
    for(int y=altura-1; y>=0; y--){
        for (int x=0; x<largura; x++){
            img[x][y] = (img[x][y] != 0) ? 255 : 0;
        }
    }

    // Matriz paralela para marcar as componentes
    int componente[largura][altura];
    int componentes=0;

    // Inicializa todas as marcações como 0
    for(int y=altura-1; y>=0; y--){
        for (int x=0; x<largura; x++){
            componente[x][y] = 0;
        }
    }

    // Procura por pixels 255 não visitados
    for(int y=altura-1; y>=0; y--){
        for (int x=0; x<largura; x++){
            if(img[x][y] == 255 && componente[x][y] == 0){
                componentes++;
                busca_profundidade(largura, altura, img, x, y, componentes, componente);
            }
        }
    }

    printf("Componentes conexos: %d\n", componentes);

    return 0;
}