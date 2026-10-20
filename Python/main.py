import regras_negocio as rn


def ler_texto(mensagem):
    return input(mensagem).strip()


def ler_inteiro(mensagem):
    while True:
        texto = input(mensagem).strip()
        if texto.isdigit():
            return int(texto)
        print("Digite apenas números inteiros positivos.")


def ler_numero(mensagem):
    while True:
        texto = input(mensagem).strip().replace(",", ".")
        partes = texto.split(".")
        numero_valido = True

        if len(partes) > 2:
            numero_valido = False
        else:
            for parte in partes:
                if parte == "" or not parte.isdigit():
                    numero_valido = False

        if numero_valido:
            return float(texto)
        print("Digite um número válido. Exemplo: 1250,50")


def selecionar_usuario():
    if len(rn.usuarios) == 0:
        print("Cadastre um usuário primeiro.")
        return None

    print("\nUsuários cadastrados:")
    for usuario in rn.usuarios:
        print("- " + usuario["email"] + " | Perfil: " + usuario["perfil"])

    email = ler_texto("Digite seu e-mail: ").lower()
    for usuario in rn.usuarios:
        if usuario["email"] == email:
            print("Usuário selecionado.")
            return usuario

    print("Usuário não encontrado.")
    return None


def cadastrar_usuario():
    print("\n--- Cadastro de usuário ---")
    email = ler_texto("E-mail: ").lower()
    print("Perfis: arquiteto, tecnico, morador")
    perfil = ler_texto("Perfil: ").lower()
    if rn.cadastrar_usuario(email, perfil):
        for usuario in rn.usuarios:
            if usuario["email"] == email:
                return usuario
    return None


def menu_projetos(usuario):
    while True:
        print("\n--- Projetos ---")
        print("1 - Cadastrar cliente")
        print("2 - Cadastrar imóvel")
        print("3 - Cadastrar ambiente")
        print("4 - Criar projeto")
        print("5 - Vincular ambiente ao projeto")
        print("6 - Autorizar usuário no projeto")
        print("0 - Voltar")
        opcao = input("Escolha: ").strip()

        if opcao == "1":
            rn.cadastrar_cliente(
                usuario, ler_inteiro("ID do cliente: "),
                ler_texto("Nome do cliente: ")
            )
        elif opcao == "2":
            rn.cadastrar_imovel(
                usuario, ler_inteiro("ID do imóvel: "),
                ler_inteiro("ID do cliente: "), ler_texto("Endereço: ")
            )
        elif opcao == "3":
            rn.cadastrar_ambiente(
                usuario, ler_inteiro("ID do ambiente: "),
                ler_inteiro("ID do imóvel: "), ler_texto("Nome do ambiente: ")
            )
        elif opcao == "4":
            rn.cadastrar_projeto(
                usuario, ler_inteiro("ID do projeto: "),
                ler_texto("Nome do projeto: "), ler_inteiro("ID do imóvel: ")
            )
        elif opcao == "5":
            rn.adicionar_ambiente_projeto(
                usuario, ler_inteiro("ID do projeto: "),
                ler_inteiro("ID do ambiente: ")
            )
        elif opcao == "6":
            rn.autorizar_usuario_projeto(
                usuario, ler_inteiro("ID do projeto: "),
                ler_texto("E-mail do usuário: ").lower()
            )
        elif opcao == "0":
            break
        else:
            print("Opção inválida.")


def adicionar_dispositivo(usuario):
    print("\n--- Adicionar dispositivo ---")
    projeto_id = ler_inteiro("ID do projeto: ")
    dispositivo_id = ler_inteiro("ID do dispositivo: ")
    nome = ler_texto("Nome do dispositivo: ")
    ambiente_id = ler_inteiro("ID do ambiente: ")
    quantidade = ler_inteiro("Quantidade: ")
    preco = ler_numero("Preço unitário (R$): ")
    rn.adicionar_dispositivo_projeto(
        usuario, projeto_id, dispositivo_id, nome,
        ambiente_id, quantidade, preco
    )


def menu_dispositivos(usuario):
    while True:
        print("\n--- Dispositivos ---")
        print("1 - Adicionar dispositivo ao projeto")
        print("0 - Voltar")
        opcao = input("Escolha: ").strip()

        if opcao == "1":
            adicionar_dispositivo(usuario)
        elif opcao == "0":
            break
        else:
            print("Opção inválida.")


def mostrar_propostas(usuario):
    projeto_id = ler_inteiro("ID do projeto: ")
    lista = rn.consultar_propostas(usuario, projeto_id)
    if lista is None:
        return
    if len(lista) == 0:
        print("Nenhuma proposta encontrada para esse projeto.")
        return

    print("\nPropostas do projeto:")
    for proposta in lista:
        print(
            "ID:", proposta["id"],
            "| Versão:", proposta["versao"],
            "| Status:", proposta["status"],
            "| Total: R$ " + format(rn.calcular_orcamento(proposta["id"]), ".2f")
        )


def calcular_orcamento():
    proposta_id = ler_inteiro("ID da proposta: ")
    total = rn.calcular_orcamento(proposta_id)
    if total is not None:
        print("Total: R$ " + format(total, ".2f"))


