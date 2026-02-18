# fpgamm

Este repositório contém uma implementação em **Verilog HDL** de um módulo denominado `zero_cross_pulse`, desenvolvido para FPGAs da família GW1NZ da Gowin Semiconductor, em especial para a placa **Tang Nano 1K**. O módulo detecta cruzamentos por zero de uma tensão CA por meio de um sinal de entrada e gera um pulso de saída temporizado com atraso e duração definidos.

## Descrição do Projeto

O design implementa um circuito digital que, ao detectar qualquer borda no sinal de cruzamento por zero (`sinc`), aguarda um intervalo de tempo fixo de aproximadamente **4,17 ms** antes de produzir um pulso de saída de **1 ms** na saída `ctr1`. Esse comportamento reproduz a função de um multivibrador monoestável digital com temporização baseada em contagens de clock, ideal para aplicações de disparo em sistemas que requerem sincronismo com a rede elétrica, como controle de tiristores (TRIAC).

## Arquivos Principais

| Arquivo | Descrição |
|--------|-----------|
| `mm.v`  | Código Verilog do módulo `zero_cross_pulse`. |
| `mm.cst` | Arquivo de restrições de pinos para o dispositivo GW1NZ‑LV1QN48C6/I5, especificando as posições físicas dos sinais `ctr1`, `sinc` e `clk`. |

## Módulo Zero Cross Pulse

O módulo possui as seguintes interfaces:

```verilog
module zero_cross_pulse (
    input wire clk,   // clock de 27 MHz
    input wire sinc,  // sinal de zero crossing
    output reg ctr1   // pulso de saída
);
````

### Funcionamento

* Detecta qualquer borda no sinal `sinc` (tanto de subida quanto de descida).
* Inicia um contador de atraso de 112.590 ciclos de clock (~4,17 ms).
* Após o atraso, ativa a saída `ctr1` por 27.000 ciclos (~1 ms).
* A saída retorna ao nível baixo automaticamente após a duração do pulso.

## Restrição de Pinos

O arquivo `mm.cst` especifica a localização física dos sinais na FPGA:

* `ctr1` → pino 11
* `sinc` → pino 13
* `clk`  → pino 47

Esses pinos devem ser conectados conforme a topologia de hardware utilizada.

## Ferramentas de Desenvolvimento

Este projeto foi sintetizado e implementado utilizando o **Gowin FPGA Designer Education**, versão 1.9.11.03, visando o dispositivo **GW1NZ‑LV1QN48C6/I5**. O ambiente fornece suporte completo à síntese lógica, mapeamento de pinos e geração de bitstream.

## Aplicações

O módulo é adequado para controles sincronizados com a rede elétrica em aplicações como:

* disparo controlado de TRIACs em sistemas de controle de potência,
* geração de pulsos de controle temporizados a partir de zero crossing,
* interface entre sensores de fase e lógica digital em FPGA.

## Licença

O projeto está aberto para uso, modificação e compartilhamento conforme os termos definidos pelo autor.

