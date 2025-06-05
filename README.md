# Trabalho-SD-3

# Projeto de integração de componentes com múltiplos domínios de relógio

## Feito por: Natan Duarte de Oliveira

## Descrição:
Este projeto implementado em SystemVerilog composto por um **deserializador** e uma **fila FIFO**. O deserializador recebe bytes seriais a 100 kHz, sincroniza os dados com uma fila operando a 10 kHz, e a fila armazena até 8 bytes, suportando enfileiramento (`enqueue_in`) e desenfileiramento (`dequeue_in`). O projeto foi simulado usando o **Questa-Intel® FPGA Edition**.

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
│   │   └── tb_top_module.sv    
├── README.md

## Instruções de Execução:

    - Pelo Linux(Windows com MSYS2 MINGW64 deve funcionar):
    1. Entre na pasta `./sim/`
    2. Escolha qual módulo quer testar e entre na pasta dele
    3. Execute o comando `vsim -do sim.do`

    - Pelo Windows:
    1. Abra o **Questa-Intel® FPGA Edition**
    2. Selecione: File --> Change Directory...
    3. Escolha qual módulo quer testar e entre na pasta dele `./sim/...`
    4. Pelo transcript execute o comando `do sim.do`

## Aquitetura do Sistema:

## Módulos:

- **Deserializador**
    - Clock de 100Khz;
    - Recebe uma sequência de bits pelo sinal **data_in** e escreve palavras de 8 bits no sinal de saída do módulo **data_out**, apenas se o **write_in** estiver alto. Quando **data_ready** estiver alto os dados serão enviados para a fila, e até serem tratados por ela o módulo ficará esperando o sinal **ack_in** alto para recomeçar;
    - Implementada com uma FSM como a descrita abaixo:


graph TD
    AGUARDA -->|write_in=1| RECEBE
    RECEBE -->|bits_count==7| PRONTO
    PRONTO --> ESPERA
    ESPERA -->|ack_in=1| AGUARDA
    RECEBE -->|write_in=0| AGUARDA

    