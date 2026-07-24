# Atividade Docker + CI — Letícia Alves dos Santos

**Aluno(a):** Letícia Alves dos Santos  
**Turma:** ITeam Noite  
**Data:** 23/07/2026  
**Aplicação usada:** docker/getting-started-app (To-Do em Node.js)

---

# 1. Como executar este projeto

```bash
git clone [URL DO SEU REPOSITÓRIO]
cd meu-projeto-docker

cp .env.example .env

docker compose up -d --build
```

Acesse:

```
http://localhost:3000
```

Para derrubar os containers:

```bash
docker compose down
```

ou

```bash
docker compose down -v
```

---

# 2. Imagem e Dockerfile Multi-stage

**Estágios utilizados**

- Builder: instalação das dependências da aplicação.
- Final: imagem enxuta utilizada para executar a aplicação.

**Imagem base**

```
node:20-alpine
```

**Usuário de execução**

```
node (não-root)
```

**Tamanho final da imagem**

```
286 MB
```

**Por que o multi-stage ajuda?**

O multi-stage reduz o tamanho da imagem final ao copiar apenas os arquivos necessários para execução da aplicação. Além disso, melhora a segurança ao evitar que arquivos temporários e ferramentas de build sejam incluídos na imagem final.

## Print 1

> docker build + docker images

```
docs/imagens/01-build-images.png
```

```md
![Build](docs/imagens/01-build-images.png)
```

---

## Print 2

Aplicação rodando com tarefas cadastradas.

```md
![Aplicação](docs/imagens/02-app.png)
```

---

# 3. Volumes e Persistência

**Volume utilizado**

```
todo-db
```

**Montado em**

```
/etc/todos
```

## Print 3

Sem volume: dados perdidos.

```md
![Sem volume](docs/imagens/03-sem-volume.png)
```

## Print 4

Com volume: dados preservados.

```md
![Com volume](docs/imagens/04-com-volume.png)
```

**Diferença entre `docker compose down` e `docker compose down -v`**

`docker compose down` remove apenas os containers e mantém os volumes. Já `docker compose down -v` remove também os volumes, apagando os dados persistidos.

---

# 4. Rede

**Rede criada**

```
todo-net
```

**Serviços conectados**

- app
- mysql

**Banco exposto ao host?**

Não. Apenas a aplicação precisa acessar o banco através da rede Docker.

**Por que o app consegue acessar o host mysql sem saber o IP?**

Porque o Docker possui um DNS interno que resolve automaticamente o nome do serviço para o container correspondente.

## Print 5

```md
![Network](docs/imagens/05-network.png)
```

## Print 6

```md
![MySQL](docs/imagens/06-mysql.png)
```

---

# 5. Docker Compose

**Serviços**

- app
- db

**Rede**

```
todo-net
```

**Volume**

```
todo-db
```

**Healthcheck**

```
db
```

**depends_on**

```
condition: service_healthy
```

**Variáveis sensíveis**

Foram armazenadas em `.env`, mantendo apenas `.env.example` versionado.

## Print 7

```md
![Compose](docs/imagens/07-compose.png)
```

---

# 6. GitHub Actions

**Workflow**

```
.github/workflows/ci.yml
```

**Gatilhos**

- push
- pull_request

O pipeline realiza:

1. Validação do compose.
2. Build da imagem.
3. Inicialização da stack.
4. Smoke test da aplicação.
5. Finalização da stack.

## Print 8

```md
![CI Verde](docs/imagens/08-ci-verde.png)
```

---

# 7. Quebra proposital do CI

**O que foi quebrado**

> Preencher após realizar a quebra.

**Erro encontrado**

> Preencher.

**Como o CI reagiu**

> Preencher.

**Como foi corrigido**

> Preencher.

**Link do Pull Request**

```
[URL]
```

## Print 9

```md
![CI Vermelho](docs/imagens/09-ci-vermelho.png)
```

---

# 8. Dificuldades e aprendizados

Durante a atividade foi possível compreender como funciona a criação de imagens Docker utilizando multi-stage build, além da importância dos volumes para persistência de dados e das redes para comunicação entre containers. Também foi possível entender como o Docker Compose simplifica a orquestração da aplicação e como o GitHub Actions automatiza testes por meio da Integração Contínua (CI).

---

# 9. Checklist

- [x] Dockerfile multi-stage
- [x] .dockerignore
- [x] Container utilizando usuário não-root
- [ ] Volume nomeado
- [ ] Persistência demonstrada
- [ ] Rede criada
- [ ] Docker Compose
- [ ] .env.example
- [ ] GitHub Actions
- [ ] PR vermelho → verde
- [ ] Todos os prints adicionados