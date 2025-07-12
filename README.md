## **Projeto PUC251**
### **Introdução**
Projeto proposto durante a disciplina de Sistemas Reconfiguráveis, a PUC251 é uma simples CPU de arquitetura Harvard que foi desenvolvida em VHDL se utilizando do software Quartus II, versão 9.1sp2, e posteriormente foi testada na placa DE2 da Altera.
Este repositório contém todos os módulos produzidos ao longo das sprints do trabalho e, em sequência, o que foi solicitado em cada sprint será apresentado.

### **Dissertando as sprints**
#### Sprint 1
- **ALU:** realiza operações lógicas e aritméticas com palavras de 8 bits, e possui um total de 16 funções diferentes.
Recebe duas entradas `a_in` e `b_in`, e um *carry* `c_in`. Produz uma saída `r_out` específica, com base no seletor de operação `op_sel`, além de sinais de *carry out* (`c_out`), de zero (`z_out`) e de *overflow* (`v_out`).
#### Sprint 2
- **reg_bank**: conjunto de registradores que implementa um banco de registradores com quatro registradores de 8 bits cada
um, nomeados de R0 a R3. O registrador R3 armazena o status do processador. Os bits 0, 1 e 2 do registrador R3
armazenam, respectivamente, o resultado das saídas de c, z e v da ALU. Os demais bits de R3 não têm função
especial de status. A escrita é acontece com o sinal `regn_wr_ena` ativo e é sincronizada com o *clock*.
Já a leitura feita pela porta `regn_do` é assíncrona e se seleciona o registrador por meio da porta `regn_rd_sel`.
- **Wreg**: apenas um registrador de trabalho de 8 bits. A escrita é síncrona com o *clock* e acontece com o sinal `wr_en`.
Já a leitura é assíncrona e está sempre ativa.
- **stack**: uma pilha de 8 registradores de 11 bits.
Apresenta operações de *push* e de *pop*, e a ativação dessas é feita pelas portas `stack_push` e `stack_pop`.
- **prog_cnt**: contador de programa síncrono de 0 a 2047, com *reset* assíncrono e *load* síncrono.
Existe uma entrada para controle do funcionamento do contador, que seleciona entre o carregamento do valor
armazenado na *stack*, o carregamento de um novo valor para o contador ou o incremento do contador.
Quando nenhuma dessas funções estiver ativada, o PC permanece como está.
#### Sprint 3
- **port_io**: é uma porta de I/O paralela de 8 bits.
Cada pino pode ser individualmente programado para funcionar como entrada ou saída através do registrador `dir_reg`,
que pode ser lido e escrito em um endereço definido previamente.
O valor ‘0’ em um bit desse registrador (valor *default* após o *reset*) implica que o pino correspondente da porta
é uma entrada e o valor ‘1’ configura o pino correspondente como saída. Os pinos configurados como saída
recebem o valor escrito no registrador `port_reg`, que é um registrador apenas para escrita. O estado de todos
os pinos pode ser lido no mesmo endereço usado para escrever no registrador `port_reg`.
- **ram_2048x8**: bloco de memória RAM com 2048 registradores de 8 bits.
O registrador a ser lido ou escrito (depende de `mem_wr_en` ou de `mem_rd_en`) é selecionado pela porta `addr`.
#### Sprint 4
- **puc251**: com uma arquitetura Harvard, apresenta uma capacidade de 2048 instruções, cada uma com 16 bits, e uma memória de dados de 2048x8 bits.
Para efetuamente criar a CPU, os blocos anteriormente desenvolvidos foram interconectados em um arquivo de diagrama de bloco,
e os módulos faltantes foram ou criados (caso da Unidade de Controle), ou importados se utilizando do Mega Wizard Plugin Manager (caso da ROM).
De maneira a testar a CPU, um programa de teste foi criado se utilizando de LEDs como saída em que esses eram acessos um a um de maneira sequencial em uma dada direção.
Um switch foi utilizado para alterar a direção do acendimento dos LEDs. O teste foi executado tanto no simulador do Quartus, quanto na placa DE2.
### **Observações durante o uso**
- Este projeto não foi testado em nenhum outra versão do Quartus II, então se recomenda que instale a versão 9.1sp2.
- Como há pastas do projeto com links de referência para blocos em outras pastas, indica-se baixar todos os arquivos desse repositório para evitar conflitos e erros.
### **Autores**
- [Gabriel Luís Pinto Cecconello](https://www.linkedin.com/in/gabriel-cecconello/)
- [Paula Cristina Talim Gonçalves](https://www.linkedin.com/in/paulatalim/)
- [Rafael Vicente Souza e Paula](https://www.linkedin.com/in/rafael-vicente-8726a6204/)

### **Orientador**
- Francisco Manoel Pinto Garcia
