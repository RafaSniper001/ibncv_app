# Guia Visual Oficial: IBN Cristo Vive (IBNCV_APP)

Este documento define os padrões de design para garantir que todo o aplicativo seja Tecnológico, Dinâmico e Acolhedor.

## Paleta de Cores (Brand Colors)
• Vermelho Primário: #D32F2F (Ação, Destaque, Paixão)
• Laranja/Amarelo: #FFC107 / #FFE0B2 (Energia, Espírito Santo)
• Fundo: #121212 (Escuro Tecnológico)
• Transparência: white ou white.withOpacity(0.1) (Efeito Vidro)

## O Conceito "Glassmorphism"
Todas as telas devem seguir a hierarquia de camadas:
1. Camada 1 (Fundo): Vídeo cristão em loop ou gradiente escuro.
2. Camada 2 (Overlay): Filtro de desfoque (`BackdropFilter`) com sigma 10-15.
3. Camada 3 (Conteúdo): Painéis de vidro (`GlassContainer`) com bordas arredondadas (15-25px) e bordas finas claras.

## Tipografia
• Títulos Solenes: Google Fonts `Cinzel` (Sempre em negrito para cabeçalhos).
• Corpo de Texto: Google Fonts `Inter` (Limpo e moderno para leitura).
• Slogan: "UMA IGREJA ACOLHEDORA" (Sempre em caixa alta com `letterSpacing: 1.2`).

## Componentes Reutilizáveis
Sempre que criar uma nova tela, utilize o widget `GlassContainer` para manter a consistência visual.

---
**Assinado:** Manus (Engenheiro Oficial do Projeto)
