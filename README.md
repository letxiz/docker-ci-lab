# Atividade Docker + CI — Letícia Alves dos Santos

**Aluno(a):** Letícia Alves dos Santos  
**Turma:** Noturno  
**Data:** 23/07/2026  
**Aplicação usada:** docker/getting-started-app (To-Do em Node.js)

---

# 1. Como executar este projeto

```bash
git clone https://github.com/letxiz/docker-ci-lab.git
cd docker-ci-lab

cp .env.example .env

docker compose up -d --build
```

Acesse:

```
http://localhost:3000
```

Para parar os containers:

```bash
docker compose down
```

Para remover também os volumes:

```bash
docker compose down -v
```

---

# 2. Imagem e Dockerfile Multi-stage

## Estágios utilizados

- **Builder:** responsável por instalar as dependências e preparar a aplicação.
- **Final:** gera uma imagem menor contendo apenas os arquivos necessários para execução.

## Imagem base

```
node:20-alpine
```

## Usuário de execução

```
node (não-root)
```

## Tamanho final da imagem

```
286 MB
```

## Por que utilizar multi-stage?

O multi-stage build reduz o tamanho da imagem final ao remover arquivos temporários e dependências utilizadas apenas durante o processo de construção, tornando a aplicação mais leve, segura e eficiente.

## Print 1

Build da imagem Docker.

![Build Docker](docs/images/01-build-images.png)

---

## Print 2

Aplicação em execução.

![Aplicação](docs/images/02-app.png)

---

# 3. Volumes e Persistência

## Volume utilizado

```
todo-db
```

## Diretório utilizado

```
/etc/todos
```

## Print 3

Com volume: os dados permanecem armazenados mesmo após recriar o container.

![Com Volume](docs/images/03-com-volume.png)

---

## Print 4

Sem volume: ao remover o container, os dados são perdidos.

![Sem Volume](docs/images/04-sem-volume.png)

---

## Diferença entre `docker compose down` e `docker compose down -v`

- **docker compose down**: remove apenas os containers, preservando os volumes.
- **docker compose down -v**: remove os containers e também os volumes, apagando todos os dados persistidos.

---

# 4. Rede

## Rede criada

```
todo-net
```

## Containers conectados

- app
- db

## O banco de dados ficou exposto ao host?

Não. Apenas a aplicação consegue acessá-lo através da rede Docker.

## Como a aplicação encontra o banco usando apenas o nome `db`?

O Docker possui um DNS interno que resolve automaticamente o nome do serviço para o container correspondente.

## Print 5

Rede criada.

![Rede Docker](docs/images/05-network.png)

---

## Print 6

Container MySQL em execução.

![MySQL](docs/images/06-mysql.png)

---

# 5. Docker Compose

## Serviços

- app
- db

## Rede

```
todo-net
```

## Volume

```
todo-db
```

## Healthcheck

Foi utilizado um **healthcheck** para garantir que o banco esteja pronto antes da inicialização da aplicação.

## depends_on

```
condition: service_healthy
```

## Variáveis de ambiente

As credenciais foram armazenadas no arquivo `.env`. Apenas o arquivo `.env.example` foi versionado no GitHub.

## Print 7

Aplicação funcionando utilizando Docker Compose com persistência dos dados.

![Persistência Compose](docs/images/07-persistencia-compose.png)

---

## Print 8

Reset da persistência após executar `docker compose down -v`, demonstrando que o volume foi removido e os dados anteriores foram apagados.

![Reset do Volume](docs/images/08-compose-volume-reset.png)

---

# 6. GitHub Actions

## Workflow

```
.github/workflows/ci.yml
```

## Gatilhos

- push
- pull_request

## Etapas executadas

1. Validação do Docker Compose.
2. Build da imagem.
3. Inicialização da aplicação.
4. Execução do Smoke Test.
5. Finalização da stack.

## Print 9

Pipeline executado com sucesso.

![GitHub Actions Verde](docs/images/09-actions-verde.png)

---

# 7. Quebra proposital do CI

## O que foi quebrado?

Foi realizada uma alteração proposital na configuração da aplicação para provocar a falha do pipeline de Integração Contínua.

## Erro encontrado

Durante a execução do GitHub Actions, o pipeline falhou ao executar o Smoke Test, pois a aplicação não conseguiu ser validada corretamente.

