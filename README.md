![Last Commit](https://img.shields.io/github/last-commit/santosjennifer/terraform)
[![CI](https://github.com/santosjennifer/terraform/actions/workflows/terraform_pipeline.yaml/badge.svg)](https://github.com/santosjennifer/terraform/actions/workflows/terraform_pipeline.yaml)

# Terraform AWS

Este repositório provisiona uma infraestrutura simples na AWS usando Terraform.

## Como o projeto está organizado

- `bootstrap/`: cria o bucket S3 `tfstate-terraform-santos`, usado para armazenar o estado remoto do Terraform.
- `terraform/`: provisiona a infraestrutura principal.
- `terraform/modules/web-server/`: módulo reutilizavel que cria rede, security group e instância EC2.
- `.github/workflows/`: pipelines de `plan`, `apply` e `destroy`.

## O que é criado

Depois que o bucket de estado existe, o Terraform principal cria:

- uma VPC com CIDR `10.0.0.0/16`
- uma subnet pública com CIDR `10.0.1.0/24`
- um Internet Gateway e rota para a internet
- um Security Group liberando HTTP (`80`)
- uma instância EC2 `t3.micro`
- instalação automática do Nginx via `user_data`

O AMI da instância é buscado dinamicamente com o datasource `aws_ami`, usando a imagem mais recente do Ubuntu 22.04.

## Fluxo do repositório

1. Executar o código de `bootstrap/` para criar o bucket do estado remoto.
2. Executar o código de `terraform/`, que usa esse bucket como backend S3.
3. O módulo `web-server` cria a rede e a VM web.
4. No final, o projeto expõe o IP público da instância e o ID da VPC.

## Como executar localmente

Pre-requisitos:

- Terraform instalado
- Credenciais AWS configuradas no ambiente
- Acesso a região `us-east-1`

### 1. Criar o backend remoto

```bash
cd bootstrap
terraform init
terraform apply
```

### 2. Provisionar a infraestrutura principal

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Outputs

Os principais outputs são:

- `web_public_ip`: IP público da instância EC2
- `web_vpc_id`: ID da VPC criada

## Automação com GitHub Actions

O repositório possui dois workflows:

- `terraform_pipeline.yaml`: em pull requests para `main`, roda `init`, `fmt`, `validate`, `plan` e depois `apply`
- `terraform_destroy.yaml`: em pushes para `main`, roda `terraform destroy --auto-approve`

## Observações

- O backend remoto está fixado no bucket `tfstate-terraform-santos`.
- A região configurada no backend e nas pipelines é `us-east-1`.
- O projeto está preparado para um ambiente simples de desenvolvimento, não para produção.
