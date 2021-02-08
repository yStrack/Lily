

# Lily 

[![Linguagem](https://img.shields.io/badge/Linguagem-Swift%205.3-orange)]()
[![Framework](https://img.shields.io/badge/Framework-SwiftUI_2.0-blue.svg)]()

Projeto mostrando o funcionamento de um App Clip e sua integração com o Apple Pay.

A explicação mais completa você pode encontrar no nosso artigo do [Medium](https://vitorkrau.medium.com/integrando-pagamentos-com-apple-pay-app-clip-8c999777a763).

## Demo
![Preview](https://ucface64f9a081548677b077b608.previews.dropboxusercontent.com/p/thumb/ABEt4z3vKGY-xzCPE4z7ALifDGBxNetfMdQo-CCNV-PtAC_rQkH9AEEb87HNRto2Js0Zz4UtnNetF9gdmcn1RFLaa0CFNXpV8U5rY7XWx7RBheyU0z3QLMvbVR0X0_df4JPDIjLLD6PSDTcTluAgFyGZS9cKi2G8P3gPzFs2Mzi02QJv4IMlOEt4UttKDkuENAgNGlL6yDK_WN53OrnW8inszDdMNUy9_eROkdR3EBvrbzcIHzQUpOVjyMg3eY50h1e-Dcp-upOJxqyy4r_9o4jZQckCkWY5HrdqqNc_hq65rLAknEYXSM7czBAqNI2S8EbOChPWGAEpAHxQ5kjf_bGE5UWsKbWjVYYlRcMBi68iXysVeUBb6Dl74e_YhhCziFoDuyb4ebyBNjo5gZgLw8ITm_bdKk-8KwsBXTuw1w7kO2WWH986Oovpnqe79XdEMwQ/p.png)


## Instalação

#### Cocoapods
Para instalar as dependências, na pasta raiz do projeto execute o comando:

```bash
pod install
```
A partir daí, sempre abra o projeto pelo .xcworkspace.

#### Python
Dentro da pasta **Server**:

Crie um Virtual Environment com o comando:

```bash
python3 -m venv env
```
Ative o Vitual Environment

MacOS
```bash
source env/bin/activate
```

Instale as dependências localizadas no arquivo requirements.txt
```bash
pip3 install -r requirements.txt
```

Por fim, atualize os campos dentro do projeto no Xcode assim como no server.py com as respectivas chaves pública e privada de teste fornecidas pela API do Stripe.

## Executando
Rode o projeto no simulador do iPhone, e antes de testar a funcionalidade do Apple Pay, abra o servidor. Dentro da pasta **Server**, execute o comando:

```bash
python3 server.py
```


## Contribuindo
Pull requests são bem-vindos. Para mudanças maiores, abra uma issue para conversarmos.
