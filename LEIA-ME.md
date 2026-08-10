# Dashboard dos Sócios — publicação

Esta pasta **é** o site. O que estiver aqui é o que os membros veem.

- **`index.html`** — o dashboard. É o ficheiro de trabalho oficial: é este que se edita, não a cópia em `Dasboard Socios`.
- **`version.json`** — versão publicada. Gerado automaticamente, não mexer à mão.
- **`NOTAS.txt`** — o que mudou nesta atualização. A primeira linha aparece ao membro na faixa de aviso.
- **`.nojekyll`** — diz ao GitHub Pages para servir os ficheiros tal como estão.

---

## Arranque (uma só vez)

**1. Criar o repositório no GitHub**

Ir a [github.com/new](https://github.com/new) e preencher:

| Campo | Valor |
|---|---|
| Repository name | `ctm-socios` |
| Visibilidade | **Public** (o GitHub Pages gratuito exige) |
| Add a README file | **deixar desmarcado** |

Carregar em **Create repository**.

**2. Duplo clique em `PRIMEIRA_VEZ.bat`**

Envia tudo para o GitHub e abre um log no Notepad com o passo seguinte.

**3. Ligar o GitHub Pages**

No repositório: **Settings → Pages → Source: "Deploy from a branch" → Branch: `main` / `(root)` → Save**.

Passado 1 a 2 minutos o link fica activo:

```
https://cap1974.github.io/ctm-socios/
```

É este o link a dar aos membros.

---

## Cada atualização

1. Escrever em `NOTAS.txt` o que mudou (uma linha chega).
2. Duplo clique em **`PUBLICAR.bat`**.

O `.bat` trata do resto: carimba a versão nova, envia para o GitHub e abre um log a dizer se correu bem.

Quando o membro abrir a página aparece-lhe uma faixa verde **"Nova versão disponível — Recarregar"**. Os dados dele não se perdem: ficam guardados no browser, associados ao endereço do site, e a app migra automaticamente formatos antigos.

---

## Notas importantes

**O repositório é público, o link não é.** Qualquer pessoa com o endereço consegue abrir o dashboard. Só o link é que o protege. Se um dia precisar de controlo a sério, isso exige uma área de membros com autenticação — não dá para resolver só com um ficheiro HTML.

**Os dados nunca saem do computador do membro.** Ficam no armazenamento local do browser dele. Nem tu nem o GitHub lhes têm acesso — o que é um bom argumento de venda, mas também significa que, se ele limpar o histórico do browser sem ter exportado backup, perde tudo. A app avisa-o de 7 em 7 dias.

**Publicar duas vezes no mesmo dia** dá versões `2026.08.10`, `2026.08.10.1`, `2026.08.10.2` — cada uma reconhecida como mais recente que a anterior.

**Se o push falhar**, o log diz porquê e nada foi publicado. As causas habituais são o repositório ainda não existir no GitHub, ter outro nome, ou faltarem as credenciais.
