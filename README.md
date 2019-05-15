# Portuguese (Brazil) Updates Repository for Windows POSReady 2009

Conjunto de atualizações para o POSReady 2009 para instalação manual e outras propostas, até Maio de 2019.

A relação, disponível em Tested (Files List).txt, inclui as atualizações de segurança do XP e POSReady 2009, Windows Media Player (leia mais abaixo), Windows Installer, MSXML e outros, incluindo hotfixes (os arquivos estão compactados como Tested.7z.00x).

NÂO estão incluidas:
- As atualizações para o .NET Framework. Estas podem ser obtidas de forma avulsa, diretamente da Microsoft, mas também de forma separada, através do projeto dotNetFx_AIO (https://pastebin.com/HRJGkvbe).
- Os Pacotes Redistribuíveis do Micorsoft Visual C++. Estas podem ser obtidas de forma avulsa diretamente da Microsoft, mas também de forma separada, através de repacks não oficiais que contém este e outros componentes (alguns até mais atualizados que os fornecidos oficialmente).
- O pacote de atuaizações do DirectX, de Junho de 2010.
- Programas como o Windows Defender, Transferência Fácil do Windows, Windows Live Essentials 2009, XPS Viewer, Temas Oficiais e Não Oficiais (Royale, Zune, Royale Noir e outros).
- Internet Explorer 8 (inclui apenas a atualização mais recente para referência) e MRT (pode baixar e instalar o pacote PT-BR e suas atualizações normalmente, seguindo a dica abaixo)

A pasta Optional contém algumas das atualizações opcionais lançadas exclusivamente para o POSReady 2009, disponível somente em inglês, além de atualizações não oficiais, do Movie Maker (que não vem instalado por padrão - instale a versão 2.0 e instale as atualizações correspondentes, que ele será atualizado para a 2.1) e mais.

Foi testado com o POSReady 2009 em inglês (EN-US) com a MUI PT-BR instalada. Para poder instalar as atualizações em PT-BR, é recomendável seguir a seguinte instrução (do contrário, dará erro, pois o sistema só aceitará as atualizações em EN-US):

HKEY_LOCAL_MACHINE > SYSTEM > CONTROLSET001 > CONTROL > NLS > LANGUAGE > Default: 0416
HKEY_LOCAL_MACHINE > SYSTEM > CONTROLSET001 > CONTROL > NLS > LANGUAGE > InstallLanguage: 0416
HKEY_LOCAL_MACHINE > SYSTEM > CONTROLSET001 > CONTROL > NLS > LOCALE > (Default): 000416
Painel de Controle > Opções Regionais e de idioma > aba "Opção Reginal" > aba "avançado" > opção Português (Brasil)

O sistema ficará em inglês mas será possível instalar as atualizações em PT-BR, mas não as EN-US. Para voltar ao normal, trocar os valores para 0409 e não mexer no Painel de Controle.

O POSReady 2009 vem com o Service Pack 3 instalado. Contudo, para melhor eficácia, recomendo reinstalá-lo manualmente, desta vez do idioma PT-BR, com o pacote WindowsXP-KB936929-SP3-x86-PTB, aliado às atualizações em PT-BR (entretanto, pode ter efeitos colaterais - um do que foi percebido nos testes foi o erro ao tentar alterar os recursos do sistema, deixando de funcionar). Infelizmente, ainda que o resultado seja razoavelmente satisfatório, a Central de Segurança e Firewall acabará permanecendo em inglês após a instalação de todas as atualizações.

Nem todas as atualizações PT-BR instalam com sucesso. Elas estão localizadas na pasta Failed. Somente as respectivas atualiações em inglês funcionarão ou não.

Não me responsabilizo por quaisquer problemas inerentes ao processo. Faça por sua conta e risco.
