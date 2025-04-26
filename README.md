# 📦 Upload Firebase App

Este é um aplicativo Flutter desenvolvido para o teste técnico da Minitok LLC.  
Ele permite autenticação de usuários, upload de arquivos para o Firebase Storage, visualização, download e exclusão dos arquivos enviados.

## ✨ Funcionalidades

- Registro e login usando e-mail e senha
- Upload de qualquer tipo de arquivo (imagem, PDF, vídeo, etc.)
- Pré-visualização de arquivos antes do envio
- Listagem dos arquivos enviados
- Download e visualização dos arquivos
- Exclusão de arquivos com confirmação
- Interface simples, responsiva e fácil de usar

## 🧠 Arquitetura

O projeto segue o padrão de **Clean Architecture**, dividido em:

- `domain/` → Entidades e casos de uso
- `data/` → Datasources e repositórios
- `presentation/` → Cubits (BLoC) e páginas (UI)
- `core/` → Configurações globais e injeção de dependências
- `routes/` → Rotas nomeadas

Gerência de estado usando **Cubit** (flutter_bloc) e **injeção de dependência** com **GetIt**.

## 🛠 Tecnologias e pacotes usados

- Flutter SDK
- Firebase Authentication
- Firebase Storage
- file_picker
- url_launcher
- flutter_bloc
- get_it
- mocktail (para testes)

## 🚀 Como rodar o projeto

### 1. Clone o repositório

```bash
git clone git@github.com:viniciusbarross/upload-firebase.git
cd upload-firebase