## Como o CI reagiu?

O GitHub Actions interrompeu automaticamente a execução do workflow e marcou o pipeline como falho. Através dos logs foi possível identificar a etapa em que ocorreu o erro, facilitando a correção do problema.

## Como foi corrigido?

A configuração incorreta foi restaurada, um novo commit foi enviado para a mesma branch e o GitHub Actions executou novamente o pipeline, concluindo todas as etapas com sucesso.

## Print 10

Pipeline com falha após a quebra proposital.

![GitHub Actions Vermelho](docs/images/10-actions-vermelho.png)

---

## Como foi corrigido?

O arquivo `.env.example` foi restaurado com as configurações corretas. Após realizar um novo commit e push, o pipeline foi executado novamente com sucesso.

## Print 11

Pipeline executado com sucesso após a correção.

![GitHub Actions Corrigido](docs/images/11-actions-corrigido.png)

---

## Link do Pull Request

https://github.com/letxiz/docker-ci-lab/pull/1

---

# 8. Dificuldades e aprendizados

A principal dificuldade foi compreender o funcionamento do Docker Compose e como os serviços se relacionam. No entanto, eu já entendia alguns comandos básicos do Docker, o que facilitou o aprendizado.

Além disso, aprendi a importância dos volumes, das redes Docker e do GitHub Actions, percebendo na prática como a Integração Contínua ajuda a identificar erros rapidamente e aumenta a confiabilidade da aplicação.

---

# 9. Checklist

- [x] Dockerfile multi-stage
- [x] .dockerignore
- [x] Container utilizando usuário não-root
- [x] Volume nomeado
- [x] Persistência demonstrada
- [x] Rede criada
- [x] Docker Compose
- [x] Arquivo `.env.example`
- [x] GitHub Actions
- [x] Pull Request com pipeline vermelho → verde
- [x] Todos os prints adicionados

# CD — Publicação no Docker Hub

**Aluno(a):** Letícia Alves  
**Turma:** Noturno  
**Usuário do Docker Hub:** lekkkaxis  
**Imagem publicada:** lekkkaxis/docker-ci-lab:latest  
**Link da imagem no Docker Hub:** https://hub.docker.com/r/lekkkaxis/docker-ci-lab

**Dispara quando:** push na branch `main`  
**Arquivo do workflow:** `.github/workflows/cd.yml`

## Print 1 — Token criado no Docker Hub

![Token criado no Docker Hub](docs/images/12-token%20criado.png)

---

## Print 2 — Secrets cadastrados no GitHub (DOCKERHUB_USERNAME e DOCKERHUB_TOKEN)

![Chaves cadastradas no GitHub](docs/images/13-chaves-cadastradas.png)

---

## Print 3 — Workflow de CD verde na aba Actions

![CD - Publicar no Docker Hub](docs/images/14-cd%20-publicar%20no%20docker%20hub.png)

---

## Print 4 — Imagem publicada no Docker Hub

![Imagem publicada](docs/images/15-imagem-publicada.png)

---

## Print 5 — Docker Pull baixando a imagem publicada

![Docker Pull](docs/images/16-docker-pull.png)

---

# Respostas

### 1. O que é o Docker Hub?

O Docker Hub é um serviço de armazenamento de imagens Docker. Ele permite publicar, compartilhar e baixar imagens para que aplicações possam ser executadas em qualquer ambiente que tenha Docker instalado.

### 2. Diferença entre CI e CD

O CI (Continuous Integration) automatiza a validação do projeto, executando testes e verificando se a aplicação funciona após cada alteração enviada ao repositório. Já o CD (Continuous Delivery) automatiza a publicação da imagem Docker no Docker Hub, tornando-a disponível para uso.

### 3. Por que usar Token e Secrets em vez de escrever usuário e senha no `cd.yml`?

Porque os Secrets armazenam informações sensíveis de forma segura no GitHub. Assim, o usuário e o token não ficam expostos no código do repositório, reduzindo riscos de acesso não autorizado.

### 4. O que significa a tag `latest`?

A tag `latest` representa a versão mais recente da imagem publicada no Docker Hub. Sempre que uma nova imagem é enviada utilizando essa tag, ela passa a ser considerada a versão mais atual do projeto.