def menu_propostas(usuario):
    while True:
        print("\n--- Propostas e orçamento ---")

        if usuario["perfil"] == "arquiteto":
            print("1 - Criar proposta")
            print("2 - Adicionar item à proposta")
            print("3 - Emitir proposta")
            print("4 - Criar nova versão")
            print("5 - Consultar propostas")
            print("6 - Calcular orçamento")
        elif usuario["perfil"] == "tecnico":
            print("1 - Consultar propostas")
            print("2 - Calcular orçamento")
        else:
            print("1 - Consultar propostas")
            print("2 - Aprovar ou recusar proposta")
            print("3 - Calcular orçamento")

        print("0 - Voltar")
        opcao = input("Escolha: ").strip()

        if usuario["perfil"] == "arquiteto":
            if opcao == "1":
                rn.criar_proposta(
                    usuario, ler_inteiro("ID da proposta: "),
                    ler_inteiro("ID do projeto: ")
                )
            elif opcao == "2":
                proposta_id = ler_inteiro("ID da proposta: ")
                tipo = ler_texto("Tipo (dispositivo ou servico): ").lower()
                descricao = ler_texto("Descrição: ")
                quantidade = ler_numero("Quantidade: ")
                preco = ler_numero("Preço unitário (R$): ")
                unidade = ""
                if tipo == "servico":
                    unidade = ler_texto("Unidade de cobrança (hora, visita, unidade): ")
                rn.adicionar_item_proposta(
                    usuario, proposta_id, tipo, descricao,
                    quantidade, preco, unidade
                )
            elif opcao == "3":
                rn.emitir_proposta(usuario, ler_inteiro("ID da proposta: "))
            elif opcao == "4":
                rn.criar_nova_versao_proposta(
                    usuario, ler_inteiro("ID da versão anterior: "),
                    ler_inteiro("ID da nova versão: ")
                )
            elif opcao == "5":
                mostrar_propostas(usuario)
            elif opcao == "6":
                calcular_orcamento()
            elif opcao == "0":
                break
            else:
                print("Opção inválida.")

        elif usuario["perfil"] == "tecnico":
            if opcao == "1":
                mostrar_propostas(usuario)
            elif opcao == "2":
                calcular_orcamento()
            elif opcao == "0":
                break
            else:
                print("Opção inválida.")

        else:
            if opcao == "1":
                mostrar_propostas(usuario)
            elif opcao == "2":
                rn.registrar_decisao_proposta(
                    usuario, ler_inteiro("ID da proposta: "),
                    ler_texto("Decisão (aprovada ou recusada): ").lower()
                )
            elif opcao == "3":
                calcular_orcamento()
            elif opcao == "0":
                break
            else:
                print("Opção inválida.")


def consultar_projeto(usuario):
    projeto_id = ler_inteiro("ID do projeto: ")
    projeto = rn.consultar_projeto(usuario, projeto_id)
    if projeto is not None:
        print("\nProjeto:", projeto["nome"])
        print("Imóvel:", projeto["imovel_id"])
        print("Ambientes:", projeto["ambientes"])
        print("Dispositivos:", projeto["dispositivos"])


def menu_principal(usuario):
    while True:
        print("\n" + "=" * 40)
        print("SISTEMA DE AUTOMAÇÃO RESIDENCIAL")
        print("Perfil:", usuario["perfil"])
        print("=" * 40)

        if usuario["perfil"] == "arquiteto":
            print("1 - Projetos")
            print("2 - Dispositivos")
            print("3 - Propostas e orçamento")
            print("4 - Consultar projeto")
            print("5 - Percentual de aprovação")
            print("6 - Trocar usuário")
        elif usuario["perfil"] == "tecnico":
            print("1 - Dispositivos")
            print("2 - Consultar projeto")
            print("3 - Propostas e orçamento")
            print("4 - Trocar usuário")
        else:
            print("1 - Consultar projeto")
            print("2 - Propostas e orçamento")
            print("3 - Trocar usuário")

        print("0 - Sair")
        opcao = input("Escolha: ").strip()

        if usuario["perfil"] == "arquiteto":
            if opcao == "1":
                menu_projetos(usuario)
            elif opcao == "2":
                menu_dispositivos(usuario)
            elif opcao == "3":
                menu_propostas(usuario)
            elif opcao == "4":
                consultar_projeto(usuario)
            elif opcao == "5":
                resultado = rn.calcular_percentual_aprovacao()
                if resultado == "Sem dados":
                    print("Sem dados.")
                else:
                    print("Percentual de aprovação: " + format(resultado, ".2f") + "%")
            elif opcao == "6":
                return "trocar"
            elif opcao == "0":
                return "sair"
            else:
                print("Opção inválida.")

        elif usuario["perfil"] == "tecnico":
            if opcao == "1":
                menu_dispositivos(usuario)
            elif opcao == "2":
                consultar_projeto(usuario)
            elif opcao == "3":
                menu_propostas(usuario)
            elif opcao == "4":
                return "trocar"
            elif opcao == "0":
                return "sair"
            else:
                print("Opção inválida.")

        else:
            if opcao == "1":
                consultar_projeto(usuario)
            elif opcao == "2":
                menu_propostas(usuario)
            elif opcao == "3":
                return "trocar"
            elif opcao == "0":
                return "sair"
            else:
                print("Opção inválida.")


def main():
    usuario = None
    while True:
        if usuario is None:
            print("\nSISTEMA DE AUTOMAÇÃO RESIDENCIAL")
            print("1 - Cadastrar usuário")
            print("2 - Selecionar usuário")
            print("0 - Sair")
            opcao = input("Escolha: ").strip()

            if opcao == "1":
                usuario = cadastrar_usuario()
            elif opcao == "2":
                usuario = selecionar_usuario()
            elif opcao == "0":
                print("Sistema encerrado.")
                break
            else:
                print("Opção inválida.")
        else:
            resultado = menu_principal(usuario)
            if resultado == "sair":
                print("Sistema encerrado.")
                break
            usuario = None


if __name__ == "__main__":
    main()
