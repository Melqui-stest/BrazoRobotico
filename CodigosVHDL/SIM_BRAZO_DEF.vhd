----------------------------------------------------------------------------------
--Simulación del control digital del brazo robótico diseñado
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SIM_BRAZO_DEF is
--  Port ( );
end SIM_BRAZO_DEF;

architecture tb of SIM_BRAZO_DEF is
component BRAZO_DEF
 Port(
      clk : in std_logic;
      reset: in std_logic;-- será el reset(btnc)-btn0
 -----Stepmotor
      swdir : in std_logic;--control de la dirección--swt0
      swenable: in std_logic;--enable--desactiva todo
      swoff: in std_logic;--boton para activar o desactivar movimmiento sin tocar el enable, por que si activas el enable deja de haber movimiento pero tambien fuerza
     --desactiva movimiento pero mantiene fuerza
      swgirostep: in std_logic_vector(2 downto 0);--control del giro
      enable: out std_logic;--led0
      dir: out std_logic; -- 0 gira sentido horario y 1 sentido antihorario --led 4
      step : out std_logic; -- señal para cada micropaso--led5 
-----Servomotor
      swselservos0 : in std_logic;    --SW10
      swselservos1 : in std_logic;    --SW11
      swselservos2 : in std_logic;    --SW12
      swselservos3 : in std_logic;    --SW13
      swselservos4 : in std_logic;    --SW14
      swgiroservos: in std_logic_vector(3 downto 0);--ELECCION DE GIRO
      JD0: out std_logic;--señal de control servo 0
      JD1: out std_logic;--señal de control servo 1
      JD2: out std_logic;--señal de control servo 2
      JD3: out std_logic;--señal de control servo 3
      JD4: out std_logic;--señal de control servo 4
      JD5: out std_logic--señal de control servo 5
      );
 end component;
 ----------Señales
 ---Servomotor
 -- Inputs
   signal clk : std_logic;
   signal reset: std_logic;-- será el reset(btnc)
   signal swselservos0 : std_logic;    --SW10
   signal swselservos1 : std_logic;    --SW11
   signal swselservos2 : std_logic;    --SW12
   signal swselservos3 : std_logic;    --SW13
   signal swselservos4 : std_logic;    --SW14
   signal swgiroservos: std_logic_vector(3 downto 0);
   --Outputs
   signal JD0: std_logic;
   signal JD1 : std_logic;
   signal JD2 : std_logic;
   signal JD3 : std_logic;
   signal JD4 : std_logic;
   signal JD5 : std_logic;
 --Stepmotor
 --Inputps
 --signal clk : std_logic;
 --signal reset: std_logic;-- será el reset(btnc)
 signal swdir : std_logic;--control de la dirección(btnU)
 signal swenable: std_logic;--enable--desactiva todo
 signal swoff: std_logic;--enable--desactiva todo
 signal swgirostep:  std_logic_vector(2 downto 0);--control del giro
 --Outputs
 signal  dir: std_logic; -- 0 gira sentido horario y 1 sentido antihorario --led 4
 signal step : std_logic; -- señal para cada micropaso--led5
 signal enable: std_logic;--led0
begin
UnidadEnPruebas: BRAZO_DEF
  Port Map (
  --Stepmotor
              clk     =>  clk,
              reset   =>  reset,
              swdir  =>  swdir,
              swenable    =>  swenable,
              swoff    =>  swoff,
              swgirostep      =>  swgirostep,
              enable  =>  enable,
              dir     =>  dir,
              step    =>  step,
   --Servomotor
              swselservos0     =>  swselservos0,
              swselservos1    =>  swselservos1,
              swselservos2   =>  swselservos2,
              swselservos3     =>  swselservos3,
              swselservos4    =>  swselservos4,
              swgiroservos    => swgiroservos,
              JD0      =>  JD0,
              JD1      =>  JD1,
              JD2      =>  JD2,
              JD3      =>  JD3,
              JD4     =>  JD4,
              JD5      =>  JD5
    );
--------ESTÍMULOS
P_clk:process
begin
     clk <='0';
     wait for 5 ns;
     clk <='1';
     wait for 5 ns;
end process;
 
P_reset:process
begin
     reset <='1';
     wait for 100 ns;
     reset <='0';
     --Servos
     swselservos0<='0';
     swselservos1<='0';
     swselservos2<='0';
     swselservos3<='0';
     swselservos4<='0';
     swgiroservos<="1010";
     --Stepmotor
     swdir <= '0';
     swoff<='0';
     swgirostep<="000";
     --swgirostept<="111";
     swenable<='1';
     wait for 1000 ns;
     --Servos
     swselservos0<='1';
     swselservos1<='0';
     swselservos2<='1';
     swselservos3<='0';
     swselservos4<='0';
     swgiroservos<="1010";
     --Stepmotor
     swdir <= '1';
     swgirostep<="001";
     --swgirostept<="101";
     swenable<='0';
     wait for 100 ms;
     --Servos
     swselservos0<='0';
     swselservos1<='1';
     swselservos2<='0';
     swselservos3<='0';
     swselservos4<='0';
     swgiroservos<="0011";
     --Stepmotor
     swdir <= '1';
     swgirostep<="010";
     --swgirostept<="010";
     swenable<='0';
     wait for 400 ms;
     --Servos
     swselservos0<='0';
     swselservos1<='0';
     swselservos2<='0';
     swselservos3<='1';
     swselservos4<='0';
     swgiroservos<="1001";
     --Stepmotor
     swgirostep<="001";
     --swgirostept<="000";
     swenable<='0';
     swdir <= '0';
     wait for 400 ms;
     --Servos
     swselservos0<='0';
     swselservos1<='0';
     swselservos2<='0';
     swselservos3<='0';
     swselservos4<='1';
     swgiroservos<="0001";
     --Stepmotor
     swgirostep<="000";
     --swgirostept<="000";
     swenable<='0';
     swdir <= '0';
     wait for 1 ms;
     --Servos
     swselservos0<='1';
     swselservos1<='0';
     swselservos2<='0';
     swselservos3<='0';
     swselservos4<='1';
     swgiroservos<="1000";
     --Stepmotor
     swgirostep<="100";
     --swgirostept<="000";
     swenable<='0';
     swdir <= '0';
     wait;
  end process;
        
end tb;
