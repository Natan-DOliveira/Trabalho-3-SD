# Trabalho de Sistemas Digitais 3

# Projeto de integração de componentes com múltiplos domínios de relógio

## Feito por: Natan Duarte de Oliveira

## Descrição:
Este projeto implementado em SystemVerilog é composto por um módulo **deserializador**, **fila** e um **top_module**. O deserializador recebe bytes seriais a 100 kHz, sincroniza os dados com uma fila operando a 10 kHz, e a fila armazena até 8 bytes, suportando enfileiramento (`enqueue_in`) e desenfileiramento (`dequeue_in`). Já o módulo top serve para integrar os outros módulos e gerar seus clocks. O projeto foi simulado usando o **Questa-Intel® FPGA Edition**.

## Estrutura do Projeto:
    ├── `rtl`/
    │   ├── deserializador.sv
    │   ├── fila.sv
    │   ├── top_module.sv 
    ├── `sim`/
    │   ├── `deserializador`/
    │   │   └── tb_deserializador.sv
    │   ├── `fila`/
    │   │   └── tb_fila.sv
    │   ├── `top_module`/
    │       └── tb_top_module.sv
    ├── README.md

## Instruções de Execução:

### - Pelo Linux(Windows com MSYS2 MINGW64 deve funcionar igual):
    1. Entre na pasta `./sim/`
    2. Escolha qual módulo quer testar e entre na pasta dele
    3. Execute o comando `vsim -do sim.do`

### - Pelo Windows:
    1. Abra o Questa-Intel® FPGA Edition
    2. Selecione: File --> Change Directory...
    3. Escolha qual módulo quer testar e entre na pasta dele `./sim/...`
    4. Pelo transcript execute o comando `do sim.do`

## Módulos:

### - **Deserializador**
    - Clock de 100Khz;
    - Recebe uma sequência de bits pelo sinal data_in e escreve palavras de 8 bits no sinal de saída 
    do módulo data_out, apenas se o write_in estiver alto.
    - Quando data_ready estiver alto os dados serão enviados para a fila, e até serem tratados por ela;
    - O Módulo ficará esperando o sinal ack_in alto para recomeçar;
    - Implementada com uma FSM como a descrita abaixo:


### - **Fila**
    - Clock de 10 KHz;
    - Estrutura FIFO (First-In, First-Out) de 8 bits que recebe seus nodos pelo sinal data_in e apenas 
    se o enqueue_in estiver alto. 
    - O sinal len_out indica o número de nodos na fila;
    - Para remover um item o sinal dequeue_in deve estar alto e o valor removido irá para
     o data_out no próximo ciclo;
    - Implementada com uma FSM como a descrita abaixo:


### - **Top Module**
    - Clock de 1MHz;
    - Integra os módulos deserializador e fila;
    - Gera os clocks para ambos os módulos e sincroniza suas entradas e saídas;

## Resultados:

### Para testar se estão corretos, cada módulo tem um TestBench implementado para ser testado no **Questa**.

### Foram feitos dois testes no testbench do `top_module` e seus resultados serão mostrados por imagens da forma de onda da simulação do Questa.

### - Teste 1: Caso Bom - Inserção e Remoção Balanceada
    - Insere o byte 0xAA e remove ele, depois insere o byte 0x55 e remove ele;
    - Imagem da forma de onda no Questa:
![Forma de Onda do Teste 1](https://i.imgur.com/gT7nTO6.png "Forma de Onda do Teste 1")
### - Teste 2: Caso Ruim - Fila Cheia
    - Insere 8 bytes 0xFF para o `len_out` chegar ao valor máximo de 8;
    - Depois tenta inserir um byte de 0x00 e fica travado pois não tem espaço na fila;
    - Imagem da forma de onda ao chegar na insersão com a fila já lotada no Questa:
![Forma de Onda do Teste 2](https://i.imgur.com/MNx1HUO.png "Forma de Onda do Teste 2")
    